From: Timur Tabi <timur@freescale.com>
Subject: snd_pcm_lib_malloc_pages()
Date: Mon, 11 Jun 2007 18:49:04 -0500
Message-ID: <466DDF70.9000508@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AF3A2451B
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 01:49:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(resending since I haven't gotten a reply yet)

Liam

Why do none of the ASoC drivers use snd_pcm_lib_malloc_pages()?  They all allocate their
DMA buffers by hand.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
