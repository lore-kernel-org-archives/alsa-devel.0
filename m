From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Fri, 26 Feb 2010 17:38:02 +0800
Message-ID: <4f3252891002260138n36994557r209f12e41c8c5ae6@mail.gmail.com>
References: <20100216143200.GB25489@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
	<20100217130612.GD24165@tango.0pointer.de>
	<ad2655cb1002170555l462981cheff2b1798a14c9d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 81B6D103806
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 10:38:03 +0100 (CET)
Received: by pwi9 with SMTP id 9so5661669pwi.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 01:38:02 -0800 (PST)
In-Reply-To: <ad2655cb1002170555l462981cheff2b1798a14c9d0@mail.gmail.com>
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

2010/2/17 James Courtier-Dutton <james.dutton@gmail.com>

>
> This is a good aim, but I still think getting the correct 0dB points
> is more important to ensure the best audio quality.
> I personally think that PA should just set the hardware ALSA controls
> to 0dB and do all the volume control in software within PA.
> The 0dB points in hardware should result in the best sound quality.
>
> James
>
>
When you mix two stream of 16-bit audio and send to a 16 bit sound card ,
you have to add two 16-bit and shift right one bit ,

you have already add -3dB by software when perform soft mixing and you may
need to get +3dB gain in DAC if you want to maintain the same dB level if
one stream is actually silence

so set the hardware ALSA controls to 0dB is not that good for a sound server
