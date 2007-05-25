From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Fri, 25 May 2007 15:17:23 -0500
Message-ID: <46574453.10808@freescale.com>
References: <46531097.5040600@freescale.com>
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 337F9244ED
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 22:17:28 +0200 (CEST)
In-Reply-To: <1179934677.12071.30.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> These are used for setting up the dynamic audio power management and
> won't be needed in stand alone mode.

So if I don't care about power management, can I completely ignore anything with "dapm" in it?

Also, do I need a codec driver at all, even if I can't control the codec?  That is, can I 
do stuff like this:

static struct snd_soc_device mysoc_snd_devdata = {
	.machine = &snd_soc_machine_mysoc,
	.platform = &mysoc_soc_platform,
};

static struct snd_soc_dai_link mpc8610hpcd_dai = {
	.name = "CS4270",
	.stream_name = "CS4270",
	.cpu_dai = &mysoc_i2s_dai,
	.init = mpc8610hpcd_machine_init,
	.ops = &mpc8610hpcd_ops,
};

?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
