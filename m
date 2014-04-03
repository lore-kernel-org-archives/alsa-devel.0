From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42xx8: Check return value of
 regmap_read and report correct chipid value
Date: Thu, 3 Apr 2014 11:50:41 -0500
Message-ID: <alpine.DEB.2.02.1404031150170.3451@heelrod>
References: <1396511616.30532.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0057.outbound.protection.outlook.com [157.56.111.57])
 by alsa0.perex.cz (Postfix) with ESMTP id C24502656B1
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 18:50:40 +0200 (CEST)
In-Reply-To: <1396511616.30532.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

> Fix checking return value of regmap_read().
> Also fix reporting the chip_id value. CS42XX8_CHIPID_CHIP_ID_MASK is 0xF0,
> so the chip_id value is (val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4).
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>
