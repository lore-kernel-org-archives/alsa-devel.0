From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 4/7] ASoC: Fix Zylonite voice
	interface	stereo configurations
Date: Thu, 26 Feb 2009 11:03:14 +0100
Message-ID: <20090226100314.GB24575@buzzloop.caiaq.de>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
	<1235558902-20314-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090225160617.GH11203@buzzloop.caiaq.de>
	<20090225162241.GE31637@sirena.org.uk>
	<20090225164113.GI11203@buzzloop.caiaq.de>
	<20090225165458.GF31637@sirena.org.uk>
	<74d0deb30902260159ob8e750drcd539a63285a0c09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8438A10381B
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2009 11:03:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30902260159ob8e750drcd539a63285a0c09@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 26, 2009 at 10:59:16AM +0100, pHilipp Zabel wrote:
> >> The particular problem with the PXA SSP mode is that I've not yet seen=
 a
> >> configuration (neighter in slave nor in master mode) where it sends out
> >> 16 bits of left channel information, followed by 16 bits of zeros, then
> >> 16 bits of right channel and finally another 16bits of zeros (which
> >> exactly what they talk about in the 'i2s via ssp' application note).
> >> Has anyone ever got that?
> >
> > Not to my knowledge.
> =

> I think I've tried to do this by setting network mode with four slots
> =E0 16 bit data width, with a SFRMWDTH of 32 and only the first and
> third slot active (SSTSA[TTSA] =3D 0x5). During the inactive slots,
> SSPTXD should be forced low, as long as SSPSP[ETDS] is not set.
> It didn't work out, but I'm not sure whether I've set up everything
> correctly.

This is exactly how I understand the docs as well, so thanks for sharing
this :)

> My whole understanding of this SSP busineess is rather cloudy.

To me too, especially because the documents are faulty.

> Is that 'i2s via ssp' application note downloadable somewhere?

Only if you signed an NDA with Marvell :-/

Daniel
