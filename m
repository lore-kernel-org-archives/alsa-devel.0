From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Click after draining
Date: Sat, 16 Oct 2004 21:31:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041016213113.1744f887.pochini@shiny.it>
References: <20040921221318.4e0c7c7f.pochini@shiny.it>
	<20041007205801.6fb143ad.pochini@shiny.it>
	<s5hlleh5ilm.wl@alsa2.suse.de>
	<s5hhdp55h2e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdp55h2e.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 08 Oct 2004 18:07:53 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > ALSA seems not putting silence properly unless silence_size > 0.
> > How about the attached patch?
> > (it's an untested and quick fix, as usual :)
>
> And broken, as usual :)
> The corrected on is below.

The patch doesn't fix the problem.

With your patch snd_pcm_do_drain_init() does:

	if (! runtime->silence_size) {
		/* fill silence until the priod end */
		snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
		snd_pcm_uframes_t delta = appl_ptr % runtime->period_size;
		if (delta > 0)
			snd_pcm_lib_fill_silence(substream,
					appl_ptr % runtime->buffer_size,
					runtime->period_size - delta);
	}

In my case delta is always 0. It seems ALSA aligns appl_ptr to the offset of
the next period without silencing the current one. I could not find where.
Anyway, calling _fill_silence() with length=runtime->period_size - delta is
wrong IMHO because not all periods have have the same size. The last one can
be smaller and in that case it will overflow.

Also, I don't think filling with silence until the end of the period is
enough. ALSA stops the card some time it gets the interrupt, thus it should
silence also the subsequent period, or its beginning part.

Replacing the block above with the following code fixes the problem for me:

	if (!runtime->silence_size) {
		snd_pcm_uframes_t start, end;

		start = runtime->control->appl_ptr % runtime->buffer_size;
		end = runtime->status->hw_ptr % runtime->buffer_size;

		if (end < start) {
			snd_pcm_lib_fill_silence(substream, start, runtime->buffer_size - start);
			snd_pcm_lib_fill_silence(substream, 0, end);
		} else {
			snd_pcm_lib_fill_silence(substream, start, end - start);
		}
	}

* BUT it not the right fix *

It works fine when there are 3 or more periods, and in that case it writes
more stuff than needed (easily fixable). When there are only 2 periods it's
not enough. For example:

               per 0           per 1
Buffer:  |---------------|---------------|
                         ^^
               appl_ptr /  \ hw_ptr

Suppose period 0 is the last period to be played, so draining starts at its
end. My code fills just an handful of frames, and they may not be enough to
avoid the click when the card will reach the end of period 0 again. ALSA
should silence period 1 at the end of period 1. I don't know how to do it.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
