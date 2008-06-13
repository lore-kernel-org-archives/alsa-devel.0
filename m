From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 16:25:26 +0200
Message-ID: <20080613142526.GB21255@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id AFDA51037F7
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:25:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd4mlhlau.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 13.06.08 08:59, Takashi Iwai (tiwai@suse.de) wrote:

> About the latency, my proposal is like below:
> 
> - Renew the definition of hwptr -- make it what you imagned, the
>   pointer where hardware is reading or has read.
> 
>   This won't change anything for PCI drivers, so the impact is
>   minimal.

And it would suddenly make the USB drivers do the right thing ;-)

OTOH I am not a big fan of this solution, since the delay in
"snd_pcm_delay()" kind of suggests that it is useful for time
synchronization.

> - Add some new API functions,
>   * To give the accuracy of the position inquiry (optional)
> 
>     This requires some new kernel <-> user-space stuff.

I'd really like to have this. Only when I know this I can know how
near to the current hw_ptr I can actually still make changes in the
playback buffer.

>   * To query the known latency
> 
>     Ditto, or we may reuse snd_pcm_hw_params_fifo_size()?

I am not a fan of snd_pcm_hw_params_fifo_size() because the 'fifo'
latency is dynamic in the network case, it changes all the time with
the level of network congestion. However if something is part of
hw_params it is supposed to stay fixed, right? 

Hence I'd rather prefer if we let snd_pcm_hw_params_fifo_size() rest
in peace.

My personal favourite solution would actually be to have a new call
that allows you to query *all* timing related values
*atomically*. Why? different programs need different timing
information from ALSA. Also, timing information happens to change all
the time. If we just export two basic values, than people might end up
doing arithmetics on them, in the risk the two values are not
consistent with each other, since between querying them some time
already passed. So, what I would suggest is this:

  typedef enum snd_pcm_timing {
        SND_PCM_TIMING_ABSOLUTE_WRITE,
        SND_PCM_TIMING_ABSOLUTE_READ,
        SND_PCM_TIMING_ABSOLUTE_HEAR,
        SND_PCM_TIMING_WRITE_TO_READ,
        SND_PCM_TIMING_WRITE_TO_HEAR,
        SND_PCM_TIMING_READ_TO_HEAR,
        SND_PCM_TIMING_CAN_WRITE,
        SND_PCM_TIMING_LEFT_TO_PLAY
  } snd_pcm_timing_t;

  snd_pcm_sframes_t snd_pcm_get_timing(snd_pcm_t *pcm, snd_pcm_timing_t timing);

The user would just pass which of the timing values he needs. The
meaning would be:

        ABSOLUTE_WRITE: the current absolute write counter in samples, since the device was opened.
        ABSOLUTE_READ:  the current absolute read counter in samples, since the device was opened.
        ABSOLUTE_HEAR:  the current absolute hear counter in samples, since the device was opened.
        WRITE_TO_READ:  the current fill level of the playback buffer
        WRITE_TO_HEAR:  if i write a sample immediately after this call, how much time takes it to be played.
        READ_TO_HEAR:   the 'fifo' latency, i.e. the time that passes
                        after a sample was read form the playback buffer that it is
                        actually played.
        CAN_WRITE:      how much can be written into the buffer right
                        now  (buffer_size - WRITE_TO_READ)
        LEFT_TO_PLAY:   similar to WRITE_TO_HEAR but callable *after* we
                        wrote something, and it will return how much
                        of what we wrote has not been heard yet. In
                        contrast to WRITE_TO_HEAR this will return 0 eventually.        

snd_pcm_delay() would be identical to snd_pcm_get_timing(SND_PCM_TIMING_WRITE_TO_HEAR)

snd_pcm_update_avail() would be identical to snd_pcm_get_timing(SND_PCM_TIMING_CAN_WRITE).

Media players would use WRITE_TO_HEAR for doing their sync stuff. WINE
would use LEFT_TO_PLAY. PulseAudio would use WRITE_TO_READ to estimate
when the next XRUN might happen.

Of course, the fragment granularity would need to be added to this in
some way.

If we had an API like this we can also make sure that people
using this won't do invalid calculations. I mean, we have the
situation now that WINE does invalid calculations. If ALSA does all
the calculations for them and they just have to pick the one value
that suits what they need we'd have a much better chance that people
wouldn't misuse the ALSA API.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
