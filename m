From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/11] ALSA: bebob: add 'version' member for
	BeBoB protocol version
Date: Mon,  8 Jun 2015 23:31:04 +0900
Message-ID: <1433773868-17505-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 59DC52604D1
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 16:31:17 +0200 (CEST)
In-Reply-To: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

BeBoB installed devices have BeBoB register area. This are stores
basic information about its firmware. A register has its protocol
version.

This commit adds 'version' member and store the device's protocol
version to handle v3 quirks in following commits.

Tested-by: Kim Tore Jensen <kim@incendio.no>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c | 8 ++++++++
 sound/firewire/bebob/bebob.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index e71bd35..920571b 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -33,6 +33,7 @@ static DEFINE_MUTEX(devices_mutex);
 static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
 
 /* Offsets from information register. */
+#define INFO_OFFSET_BEBOB_VERSION	0x08
 #define INFO_OFFSET_GUID		0x10
 #define INFO_OFFSET_HW_MODEL_ID		0x18
 #define INFO_OFFSET_HW_MODEL_REVISION	0x1c
@@ -73,6 +74,7 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 	u32 hw_id;
 	u32 data[2] = {0};
 	u32 revision;
+	u32 version;
 	int err;
 
 	/* get vendor name from root directory */
@@ -105,6 +107,12 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 	if (err < 0)
 		goto end;
 
+	err = snd_bebob_read_quad(bebob->unit, INFO_OFFSET_BEBOB_VERSION,
+				  &version);
+	if (err < 0)
+		goto end;
+	bebob->version = version;
+
 	strcpy(bebob->card->driver, "BeBoB");
 	strcpy(bebob->card->shortname, model);
 	strcpy(bebob->card->mixername, model);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 76a65cc..6359fb0 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -115,6 +115,9 @@ struct snd_bebob {
 	/* for M-Audio special devices */
 	void *maudio_special_quirk;
 	bool deferred_registration;
+
+	/* For BeBoB version quirk. */
+	unsigned int version;
 };
 
 static inline int
-- 
2.1.4
