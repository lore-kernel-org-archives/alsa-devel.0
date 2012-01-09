From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH v3] ASoC: jz4740: Convert qi_lb60 to use
	snd_soc_register_card()
Date: Mon, 9 Jan 2012 22:12:30 +0800
Message-ID: <CAF+7xW=x4mvod17gJXjGdTXA81k4ZoGmt3jC2yFb_KoR6eCcVg@mail.gmail.com>
References: <1325820610.10011.1.camel@phoenix>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id E486A24378
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 15:12:52 +0100 (CET)
Received: by lago2 with SMTP id o2so1343281lag.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 06:12:52 -0800 (PST)
In-Reply-To: <1325820610.10011.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2012/1/6 Axel Lin <axel.lin@gmail.com>:
> Use snd_soc_register_card() instead of creating a "soc-audio" platform device.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> v2: Fix a typo in v1.
> v3: Free the card before the GPIOs since the card uses the GPIOs

Hi Lars,
Any chance to test this patch if you think the patch is ok?

Thanks,
Axel
