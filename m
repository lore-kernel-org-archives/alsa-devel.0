From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adav80x: Remove .read_flag_mask
	setting from adav80x_regmap_config
Date: Fri, 14 Aug 2015 12:31:08 +0200
Message-ID: <55CDC36C.1050001@metafoo.de>
References: <1439546047.5150.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-208.synserver.de
 [212.40.185.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FBDB265192
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 12:31:11 +0200 (CEST)
In-Reply-To: <1439546047.5150.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/14/2015 11:54 AM, Axel Lin wrote:
> Don't set .read_flag_mask for adav803, it's for adav801 only.
> 
> Fixes: 0c2d69645628 ("ASoC: adav80x: Split SPI and I2C code into different modules")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
