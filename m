From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] EP93xx: Add i2s core support
Date: Wed, 9 Jun 2010 00:21:34 +0100
Message-ID: <94CDC52C-12BD-447E-B0ED-5E3950FF89BA@opensource.wolfsonmicro.com>
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
	<1275991272-30122-2-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269763708AFD76@AUSP01VMBX24.collaborationhost.net>
	<4C0E9987.2010907@bluewatersys.com>
	(sfid-20100608_202716_363612_846D1CC6)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 45B982443C
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 01:21:38 +0200 (CEST)
In-Reply-To: <4C0E9987.2010907@bluewatersys.com>
	(sfid-20100608_202716_363612_846D1CC6)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: "john.cooper@third-harmonic.com" <john.cooper@third-harmonic.com>, "chasedouglas@gmail.com" <chasedouglas@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "r&d4@dave-tech.it" <r&d4@dave-tech.it>, H Hartley Sweeten <hartleys@visionengravers.com>, "dhuggins@cs.cmu.edu" <dhuggins@cs.cmu.edu>, "marshall@coolbananas.co.nz" <marshall@coolbananas.co.nz>, "buytenh@wantstofly.org" <buytenh@wantstofly.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 8 Jun 2010, at 20:27, Ryan Mallon wrote:

> Okay, I have Liam and Hartley's acks on this one and Liam's on 3/3.
> Mark, do you want to apply the other two patches to your tree, or should
> they go via the arm tree?

I don't urgently mind for patch 1 since there's no build time dependency - in order to avoid possible merge issues in the ARM tree it's as well if it goes that way, though I can pick it up if it makes sense for you guys to keep stuff together and you don't anticipate colliding with any work in the arch/arm code for the CPU.

Patch 3 I'll apply to ASoC tomorrow, it depends on the I2S driver for the CPU which is most definitely ASoC (and it's going to get caught up in the multi-CODEC API changes soon as well so would get build issues in -next if merged via a different tree anyway).
