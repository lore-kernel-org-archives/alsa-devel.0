From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sound: oss/dmabuf: remove an unneeded temporary variable
Date: Fri, 9 Aug 2013 12:57:06 +0300
Message-ID: <20130809095705.GE29282@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We don't actually use the "go" variable so it can be removed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/oss/dmabuf.c b/sound/oss/dmabuf.c
index a59c888..461d94c 100644
--- a/sound/oss/dmabuf.c
+++ b/sound/oss/dmabuf.c
@@ -557,7 +557,6 @@ int DMAbuf_getrdbuffer(int dev, char **buf, int *len, int dontblock)
 	unsigned long flags;
 	int err = 0, n = 0;
 	struct dma_buffparms *dmap = adev->dmap_in;
-	int go;
 
 	if (!(adev->open_mode & OPEN_READ))
 		return -EIO;
@@ -584,7 +583,7 @@ int DMAbuf_getrdbuffer(int dev, char **buf, int *len, int dontblock)
 			spin_unlock_irqrestore(&dmap->lock,flags);
 			return -EAGAIN;
 		}
-		if ((go = adev->go))
+		if (adev->go)
 			timeout = dmabuf_timeout(dmap);
 
 		spin_unlock_irqrestore(&dmap->lock,flags);
