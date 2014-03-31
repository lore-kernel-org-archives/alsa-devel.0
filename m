From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Mon, 31 Mar 2014 20:53:14 +0200
Message-ID: <5339B99A.5090906@zonque.org>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 579BB26518B
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 20:53:16 +0200 (CEST)
In-Reply-To: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 03/31/2014 08:38 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Add a device tree match table. This serves to make the driver's support
> of device tree more explicit. Perhaps the fallback for DT matching to
> using the i2c_device_id table will go away one day, since it fails in
> face of devices from different vendors with the same name.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/codecs/alc5632.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
> index 3ee8d4e41a99..85942ca36cbf 100644
> --- a/sound/soc/codecs/alc5632.c
> +++ b/sound/soc/codecs/alc5632.c
> @@ -1190,11 +1190,18 @@ static const struct i2c_device_id alc5632_i2c_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, alc5632_i2c_table);
>  
> +static const struct of_device_id alc5632_of_match[] = {
> +	{ .compatible = "realtek,alc5632", },

In order to make them usable with the simple-card machine driver, all
codecs that have DT bindings should be visible in Kconfig. Maybe this
can be done in a subsequent patch though.


Daniel
