From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Issue in alsa when dma complete race with pcm release
Date: Fri, 3 Jul 2015 16:25:31 +0800
Message-ID: <20150703082530.GA21580@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0144.outbound.protection.outlook.com [207.46.100.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D787260484
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 11:34:21 +0200 (CEST)
Received: from shlinux2 (shlinux2.ap.freescale.net [10.192.224.44])
 by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id t639YFQ6029006
 for <alsa-devel@alsa-project.org>; Fri, 3 Jul 2015 02:34:16 -0700
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi alsa-devel

   There maybe a issue in ALSA when dma complete race with snd_pcm_release.
The pcm release and dma complete are in different thread. There is occasion
that dmaengine_pcm_dma_complete() is called too late, some memory has been
freed, the prtd is null. Then there is kernel dump.

   Is there any solution for this issue? Thanks.

Best regards
wang shengjiu
