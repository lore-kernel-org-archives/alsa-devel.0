From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: core: Remove selects of regmap buses
Date: Sat, 18 Jun 2016 19:43:10 +0200
Message-ID: <5765882E.1020809@metafoo.de>
References: <1466168669-13140-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id CDD0E261685
 for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2016 19:43:16 +0200 (CEST)
In-Reply-To: <1466168669-13140-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/17/2016 03:04 PM, Mark Brown wrote:
> We used to have code wrapping the regmap I2C and SPI buses as part of
> the conversion of ASoC drivers from using the ASoC level I/O to the
> regmap level I/O.  Since all drivers have now been converted and the
> core code removed we can remove the per-bus selects and instead just
> select the regmap core.

I think there is a fair amount of CODEC drivers that don't yet select
REGMAP_{SPI,I2C} even though they use it. Merging this as is would break
them I'd assume.
