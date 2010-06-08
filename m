From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] EP93xx: Add i2s core support
Date: Wed, 9 Jun 2010 00:29:01 +0100
Message-ID: <079055B9-F238-400E-A94D-4B950A5C8C7B@opensource.wolfsonmicro.com>
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
	<1275991272-30122-2-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269763708AFD76@AUSP01VMBX24.collaborationhost.net>
	<4C0E9987.2010907@bluewatersys.com>
	(sfid-20100608_202716_363612_846D1CC6)
	<94CDC52C-12BD-447E-B0ED-5E3950FF89BA@opensource.wolfsonmicro.com>
	<4C0ED1B9.7020106@bluewatersys.com>
	(sfid-20100609_002659_105352_75064CA0)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3379524445
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 01:29:04 +0200 (CEST)
In-Reply-To: <4C0ED1B9.7020106@bluewatersys.com>
	(sfid-20100609_002659_105352_75064CA0)
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

On 9 Jun 2010, at 00:26, Ryan Mallon wrote:

> Patch 3 at least has a dependency on patch 1 for some #defines and the
> ep93xx_i2s functions calls.

Oh, in that case best if I take them both through ASoC unless someone anticipates issues there. I'll arrange things so they can also be merged into the ARM tree in case of issues.
