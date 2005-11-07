From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: + v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch
	added to -mm tree
Date: Mon, 07 Nov 2005 10:33:35 -0500
Message-ID: <1131377615.8383.9.camel@mindpipe>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
	 <20051106001249.48d3ade0.akpm@osdl.org> <1131301995.13599.5.camel@mindpipe>
	 <1131344803.10094.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964845AbVKGPgu@vger.kernel.org>
In-Reply-To: <1131344803.10094.8.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, nshmyrev@yandex.ru, v4l@cerqueira.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-11-07 at 04:26 -0200, Mauro Carvalho Chehab wrote:
> Lee,
>=20
> Em Dom, 2005-11-06 =E0s 13:33 -0500, Lee Revell escreveu:
> > On Sun, 2005-11-06 at 00:12 -0800, Andrew Morton wrote:
> > > Well that didn't work.  The problem is that
> > > drivers/media/video/saa7134/saa7134-alsa.c doesn't appear to be w=
ired
> > > up into the build system - it simply doesn't get compiled.
> > >=20
> > > Please send a fix against next -mm?=20
> >=20
> > Also please send all ALSA related patches to
> > alsa-devel@lists.sourceforge.net for review.
>=20
> 	I'm sending you enclosed saa7134-alsa patch. To make easier to
> understand, I've merged all stuff. This is highly dependent of the ot=
her
> saa7134 parts, since PCI stuff are common to both video and audio
> funcion on this device.
> 	This is meant to replace saa7134-oss (after more tests) that,
> currently, is part of saa7134 module.

OK, a brief review:

 - Why couldn't you use ALSA's DMA API?

 - The DMA must be stopped and started in the trigger callback, not the
prepare callback.

 - If this device lacks a volume control alsa-lib can emulate it in
software, just create a proper /usr/share/alsa/cards/your_card.conf
file.

 - By ALSA convention the acceptable formats, sample rates, etc should
be directly defined in the snd_pcm_hardware_t structure.

 - dev->oss needs to go.

Lee
