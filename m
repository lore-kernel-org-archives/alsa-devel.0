From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 03/11] ucm: remove parse_device() and call
	parse_compound() directly
Date: Tue, 21 Dec 2010 22:11:52 +0000
Message-ID: <1292969520-18047-4-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D169103A3D
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:17 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so4299235wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:17 -0800 (PST)
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

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 src/ucm/parser.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 7d547f4..f3a75e6 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -633,13 +633,6 @@ static int parse_device_name(snd_use_case_mgr_t *uc_mgr,
 			      data1, (void *)id);
 }
 
-static int parse_device(snd_use_case_mgr_t *uc_mgr,
-			struct use_case_verb *verb,
-			snd_config_t *cfg)
-{
-	return parse_compound(uc_mgr, cfg, parse_device_name, verb, NULL);
-}
-
 static int parse_modifier_name(snd_use_case_mgr_t *uc_mgr,
 			     snd_config_t *cfg,
 			     void *data1,
@@ -824,7 +817,8 @@ static int parse_verb_file(snd_use_case_mgr_t *uc_mgr,
 
 		/* find device sections and parse them */
 		if (strcmp(id, "SectionDevice") == 0) {
-			err = parse_device(uc_mgr, verb, n);
+			err = parse_compound(uc_mgr, n,
+						parse_device_name, verb, NULL);
 			if (err < 0) {
 				uc_error("error: %s failed to parse device",
 						file);
-- 
1.7.1
