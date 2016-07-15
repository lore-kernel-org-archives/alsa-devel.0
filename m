From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 22/29] mixer: remove alloca() from
	init_db_range()
Date: Fri, 15 Jul 2016 09:23:26 +0900
Message-ID: <1468542213-24880-23-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id F1CB62666FE
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 02:23:41 +0200 (CEST)
In-Reply-To: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Both of alloca() and automatic variables keep storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/mixer/simple_none.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 05dde41..0799ceb 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -1098,7 +1098,7 @@ static int convert_to_dB(snd_hctl_elem_t *ctl, struct selem_str *rec,
  */
 static int init_db_range(snd_hctl_elem_t *ctl, struct selem_str *rec)
 {
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_info_t info = {0};
 	unsigned int *tlv = NULL;
 	const unsigned int tlv_size = 4096;
 	unsigned int *dbrec;
@@ -1109,10 +1109,9 @@ static int init_db_range(snd_hctl_elem_t *ctl, struct selem_str *rec)
 	if (rec->db_initialized)
 		return 0;
 
-	snd_ctl_elem_info_alloca(&info);
-	if (snd_hctl_elem_info(ctl, info) < 0)
+	if (snd_hctl_elem_info(ctl, &info) < 0)
 		goto error;
-	if (!snd_ctl_elem_info_is_tlv_readable(info))
+	if (!snd_ctl_elem_info_is_tlv_readable(&info))
 		goto error;
 	tlv = malloc(tlv_size);
 	if (!tlv)
-- 
2.7.4
