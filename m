From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/6] ASoC: mxs: add device tree support for
 mxs-sgtl5000
Date: Fri, 11 May 2012 10:49:58 +0800
Message-ID: <20120511024956.GR17875@S2101-09.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-6-git-send-email-shawn.guo@linaro.org>
	<20120510111646.GL6622@shlinux2.ap.freescale.net>
	<20120510122001.GM17875@S2101-09.ap.freescale.net>
	<20120511023302.GN6622@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D01DE10BB12
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 04:49:58 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so3577634pbb.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 19:49:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120511023302.GN6622@shlinux2.ap.freescale.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng-B29396 <B29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dong Aisheng <dong.aisheng@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 11, 2012 at 10:33:03AM +0800, Dong Aisheng wrote:
> Hmm, even we need to do sanity check, i guess this could be done in
> core since the core will take these nodes as parameter.
> However, after checking the core a bit, i guess the core has already
> done this:
> 
> /* no, then find CPU DAI from registered DAIs*/
> list_for_each_entry(cpu_dai, &dai_list, list) {
> 	if (dai_link->cpu_dai_of_node) {
> 		if (cpu_dai->dev->of_node != dai_link->cpu_dai_of_node)
> 			continue;
> 	} else {
> 		if (strcmp(cpu_dai->name, dai_link->cpu_dai_name))
> 			continue;
> 	}
> 
> 	rtd->cpu_dai = cpu_dai;
> 	goto find_codec;
> }
> 
> It looks if the phandles are not correctly represented, the dai binding
> will fail, right?
> 
Yes, the core will have the sanity check and fail out without reporting
what's exactly going wrong, unless you turn on ASoC core debug option.
So what's harm to have the check in driver to fail out as early as
possible and with the exact message reporting failure cause?

-- 
Regards,
Shawn
