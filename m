From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Click after draining
Date: Wed, 20 Oct 2004 10:35:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20041020103534.pochini@shiny.it>
References: <s5hekjuiuom.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekjuiuom.wl@alsa2.suse.de>
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


On 19-Oct-2004 Takashi Iwai wrote:

>> >> >> > The period size is always same even for the last period, AFAIK.
>> >> >>
>> >> >> Only if the driver explicitly asks for it by calling
>> >> >> snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS).
>> >> >
>> >> > No, this means that buffer_size = N * period_size, where N is
>> >> > integer.  Without this constraint, N doesn't have to be an integer.
>> >>
>> >> Yes, exactly. If N isn't integer, the buffer is formed by
>> >> bufsize\persize periods (== the integer part of N) plus one
>> >> short period which is bufsize%persize long.
>> >
>> > The period size is constant regardless of N because it simply defines
>> > the interval of interrupts.  When N isn't integer (say, 2.5), the
>> > transfer point moves like:
>> >
>> >       0, 1, 2, 0.5, 1.5, 0, 1, ...
>> >
>> > That is, when the point is at 2, the transfer is split to two parts
>> > (2-2.5 and 0-0.5).
>>
>> Currently my driver uses a short period.
>
> Well, then this is not a supported feature.  period_size must be
> constant in the current implementation.

Ok, I'll add that constraint. I'm not sure if using that
DSP feature is worth the effort because those extra features
do not come for free. The driver has to do more work in the
irq handler and it has to send send one more command to the
DSP, which may be pretty slow on old 20-bits cards. I'll
evaluate it later. I would like to get the driver included
in alsa-driver asap, before starting to add support for the
new "3G" cards.


>> Anyway, _fill_silence() can still overflow.
>
> In your case, yes.  But it's exceptional.

No, it also happens with you example when
period_offs+period_len > buffer_size:

N=3.5:

first round:
0000000011111111222222223333

2nd:
3333444444445555555566666666
....

fill_silence(per=3, period_len) overflows.


> Usually, the DMA is stopped in the interrupt handler which processes
> the last period.  That is, the resolution of control is in the
> interrupt interval (= period_size).  This means that the whole period
> data is transferred even if only the short data has been written to
> the buffer.

Yes, I know, but the part from the last frame written by the app
and the end of the period is not silenced *and* appl_ptr is moved
to the end of the period before the call to drain_init(). I'm
still looking for the cause. Sorry for my slowness, but I don't
have a lot of time right now :(


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
