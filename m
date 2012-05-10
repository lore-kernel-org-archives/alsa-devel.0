From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/6] ASoC: mxs: mxs-pcm does not need to be
 a plaform_driver
Date: Thu, 10 May 2012 20:13:29 +0800
Message-ID: <20120510121326.GK17875@S2101-09.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-4-git-send-email-shawn.guo@linaro.org>
	<20120510092554.GI6622@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A790103B5F
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 14:13:30 +0200 (CEST)
Received: by dajt11 with SMTP id t11so2182741daj.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 05:13:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120510092554.GI6622@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 05:25:55PM +0800, Dong Aisheng wrote:
> > -failed_pdev_alloc:
> > -	snd_soc_unregister_dai(&pdev->dev);
> Do not need to unregister_dai in case mxs_pcm_platform_register failed?
> 
Yeah, my fingers moved so fast to remove code.  Thanks for catching it.

-- 
Regards,
Shawn
