From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: S6000 ASoC drivers with multi-component
Date: Mon, 29 Nov 2010 11:34:03 +0100
Message-ID: <4CF3819B.5040507@emlix.com>
References: <20101128120702.GA12683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DCEF2450B
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 11:34:05 +0100 (CET)
In-Reply-To: <20101128120702.GA12683@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Zankel <chris@zankel.net>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 11/28/2010 01:07 PM, Mark Brown wrote:
> I'm a little concerned that there have been no updates to the s6000
> audio drivers since the merge of multi-component ASoC (which is now in
> mainline and should be released as part of 2.6.37).  This was a very
> big and invasive update, and experience with other architectures has
> been that there's usually at least some typos that need fixing.  It'd be
> good to get some confirmation that the audio drivers have at least been
> tested with current mainline - if everything worked fine that's
> obviously excellent but it'd be good if someone could confirm that this
> is the case.

Oh dear, you killed Schr=F6dinger's cat..

Yes there are some bugs in the s6000 ASoC code.
A missing semicolon at the end of s6000_i2s_dai, a lacking forward
declaration of s6000_soc_platform in the request_irq line, and a reference
to codec->snd_card which should probably be changed to codec->card->snd_car=
d.

But trying to build a s6105 kernel from vanilla sources made me realize
two things:
1. Nobody ever tried to do that before as s6000 support has been merged
   incompletely and in some cases with merge errors (variant_irq_disable
   declaration, I2C_BOARD_INFO in struct platform_device[], clk framework
   missing completely).
2. Compiling Xtensa kernels in general is broken at least since 2.6.35-rc1
   because of e520c41085

So for now I could just compile-test the ASoC changes. Actually booting a
kernel will probably take more of my spare time..
Would you like to have patches for the found ASoC bugs now or do you prefer
waiting until I could make it work on hardware?

  Daniel


-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
