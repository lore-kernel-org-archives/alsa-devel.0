From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v2] ASoC: OMAP: Don't try to set
 unsupported OMAP_DMA_DATA_BURST_16 on OMAP1
Date: Thu, 22 Oct 2009 09:16:35 +0300
Message-ID: <20091022091635.29f710c0.jhnikula@gmail.com>
References: <200910212035.42245.jkrzyszt@tis.icnet.pl>
	<20091021221607.c46f60e3.jhnikula@gmail.com>
	<200910212310.05087.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 378B824382
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 08:15:52 +0200 (CEST)
Received: by fxm10 with SMTP id 10so19463609fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2009 23:15:51 -0700 (PDT)
In-Reply-To: <200910212310.05087.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Oct 2009 23:10:03 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> The patch corrects the problem by not calling those two functions when run on 
> OMAP1 class based machines.
> 
> Created against linux-2.6.32-rc5.
> Tested on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
