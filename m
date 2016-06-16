From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: codecs: Remove "select
 REGMAP_SPI/REGMAP_I2C"
Date: Thu, 16 Jun 2016 21:31:18 +0200
Message-ID: <5762FE86.4090005@metafoo.de>
References: <1466103612-8424-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B43F1265795
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2016 21:31:22 +0200 (CEST)
In-Reply-To: <1466103612-8424-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/16/2016 09:00 PM, Alexander Shiyan wrote:
> REGMAP_SPI and REGMAP_I2C is selected automatically by SND_SOC,
> so no additional actions is required.

To be honest I'd rather have this the other way around. Remove them from
SND_SOC and let every CODEC select them individually. That would be the
technically correct approach.

Otherwise if we want argue that a system using ASoC has probably at least
one CODEC device that either regmap SPI or regmap I2C and that's why it
makes sense for them to be selected automatically, we can also argue that
these days any system that has SPI or I2C support has likely one device that
either uses regmap SPI or regmap I2C, so they should always be enabled.
