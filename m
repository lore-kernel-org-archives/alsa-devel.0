From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Q] playing / recording mono on a stereo-only
	hardware
Date: Fri, 5 Feb 2010 17:44:09 +0800
Message-ID: <4f3252891002050144p63b6cc38o3e44653132f7ae4a@mail.gmail.com>
References: <Pine.LNX.4.64.1001301045500.4260@axis700.grange>
	<Pine.LNX.4.64.1002021552450.6324@axis700.grange>
	<4B683DDC.5030209@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021606340.6324@axis700.grange>
	<4B6843E1.4050001@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021733550.6324@axis700.grange>
	<4f3252891002021807x4276d0b8y4c61c69aee2af3dc@mail.gmail.com>
	<Pine.LNX.4.64.1002032310230.19438@axis700.grange>
	<4f3252891002031612g5d384eb6o851f690f94b7945a@mail.gmail.com>
	<Pine.LNX.4.64.1002042120310.19438@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id CCCD424380
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 10:44:14 +0100 (CET)
Received: by pxi3 with SMTP id 3so3763970pxi.16
	for <alsa-devel@alsa-project.org>; Fri, 05 Feb 2010 01:44:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1002042120310.19438@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/5 Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> On Thu, 4 Feb 2010, Raymond Yau wrote:
>
> I would see your reply sooner, if you used reply-to-all.
>
> > if LIBASOUND_DEBUG = 1 cannot tell you which parameter fail in
> hw_params() ,
> > you will need to define RULES_DEBUG in alsa-kernel/core/pcm_native.c and
> > compile driver with debug=verbose
> >
> > -#undef RULES_DEBUG
> > +#define RULES DEBUG 1
>
> That's already on too. Not sure what you mean by "compile driver with
> debug=verbose," supposedly, some kernel ALSA debug parameter. Since this
> is my driver, I can certainly add any debugging there, but it seems
> obvious to me, that the kernel is still getting a mono configuration,
> which shouldn't be the cae.
>
> > you can find out how ALSA refine the hw parameters by examing the system
> log
>
> If you mean "dmesg" output, then, as I said, there isn't much to look for
> there - the kernel is configured for mono...
>
> Thanks
> Guennadi
>


your output is quite different from mine

arecord -v -f cd -c 1 -d 30 -r 8000 -Dplughw:1,0 any.wav
Recording WAVE 'any.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Plug PCM: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0*0.5 + 1*0.5
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 3968
  period_size  : 992
  period_time  : 124000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 992
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 3968
  silence_threshold: 0
  silence_size : 0
  boundary     : 2080374784
Slave: Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
