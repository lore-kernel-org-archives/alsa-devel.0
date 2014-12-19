From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2] ALSA: sound/atmel/ac97c.c: Add device
	tree support
Date: Fri, 19 Dec 2014 21:42:54 +0100
Message-ID: <20141219204254.GV4885@piout.net>
References: <1418241578-17049-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FCCD2604FA
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 21:42:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1418241578-17049-1-git-send-email-alexanders83@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexanders83@web.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On 10/12/2014 at 20:59:36 +0100, Alexander Stein wrote :
> +#ifdef CONFIG_OF
> +static const struct of_device_id atmel_ac97c_dt_ids[] = {
> +	{ .compatible = "atmel,atmel_ac97c", },

I would use atmel,at91sam9263-ac97c, we never now, maybe they will have
another ac97 IP at some point in time ;)

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, atmel_ac97c_dt_ids);
> +

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
