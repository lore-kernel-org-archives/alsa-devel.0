From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: add interval timer support
Date: Tue, 21 Sep 2004 15:36:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095795402.13220.21.camel@krustophenia.net>
References: <1095405566.19045.35.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-17 at 04:59, Jaroslav Kysela wrote:
> On Fri, 17 Sep 2004, Lee Revell wrote:
> 3) I don't like so much proposed scheduling as I stated in my previous 
>    e-mails; you cannot guarantee the right period boundary acknowledge
>    at all - there will be always some additional delay when more than one
>    stream is activated

OK, I think I see your point.  The channel loop interrupts give you
32/64 separate interrupt sources, where the timer interrupt is
monolithic, and won't work well with multiple streams using different
period sizes.

> 5) multichannel PCM should be created rather trying to do ugly things with
>    timer

This is my current project.  I almost have it working, but I have a few
questions.

I am using kX ASIO as a reference for how multichannel PCM should work. 
>From the application's point of view, this looks like 16 mono channels. 
In the mixer, for each of the 16 ASIO channels you have 4/8 drop down
boxes to set the FX send destinations and 4/8 sliders to set the send
amounts.  By default ASIO 1 goes to FXBus channel 0, 2 goes to FXBus 1,
etc.  Multiple applications can open the same ASIO channel and the
driver will allocate additional voices with the same send routing.

I think that the ALSA equivalent would be to have another device with
channels_min=channels_max=1, and 16 substreams for which the routing
would be controlled with the mixer; if multiple applications open the
same substream we would allocate another voice.  You would call
snd_pcm_period_elapsed for each of these streams in the handler for the
EFX capture interrupt.  All applications using this device must use the
same period size settings, as in the Windows driver, the only setting in
the ASIO control panel is the latency aka buffer size.

You would then use an .asoundrc plugin that would look like a 16 channel
PCM device, and would consist of 16 mono channels, hw:x,x,0 through
hw:x,x,15.

I am not sure of a few things.  Does it matter whether I use INTERLEAVED
or NONINTERLEAVED, since the device only supports mono streams?  Also,
since all capture and playback streams for this device will be updated
in the same interrupt handler, would it be best to use the linked
substreams feature of ALSA, or do this manually with list_for_each?

Lee 



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
