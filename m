From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: No shutdown code in soc-core.c
Date: Sat, 17 Apr 2010 03:47:39 +0900
Message-ID: <20100416184738.GA24707@opensource.wolfsonmicro.com>
References: <17295568.74341271384961009.JavaMail.weblogic@epml11>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7860A2454C
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Apr 2010 20:47:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <17295568.74341271384961009.JavaMail.weblogic@epml11>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: "liam.girdwood@wolfsonmicro.com" <liam.girdwood@wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 16, 2010 at 02:29:21AM +0000, ANISH KUMAR wrote:
> I have a doubt regarding this soc_driver struct which is defined 
> in soc-core.c file.Why not soc_shutdown code is added in this 
> struct??

Power management for ASoC is handled by the dev_pm_ops for the driver
which does have a poweroff method.
