From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [snd-bt87x] Prolink PixelView PlayTV
Date: Mon, 28 Apr 2008 05:14:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0804280511230.11128@shell4.speakeasy.net>
References: <27da43c40804271746h3992cea5rd4626ec6b8776ec3@mail.gmail.com>
	<s5hlk2yi7qh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id 29DB1245FB
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Apr 2008 14:14:04 +0200 (CEST)
In-Reply-To: <s5hlk2yi7qh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Jan Anders <angreifen@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Apr 2008, Takashi Iwai wrote:
> At Mon, 28 Apr 2008 02:46:34 +0200,
> Jan Anders wrote:
> >
> > Hi,
> >
> > I'd like to report a working device:
> >
> >  Name: Prolink PixelView PlayTV
> >  Kernel: 2.6.23
> >  ID: 0x878-0x00:0x00
> >  Digital Rate: 128000 (I think)
> >
> > I can record mono fine with arecord:
> >
> >  % arecord -D hw:2,1 -f S16_LE -t wav test.wav
> >  Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> >  Warning: rate is not accurate (requested = 8000Hz, got = 119466Hz)
>
> The rate the driver suggested looks scary.  Something must be broken
> more deeply..

It's normal for the chip.  It does 8-bit mono at very high sample rates to
allow for software decoding of stereo TV audio.  I think 119466 Hz is the
lowest rate it supports, which is why is choose it when 8000 Hz was
requested.
