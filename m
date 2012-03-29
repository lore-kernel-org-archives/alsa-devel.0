From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 21:54:16 +0800
Message-ID: <20120329135413.GC19506@S2101-09.ap.freescale.net>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329111605.GK3668@opensource.wolfsonmicro.com>
	<20120329120933.GA27740@zzm-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 98C26104459
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 15:54:20 +0200 (CEST)
Received: by iakh37 with SMTP id h37so3190040iak.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 06:54:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120329120933.GA27740@zzm-ubuntu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zengzm.kernel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Zhaoming,

On Thu, Mar 29, 2012 at 08:09:33PM +0800, Zeng Zhaoming wrote:
...
> This "Mic Bias" is codec internal controller, Machine code should not touch this.

In the end, machine driver will have to use it to specify the map.
You even said the below.

and platform code
+      {"Mic Bias", NULL, "MIC"},
-      {"MIC_IN", NULL, "MIC"},

-- 
Regards,
Shawn
