From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [snd-bt87x] Prolink PixelView PlayTV
Date: Mon, 28 Apr 2008 12:59:00 +0200
Message-ID: <4815ADF4.1080208@ladisch.de>
References: <27da43c40804271746h3992cea5rd4626ec6b8776ec3@mail.gmail.com>
	<s5hlk2yi7qh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 5940C245F4
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Apr 2008 12:59:04 +0200 (CEST)
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

Takashi Iwai wrote:
> Jan Anders wrote:
> >  Warning: rate is not accurate (requested = 8000Hz, got = 119466Hz)
>
> The rate the driver suggested looks scary.

It's OK, this is the minimum rate supported by the hardware.
(It seems the same ADC is used for digitizing video and audio.)

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

This records from an analog input.
Does recording from the digital input device (hw:2,0) work?


Regards,
Clemens
