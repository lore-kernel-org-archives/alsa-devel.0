From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: sgtl5000: fix power on/off of MIC
	bias
Date: Wed, 28 Mar 2012 22:18:14 +0800
Message-ID: <20120328141812.GB3254@S2101-09.ap.freescale.net>
References: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
	<7FE21149F4667147B645348EC605788514EDFF@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A6E32414D
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 16:18:30 +0200 (CEST)
Received: by ggni2 with SMTP id i2so755909ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2012 07:18:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7FE21149F4667147B645348EC605788514EDFF@039-SN2MPN1-011.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "Zeng@alsa-project.org" <Zeng@alsa-project.org>, Xu Lionel-R63889 <R63889@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Zhaoming <zengzm.kernel@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 28, 2012 at 09:52:15AM +0000, Dong Aisheng-B29396 wrote:
> Did you test line-in record?

No, I did not.  I'm playing imx51 babbage board which has no LINE-IN
routed.

> IIRC for line-in record, it may also need VAG_POWER up.
> Then only enable VAG_POWER for mic_bias_event may not be sufficient.
> Will verify it latter when I'm free.
> 
This patch only fixes MIC.  I think you can submit another patch after
you confirm LINE-IN has the same issue.

-- 
Regards,
Shawn
