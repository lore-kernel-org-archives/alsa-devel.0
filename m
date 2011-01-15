From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Add dependency on X86 for Intel MID
	drivers
Date: Sat, 15 Jan 2011 18:55:57 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630108446725A3@bgsmsx502.gar.corp.intel.com>
References: <1295096518-15779-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 9033224333
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2011 14:26:05 +0100 (CET)
In-Reply-To: <1295096518-15779-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

>  config SND_MFLD_MACHINE
>  	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
> +	depends on X86
>  	select SND_SOC_SN95031
>  	select SND_SST_PLATFORM
>  	help
Mark,
X86 specifies generic x86 devices, pc's netbooks.....
The MID class of devices are quite different, so IMO it should rather depend
on X86_MRST which is for MID devices.

CC Alan:
Alan would X86_MRST be apt or any other option for MID drivers vs X86?
	
~Vinod
