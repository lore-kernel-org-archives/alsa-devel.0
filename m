From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 22:19:18 +0800
Message-ID: <20120329141916.GF19506@S2101-09.ap.freescale.net>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329071700.GA18127@zzm-ubuntu>
	<20120329105831.GC3668@opensource.wolfsonmicro.com>
	<20120329140420.GD19506@S2101-09.ap.freescale.net>
	<20120329141019.GQ3668@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DE041044D0
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 16:19:25 +0200 (CEST)
Received: by iakh37 with SMTP id h37so3218738iak.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 07:19:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120329141019.GQ3668@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 29, 2012 at 03:10:20PM +0100, Mark Brown wrote:
...
> This should be something like:
> 
> 	{ "Mic Jack", NULL, "Mic Bias" },
> 	{ "MIC_IN", NULL, "Mic Bias" },
> 
> (with the conversion of Mic Bias to a supply widget) which has the bonus
> of being a whole lot easier to understand.
> 
Indeed.  With your patch, Mic Bias is a supply widget now.

-- 
Regards,
Shawn
