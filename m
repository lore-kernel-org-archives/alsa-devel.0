From: Margarita Olaya <magi@slimlogic.co.uk>
Subject: [PATCH] alsa-lib: ucm: allow values to be read from
	devices
Date: Tue, 15 Mar 2011 10:45:19 -0600
Message-ID: <AANLkTikd29BONAW9Zqwrb=tKN1iSVcsig+6Egi1001WD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 31A662456F
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 17:45:35 +0100 (CET)
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by slimlogic.co.uk (Postfix) with ESMTPSA id E573F1304C7
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 16:45:31 +0000 (GMT)
Received: by vxi40 with SMTP id 40so726094vxi.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 09:45:30 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This allows devices value to be read using the get_value().
Also fix a little formatting.

Signed-off-by: Margarita Olaya Cabrera <magi@slimlogic.co.uk>
---
 src/ucm/main.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 42fd373..fb11e61 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1063,20 +1063,27 @@ static int get_value3(const char **value,
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
+			if (err >=0 || err != -ENOENT)
+				return err;
+		}
 	}
 	err = get_value1(value, &uc_mgr->active_verb->value_list, identifier);
 	if (err >= 0 || err != -ENOENT)
-- 
1.7.0.4
