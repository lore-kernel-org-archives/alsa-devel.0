From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: ak4642: Add pll select support
Date: Tue, 23 Mar 2010 10:10:23 +0000
Message-ID: <1269339023.3754.32.camel@odin>
References: <uvdcn4hx0.wl%morimoto.kuninori@renesas.com>
	<utys74hwf.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f195.google.com (mail-iw0-f195.google.com
	[209.85.223.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 8204E103853
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 11:10:29 +0100 (CET)
Received: by iwn33 with SMTP id 33so5292160iwn.23
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 03:10:25 -0700 (PDT)
In-Reply-To: <utys74hwf.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-03-23 at 16:27 +0900, Kuninori Morimoto wrote:
> Current ak4642 was not able to select pll.
> This patch add support it.
> It still expect PLL base input pin is MCKI.
> see Table 5 "setting of PLL Mode" of datasheet
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
