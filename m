From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: About the platform_name field in snd_soc_dai_link
Date: Tue, 10 Aug 2010 15:38:18 +0200
Message-ID: <20100810133818.GL27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7D78C24153
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 15:38:18 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm wondering what exactly a snd_soc_platform is. Apparently the
snd_pcm_ops/pcm_new/pcm_free are specific to a platform. For my
understanding these operations are more specific to a cpu_dai. Looking
at the tree it seems that each cpu_dai has exactly one possible
platform, which seems logical to me because the cpu_dai knows how to
transfer the data.

My problem on i.MX is that I currently have two possible cpu dais
(imx-ssi.[01]) and each can be configured to use dma or fiq depending
on the dma capabilities. So the cpu_dai knows which pcm_ops we have
to use, but currently it's the soc glue code which has to decide in
platform_name. Am I understanding something wrong here?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
