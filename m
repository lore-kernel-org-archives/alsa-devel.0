From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: memalloc: Drop superfluous ifndef
Date: Thu, 24 May 2018 11:25:44 +0200
Message-ID: <20180524092546.16910-2-tiwai@suse.de>
References: <20180524092546.16910-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CC94126738C
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 11:25:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2F0ACAD2A
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 09:25:56 +0000 (UTC)
In-Reply-To: <20180524092546.16910-1-tiwai@suse.de>
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

Drop the superfluous #ifndef check in memalloc.h that had been put
just for allowing building the alsa-driver kernel modules externally.
Since the external build was discontinued years ago, let's clean up
the old kludges.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 782d1df34208..9c3db3dce32b 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -34,11 +34,9 @@ struct snd_dma_device {
 	struct device *dev;		/* generic device */
 };
 
-#ifndef snd_dma_pci_data
 #define snd_dma_pci_data(pci)	(&(pci)->dev)
 #define snd_dma_isa_data()	NULL
 #define snd_dma_continuous_data(x)	((struct device *)(__force unsigned long)(x))
-#endif
 
 
 /*
-- 
2.16.3
