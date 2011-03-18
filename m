From: Margarita Olaya <magi@slimlogic.co.uk>
Subject: [PATCHv3] alsa-lib: ucm: allow values to be read from
	devices
Date: Fri, 18 Mar 2011 11:05:03 -0600
Message-ID: <AANLkTikb0w_gtAohrjViGokq9+kn8Ep5GWus1r-z1X04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C3EC1039F4
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 18:05:07 +0100 (CET)
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by slimlogic.co.uk (Postfix) with ESMTPSA id 8F1111304BC
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 17:05:04 +0000 (GMT)
Received: by vws16 with SMTP id 16so3926075vws.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 10:05:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This allows devices value to be read using the get_value().
Also fix a little formatting.

Signed-off-by: Margarita Olaya Cabrera <magi@slimlogic.co.uk>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 src/ucm/main.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 42fd373..1246aa8 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1059,24 +1059,31 @@ static int get_value3(const char **value,
  * \param uc_mgr Use case manager
  * \param identifier Value identifier (string)
  * \param value Returned value string
- * \param modifier modifier name (string)
+ * \param item Modifier of Device name (string)
  * \return Zero on success (value is filled), otherwise a negative error code
  */
 static int get_value(snd_use_case_mgr_t *uc_mgr,
-                     const char *identifier,
-                     const char **value,
-                     const char *modifier)
+			const char *identifier,
+			const char **value,
+			const char *item)
 {
-        struct use_case_modifier *mod;
+	struct use_case_modifier *mod;
+	struct use_case_device *dev;
 	int err;

-	if (modifier != NULL) {
-	        mod = find_modifier(uc_mgr, modifier);
+	if (item != NULL) {
+		mod = find_modifier(uc_mgr, item);
 		if (mod != NULL) {
 			err = get_value1(value, &mod->value_list, identifier);
 			if (err >= 0 || err != -ENOENT)
 				return err;
 		}
+		dev = find_device(uc_mgr->active_verb, item);
+		if (dev != NULL) {
+			err = get_value1(value, &dev->value_list, identifier);
+			if (err >= 0 || err != -ENOENT)
+				return err;
+		}
 	}
 	err = get_value1(value, &uc_mgr->active_verb->value_list, identifier);
 	if (err >= 0 || err != -ENOENT)
-- 
1.7.0.4
