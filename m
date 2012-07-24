From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 15:22:31 -0500
Message-ID: <500F0407.8090807@freescale.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ED032652B9
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 22:22:34 +0200 (CEST)
In-Reply-To: <1343161248-27557-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:

> +/*
> + * cs4270_of_match - the device tree bindings
> + */
> +static const struct of_device_id cs4270_of_match[] = {
> +	{ .compatible = "cirrus,cs4270", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cs4270_of_match);
> +

Why is this necessary?  The CS4270 driver works just fine on our
device-tree enabled boards.

-- 
Timur Tabi
Linux kernel developer at Freescale
