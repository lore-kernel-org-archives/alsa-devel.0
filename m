From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ssm2602: Do not dereference
	codec->control_data
Date: Tue, 20 Sep 2011 13:04:15 +0100
Message-ID: <20110920120414.GB2809@opensource.wolfsonmicro.com>
References: <1316499598-31539-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 447F61039AB
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 14:04:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316499598-31539-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2011 at 08:19:58AM +0200, Lars-Peter Clausen wrote:
> The driver assumes that control_data points to the drivers i2c_client struct,
> but this is no longer the case since the ASoC core has switched to regmap.

Applied, thanks.
