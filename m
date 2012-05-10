From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/6] ASoC: mxs: use devm_clk_get for
	mxs_saif_probe
Date: Thu, 10 May 2012 17:17:27 +0800
Message-ID: <CAAQ0ZWRtwwpToK9J5EbJvRrKnzGn6SrkDgNumat1b3vAS4ytUw@mail.gmail.com>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
	<20120510091332.GF3908@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6083B10BA12
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 11:17:28 +0200 (CEST)
Received: by lagw12 with SMTP id w12so909486lag.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 02:17:28 -0700 (PDT)
In-Reply-To: <20120510091332.GF3908@opensource.wolfsonmicro.com>
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

On 10 May 2012 17:13, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, May 10, 2012 at 04:42:09PM +0800, Shawn Guo wrote:
>> Use devm_clk_get for mxs_saif_probe to ease the cleanup.
>
> Please stop submitting devm_clk_get() changes until it's in mainline, as
> I've said with all the similar changs this can't be applied until that
> API can be merged up into ASoC.

Russell's clkdev branch will show up in arm-soc as a dependency
branch.  So if you are ok with the series go through arm-soc, we will
be fine.

Regards,
Shawn
