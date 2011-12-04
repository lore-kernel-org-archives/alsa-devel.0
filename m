From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: uda1380: Return proper error in
 uda1380_modinit failure path
Date: Sun, 4 Dec 2011 13:00:18 +0000
Message-ID: <20111204130018.GA8461@sirena.org.uk>
References: <1322998520.12391.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0617C24711
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 14:00:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322998520.12391.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 04, 2011 at 07:35:20PM +0800, Axel Lin wrote:

> +	int ret = 0;
>  #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
>  	ret = i2c_add_driver(&uda1380_i2c_driver);
>  	if (ret != 0)
>  		pr_err("Failed to register UDA1380 I2C driver: %d\n", ret);
>  #endif
> -	return 0;
> +	return ret;

In cases like this where only I2C is supported it's best to just remove
all the ifdefs for I2C completely.
