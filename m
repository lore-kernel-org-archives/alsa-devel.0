From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] Refresh ak4104 driver
Date: Wed, 22 Feb 2012 19:48:02 +0100
Message-ID: <4F453862.2050409@gmail.com>
References: <20120217202240.GA2784@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 653D2103B87
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 19:48:09 +0100 (CET)
Received: by bkcjc3 with SMTP id jc3so418264bkc.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:48:08 -0800 (PST)
In-Reply-To: <20120217202240.GA2784@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On 17.02.2012 21:22, Mark Brown wrote:
> This patch series updates the ak4104 driver to more modern idioms,
> mainly converting to regmap.  I've absolutely no ability to test this so
> there's a reasonable chance this will just explode but hopefully it
> should work fine.  Since all the read modify write, I/O and cache code
> was open coded in the driver we end up factoring out a reasonable
> amount.
> 
> Mark Brown (5):
>       ASoC: ak4104: Remove uninformative print on probe()
>       ASoC: ak4104: Convert to module_spi_driver()
>       ASoC: ak4104: Use snd_soc_update_bits() for read/modify/write
>       ASoC: ak4104: Use snd_soc_write() rather than internal write function
>       ASoC: ak4104: Convert to direct regmap API usage

The changes look all fine, but I can't test them either at the moment.
Just take my Ack on them and bring them in the loop. If someone yells,
I'll fix up things :)
