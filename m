From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sta32x: Move resource allocation and
 release to the corresponding callback functions
Date: Fri, 19 Aug 2011 01:21:16 +0900
Message-ID: <20110818162114.GE20208@opensource.wolfsonmicro.com>
References: <1313652664.2917.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2943C24490
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 18:21:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313652664.2917.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 18, 2011 at 03:31:04PM +0800, Axel Lin wrote:
> This patch includes below small fixes:
> 
> 1. Move sta32x_set_bias_level() from sta32x_i2c_remove() to sta32x_remove().
> 2. Remove a redundant regulator_bulk_free() call in sta32x_i2c_remove(),
>    as we will call regulator_bulk_free() in sta32x_remove().
> 3. Remove unneeded snd_soc_codec_set_drvdata(codec, NULL) in sta32x_i2c_remove.
>    The i2c core will set the clientdata to NULL.

Applied, thanks.
