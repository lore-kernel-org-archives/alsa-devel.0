From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: ASoc : cs42xx8 : merge cs42xx8-i2c.c into cs42xx8.c
Date: Thu, 16 May 2019 06:34:47 +0000
Message-ID: <15b3a74a46f3c17f9240e5d90805e4056f80c55f.camel@nxp.com>
References: <e182bf72-c369-7344-e4d1-0524b09ca489@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3652CF80C18
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 08:34:48 +0200 (CEST)
In-Reply-To: <e182bf72-c369-7344-e4d1-0524b09ca489@flatmax.org>
Content-Language: en-US
Content-ID: <54999218004CDD4FA30925CF5C05F8F0@eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>, "flatmax@flatmax.org" <flatmax@flatmax.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Matt,

On Thu, 2019-05-16 at 16:15 +1000, Matt Flax wrote:
> Do you think it would be a good idea to merge cs42xx8-i2c.c into
> cs42xx8.c ?

I think it is fine to keep this separate. The i2c code is clean
and easy to understand.

> 
> Is there a reason to keep these two related driver functions separate
> ?
> 

cs42xxx codec has also an SPI interface. If anyone wants to implement
support for that it would be easier with the current split.

thanks,
Daniel.
