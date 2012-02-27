From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/6] ASoC: fsl: align mpc8610_hpcd with
 p1022_ds on getting codec node
Date: Mon, 27 Feb 2012 14:31:01 -0600
Message-ID: <4F4BE805.1070208@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id 967FF103BA2
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 21:31:10 +0100 (CET)
In-Reply-To: <1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> Align mpc8610_hpcd with p1022_ds on getting codec node by just calling
> of_parse_phandle.  The bonus point of doing that is we can save
> exporting get_node_by_phandle_name() when we consolidate the common
> bits between mpc8610_hpcd and p1022_ds into a module, which can be
> shared by more machine drivers added later.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
