From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/14] ALSA: hda: Proper endian notations for
	BDL pointers
Date: Wed, 25 Jul 2018 23:24:03 +0200
Message-ID: <20180725212414.19795-4-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 695B7267766
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:16 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 35969ADA4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
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

The BDL pointer used in snd_hdac_dsp_prepare() should be declared as
__le32, as warned by sparse:
  sound/hda/hdac_stream.c:655:47: warning: incorrect type in argument 4 (different base types)
  sound/hda/hdac_stream.c:655:47:    expected restricted __le32 [usertype] **bdlp
  sound/hda/hdac_stream.c:655:47:    got unsigned int [usertype] **<noident>

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index e1472c7ab6c1..eee422390d8e 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -621,7 +621,7 @@ int snd_hdac_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
 			 unsigned int byte_size, struct snd_dma_buffer *bufp)
 {
 	struct hdac_bus *bus = azx_dev->bus;
-	u32 *bdl;
+	__le32 *bdl;
 	int err;
 
 	snd_hdac_dsp_lock(azx_dev);
@@ -651,7 +651,7 @@ int snd_hdac_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
 	snd_hdac_stream_writel(azx_dev, SD_BDLPU, 0);
 
 	azx_dev->frags = 0;
-	bdl = (u32 *)azx_dev->bdl.area;
+	bdl = (__le32 *)azx_dev->bdl.area;
 	err = setup_bdle(bus, bufp, azx_dev, &bdl, 0, byte_size, 0);
 	if (err < 0)
 		goto error;
-- 
2.18.0
