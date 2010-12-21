From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 02/11] ucm: modifiers names must be compound
	parse
Date: Tue, 21 Dec 2010 22:11:51 +0000
Message-ID: <1292969520-18047-3-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 93423103A2E
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:15 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so4299235wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:15 -0800 (PST)
In-Reply-To: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Modifier names must end in a .index to ensure we can support
same named modifiers. However the modifier index will be for internal
use only and the client will not use the index when setting modifier.

The modifier selection for same name modifiers will be based upon supported
device.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 src/ucm/parser.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 3d2fd71..7d547f4 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -401,10 +401,11 @@ static int parse_value(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
 static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 		snd_config_t *cfg,
 		void *data1,
-		void *data2 ATTRIBUTE_UNUSED)
+		void *data2)
 {
 	struct use_case_verb *verb = data1;
 	struct use_case_modifier *modifier;
+	char *name = data2;
 	const char *id;
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
@@ -423,9 +424,12 @@ static int parse_modifier(snd_use_case_mgr_t *uc_mgr,
 	err = snd_config_get_id(cfg, &id);
 	if (err < 0)
 		return err;
-	modifier->name = strdup(id);
+	modifier->name = malloc(strlen(name) + strlen(id) + 2);
 	if (modifier->name == NULL)
-		return -EINVAL;
+		return -ENOMEM;
+	strcpy(modifier->name, name);
+	strcat(modifier->name, ".");
+	strcat(modifier->name, id);
 
 	snd_config_for_each(i, next, cfg) {
 		const char *id;
@@ -636,6 +640,21 @@ static int parse_device(snd_use_case_mgr_t *uc_mgr,
 	return parse_compound(uc_mgr, cfg, parse_device_name, verb, NULL);
 }
 
+static int parse_modifier_name(snd_use_case_mgr_t *uc_mgr,
+			     snd_config_t *cfg,
+			     void *data1,
+			     void *data2 ATTRIBUTE_UNUSED)
+{
+	const char *id;
+	int err;
+
+	err = snd_config_get_id(cfg, &id);
+	if (err < 0)
+		return err;
+	return parse_compound(uc_mgr, cfg, parse_modifier,
+			      data1, (void *)id);
+}
+
 /*
  * Parse Verb Section
  *
@@ -817,7 +836,7 @@ static int parse_verb_file(snd_use_case_mgr_t *uc_mgr,
 		/* find modifier sections and parse them */
 		if (strcmp(id, "SectionModifier") == 0) {
 			err = parse_compound(uc_mgr, n,
-					     parse_modifier, verb, NULL);
+					     parse_modifier_name, verb, NULL);
 			if (err < 0) {
 				uc_error("error: %s failed to parse modifier",
 						file);
-- 
1.7.1
