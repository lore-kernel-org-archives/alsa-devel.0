From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Fri, 23 Apr 2010 12:10:47 +0800
Message-ID: <w2p4f3252891004222110k6ed35dd7x7c84860e1cd4c33b@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
	<alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>
	<4BD02061.2010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C0041245A1
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 06:10:52 +0200 (CEST)
Received: by pxi13 with SMTP id 13so708573pxi.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 21:10:51 -0700 (PDT)
In-Reply-To: <4BD02061.2010204@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/22 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> Jaroslav Kysela wrote:
> > On Wed, 21 Apr 2010, Stefan Schoenleitner wrote:
> >> I suspect that this is a bug in ALSA ?
> >
> > It might be. Could you post snd_pcm_dump() when you read less frames?
>
> Sure, here's the output:
>
> -----------------------------------------------------------------
> snd_pcm_avail_update(capture): 11
> demangled poll: POLLIN  on capture device
> could not read from capture device: Resource temporarily unavailable
> ALSA <-> PulseAudio PCM I/O Plugin
> Its setup is:
>  stream       : CAPTURE
>  access       : RW_INTERLEAVED
>  format       : S16_LE
>  subformat    : STD
>  channels     : 1
>  rate         : 8000
>  exact rate   : 8000 (8000/1)
>  msbits       : 16
>  buffer_size  : 640
>  period_size  : 160
>  period_time  : 20000
>  tstamp_mode  : NONE
>  period_step  : 1
>  avail_min    : 160
>  period_event : 0
>  start_threshold  : 160
>  stop_threshold   : 320
>  silence_threshold: 0
>  silence_size : 0
>  boundary     : 5764607523034234880
> -----------------------------------------------------------------
>
> As you can see I'm using pulseaudio.
> The version I'm using is 1:0.9.14-0ubuntu20 (on ubuntu jaunty).
>
> For testing purposes I increased the period size to 320 so that the
> program works on my hardware sound card "hw".
> It turned out that the program is working fine there and the poll()
> behavior is as it should be.
>
> cheers,
> stefan
>
>
you will need to provide the full pulseaudio log if you are using pulseaudio

pulseaudio --kill; pulseaudio -vvvv
