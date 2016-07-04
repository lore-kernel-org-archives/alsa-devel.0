From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: atmel_ssc_dai.c, use of dai->id
Date: Mon, 4 Jul 2016 21:00:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1607041956420.11824@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 3143A265611
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 21:00:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Songjun Wu <songjun.wu@atmel.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to use SSC1 (not SSC0 which might work) on a SAMA5D4-Xplained 
board (4.1 kernel, but close to mainline)

c706f2e5 ASoC: atmel_ssc_dai: distinguish the different SSC
fixes an issue with cpu_dai id being always 0, while the ssc id should 
have been used (or the platform_device id)

I think there is a remaining issue with DMA parameters in 
atmel_ssc_startup():

line 324:
dma_params = &ssc_dma_params[dai->id][dir];

I think it should be 
dma_params = &ssc_dma_params[pdev->id][dir];

I am new to this platform, please comment
I can submit a formal patch later-on of course

thanks, regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
