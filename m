From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] Add Phytec i.MX sound support for AC97
Date: Tue, 09 Feb 2010 10:42:21 +0000
Message-ID: <1265712141.3254.1.camel@odin>
References: <20100209101428.GG17643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f225.google.com (mail-fx0-f225.google.com
	[209.85.220.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 5139B2454B
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 11:42:27 +0100 (CET)
Received: by fxm25 with SMTP id 25so5832595fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 09 Feb 2010 02:42:27 -0800 (PST)
In-Reply-To: <20100209101428.GG17643@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-02-09 at 11:14 +0100, Sascha Hauer wrote:
> Hi Marc et all,
> 
> The following patch adds support for Phytec i.MX boards in AC97
> mode. With this patch only some board glue code is missing to
> enable sound for the first i.MX boards. I'll push the board code
> through my i.MX tree. Please consider including this patch for -next.
> 
> Sascha
> 
> 
> >From 264b0916b712d6cbbcbd2f7b208b1c84b40a3f54 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Wed, 25 Nov 2009 16:18:28 +0100
> Subject: [PATCH 1/6] ASoC: add phycore-ac97 sound support
> 
> This patch adds sound support for Phytec PhyCORE / PhyCARD
> modules in AC97 mode.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
