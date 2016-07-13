From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] ctl: add compatibility information
	for snd_ctl_elem_info_set_dimension()
Date: Wed, 13 Jul 2016 09:29:19 +0900
Message-ID: <1468369759-8520-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 73F42265A59
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 02:29:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I forgot it when committing to the API.

Fixes: 16812b70daeb('ctl: add an API to set dimension levels to element information')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/control/control.c b/src/control/control.c
index a88f7a1..aa05130 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -2515,6 +2515,9 @@ use_default_symbol_version(__snd_ctl_elem_info_get_dimension, snd_ctl_elem_info_
  * <dt>-EINVAL
  * <dd>Invalid arguments are given as parameters.
  * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in version 1.1.2.
  */
 int snd_ctl_elem_info_set_dimension(snd_ctl_elem_info_t *info,
 				    const int dimension[4])
-- 
2.7.4
