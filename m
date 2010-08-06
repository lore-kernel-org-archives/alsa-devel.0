From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: multi-comp: OMAP McBSP: Enable
 audio on OMAP1 platform
Date: Fri, 6 Aug 2010 11:13:30 +0300
Message-ID: <20100806111330.1137938a.jhnikula@gmail.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
	<1281080355-22589-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 798CE103970
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 10:12:24 +0200 (CEST)
Received: by eye27 with SMTP id 27so2565205eye.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 01:12:24 -0700 (PDT)
In-Reply-To: <1281080355-22589-3-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: jkrzyszt@tis.icnet.pl, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri,  6 Aug 2010 10:39:14 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> OMAP1 class has 3 McBSP ports, if I'm not mistaken.
> Enable the audio with multi-comp on OMAP1 class.
> 
...
> +static void omap_init_audio(void)
> +{
> +	platform_device_register(&omap_mcbsp1);
> +	platform_device_register(&omap_mcbsp2);
> +	platform_device_register(&omap_mcbsp3);
> +	platform_device_register(&omap_pcm);
> +}
> +
Not for sure but according to code only omap15xx and 16xx have three
ports, 7xx two and I'm unsure about 8xx. At least cpu_is_omap7xx seems
to be valid for both 730 and 850.


-- 
Jarkko
