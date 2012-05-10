From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/6] ASoC: mxs: use devm_clk_get for
	mxs_saif_probe
Date: Thu, 10 May 2012 20:01:58 +0800
Message-ID: <20120510120156.GJ17875@S2101-09.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
	<20120510091332.GF3908@opensource.wolfsonmicro.com>
	<CAAQ0ZWRtwwpToK9J5EbJvRrKnzGn6SrkDgNumat1b3vAS4ytUw@mail.gmail.com>
	<20120510093032.GI3908@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 50C1C2435F
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 14:02:08 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so2416493pbb.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 05:02:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120510093032.GI3908@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 10:30:33AM +0100, Mark Brown wrote:
> Well, if Russell's happy with that being merged into other trees I could
> just pull it into ASoC?  Or we could just wait, or if this is really
> separate to everything else why not just apply it on the clkdev branch
> rather than worrying about some complicated arrangement?
> 
> This is just a trivial cleanup to use new APIs...

Ok, giving up ...

-- 
Regards,
Shawn
