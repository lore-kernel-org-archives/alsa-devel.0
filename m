From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] test: fix comment about first two
	fields of TLV data payload
Date: Tue, 30 Aug 2016 09:21:45 +0900
Message-ID: <1472516505-8350-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 18B7C265770
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 02:21:50 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I misunderstand TLV packet structure (struct snd_ctl_tlv) nests in its
payload. But actually, the payload stores different type of data.

This commit corrects a comment in a test program of user control element
set including my misunderstanding.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 9b9dc59..f6f050a 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -418,11 +418,11 @@ static int check_tlv(struct elem_set_trial *trial)
 	int err;
 
 	/*
-	 * See a layout of 'struct snd_ctl_tlv'. I don't know the reason to
-	 * construct this buffer with the same layout. It should be abstracted
-	 * inner userspace library...
+	 * When transferring threshold level information via TLV feature of
+	 * ALSA control interface, the first two fields of packet payload
+	 * consist of data type and data length.
 	 */
-	orig[0] = snd_ctl_elem_id_get_numid(trial->id);
+	orig[0] = SNDRV_CTL_TLVT_CONTAINER;
 	orig[1] = 6 * sizeof(orig[0]);
 	orig[2] = 'a';
 	orig[3] = 'b';
-- 
2.7.4
