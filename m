From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [PATCH] emu10k1: add interval timer support
Date: Wed, 22 Sep 2004 11:01:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095865270.498.20.camel@krustophenia.net>
References: <1095405566.19045.35.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
	 <1095795402.13220.21.camel@krustophenia.net> <s5hacvizjzv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacvizjzv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-09-22 at 06:16, Takashi Iwai wrote:
> At Tue, 21 Sep 2004 15:36:42 -0400,
> Lee Revell wrote:
> > 
> > I am using kX ASIO as a reference for how multichannel PCM should work. 
> > From the application's point of view, this looks like 16 mono channels. 
> > In the mixer, for each of the 16 ASIO channels you have 4/8 drop down
> > boxes to set the FX send destinations and 4/8 sliders to set the send
> > amounts.  By default ASIO 1 goes to FXBus channel 0, 2 goes to FXBus 1,
> > etc.  Multiple applications can open the same ASIO channel and the
> > driver will allocate additional voices with the same send routing.
> > 
> > I think that the ALSA equivalent would be to have another device with
> > channels_min=channels_max=1, and 16 substreams for which the routing
> > would be controlled with the mixer; if multiple applications open the
> > same substream we would allocate another voice.  You would call
> > snd_pcm_period_elapsed for each of these streams in the handler for the
> > EFX capture interrupt.  All applications using this device must use the
> > same period size settings, as in the Windows driver, the only setting in
> > the ASIO control panel is the latency aka buffer size.
> >
> > You would then use an .asoundrc plugin that would look like a 16 channel
> > PCM device, and would consist of 16 mono channels, hw:x,x,0 through
> > hw:x,x,15.
> 
> Maybe I didn't get your point, but why not simply provide a 16-channel
> non-interleaved device?
> 

Several reasons.  With the kX driver, if I am using a ReWire host like
Ableton Live, and I want to use an app that is not ReWire capable, I
would have the app output to two extra ASIO channels, say 10 and 11, 
and Live can use these as inputs like any other physical input.  Live
would then output to ASIO 1/2 (front), ASIO 3/4 (rear), and ASIO 5/6
(headphones/prelisten).  It seems like the best way to do this in ALSA
is to have the driver support a bunch of mono channels and use alsalib
plugins to make multichannel devices out of these.

How would I open only channels 10 and 11 with one app and 1-6 with
another using a single 16 channel device?  

Also, it seemed like it would be easier to handle mmap with a bunch of
mono streams, but maybe I don't understand the mmap completely.  The OSS
driver for example does not support mmap for multichannel PCM.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
