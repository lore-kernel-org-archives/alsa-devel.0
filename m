From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: sta32x: Move resource allocation and
 release to the corresponding callback functions
Date: Thu, 18 Aug 2011 14:19:25 +0100
Message-ID: <4E4D115D.8090104@ti.com>
References: <1313652664.2917.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id DF7772417B
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 15:19:32 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 18/08/11 08:31, Axel Lin wrote:
> This patch includes below small fixes:
> 
> 1. Move sta32x_set_bias_level() from sta32x_i2c_remove() to sta32x_remove().
> 2. Remove a redundant regulator_bulk_free() call in sta32x_i2c_remove(),
>    as we will call regulator_bulk_free() in sta32x_remove().
> 3. Remove unneeded snd_soc_codec_set_drvdata(codec, NULL) in sta32x_i2c_remove.
>    The i2c core will set the clientdata to NULL.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Liam Girdwood <lrg@ti.com>
