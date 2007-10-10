From: Joachim Foerster <mls.JOFT@gmx.de>
Subject: Re: How to enforce 32bit access?
Date: Wed, 10 Oct 2007 15:19:42 +0200
Message-ID: <1192022382.5545.9.camel@localhost>
References: <1191339247.30745.23.camel@localhost>
	<1191604193.5762.2.camel@localhost>  <s5h8x6cveo5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id D2FE02463D
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Oct 2007 15:19:45 +0200 (CEST)
In-Reply-To: <s5h8x6cveo5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Tue, 2007-10-09 at 11:08 +0200, Takashi Iwai wrote:
> At Fri, 05 Oct 2007 19:09:53 +0200,
> Joachim Foerster wrote:
> > 
> > Hi ALSA devs,
> > 
> > meanwhile I tried to put a constraint on SNDRV_PCM_HW_PARAM_FRAME_BITS
> > by the use of snd_pcm_hw_constraint_minmax() function with min=32 and
> > max=32, but still no success - the ALSA Library still makes 16bit
> > accesses, when playing mono (1 channel) files.
> > 
> > Any ideas?
> 
> Could you show the chain of plugins via aplay -v ?
> I'm not sure which plugin requires S16.  Possibly, the rate converter.

bash-3.00# aplay -v -M ../Absage.wav
Playing WAVE '../Absage.wav' : Signed 16 bit Little Endian, Rate 16000
Hz, Mono
Plug PCM: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 16000
  exact rate   : 16000 (16000/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 64000
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 4096
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Hardware PCM card 0 'Lorenz' AC97 Digital Controller' device 0
subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 16000
  exact rate   : 16000 (16000/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 64000
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 4096
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Bus error

The kernel messages because of the bus error are:
[22592.313922] Data machine check in kernel mode.
[22592.318321] Oops: machine check, sig: 7 [#1]
[22592.322552] NIP: c0003478 LR: c0003304 CTR: 0ff6c988
[22592.327482] REGS: c0230f50 TRAP: 0202   Not tainted
(2.6.23-rc2-g2f9f7e35-dirty)
[22592.334901] MSR: 00029030 <EE,ME,IR,DR>  CR: 22008084  XER: 00000000
[22592.341213] TASK = c3d82420[1049] 'aplay' THREAD: c2354000
[22592.346476] GPR00: 00000000 c2355f40 c3d82420 00004000 c2355e28
00000000 00000000 00030002
[22592.354769] GPR08: c3d82764 00000002 00029032 00000000 10020000
100254ac 00000000 10020000
[22592.363063] GPR16: 7fa4c480 7fa4c58c 00000001 7fa4c4a0 00000400
7fa4c460 00000001 00000000
[22592.371357] GPR24: 00000000 0ff6c988 00000002 00000004 000003fc
1002c6d0 0ffe6b1c 3001e010
[22592.379823] NIP [c0003478] do_user_signal+0x8/0xc4
[22592.384576] LR [c0003304] ret_from_crit_exc+0x0/0xf8
[22592.389498] Call Trace:
[22592.391922] [c2355f40] [c0003304] ret_from_crit_exc+0x0/0xf8
(unreliable)
[22592.398655] Instruction dump:
[22592.401595] 4819ae75 3d400002 614a1032 7d400124 54290024 81290028
71200004 40a2ffdc
[22592.409282] 71200002 4182fe14 614a8000 7d400124 <806100b0> 70600001
41820058 91a10044

But don't think that they are very useful. They occur as soon as the
alsa-lib reaches the line I described in my first mail.

 Joachim
