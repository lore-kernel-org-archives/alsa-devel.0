From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH lib] Replace unsafe characters with _ in card
	name
Date: Sat, 27 Jun 2015 19:32:49 +0500
Message-ID: <1435415569-17771-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id E4758260593
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 16:33:31 +0200 (CEST)
Received: by wicnd19 with SMTP id nd19so65963734wic.1
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 07:33:31 -0700 (PDT)
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
Cc: tiwai@suse.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Otherwise, they get misinterpreted as argument separators
in USB-Audio PCM definitions, and thus prevent SPDIF blacklist entries
from working.

While at it, add my Logitec C910 webcam to the SPDIF blacklist.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
I did not send this patch earlier because of hesitation whether to send
it as it is or to implement proper escaping, and then forgot about it.

 include/conf.h                |  1 +
 src/conf.c                    | 32 ++++++++++++++++++++++++++++++++
 src/conf/cards/USB-Audio.conf |  3 ++-
 src/confmisc.c                |  2 +-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/conf.h b/include/conf.h
index ff270f6..087c05d 100644
--- a/include/conf.h
+++ b/include/conf.h
@@ -126,6 +126,7 @@ int snd_config_imake_integer(snd_config_t **config, const char *key, const long
 int snd_config_imake_integer64(snd_config_t **config, const char *key, const long long value);
 int snd_config_imake_real(snd_config_t **config, const char *key, const double value);
 int snd_config_imake_string(snd_config_t **config, const char *key, const char *ascii);
+int snd_config_imake_safe_string(snd_config_t **config, const char *key, const char *ascii);
 int snd_config_imake_pointer(snd_config_t **config, const char *key, const void *ptr);
 
 snd_config_type_t snd_config_get_type(const snd_config_t *config);
diff --git a/src/conf.c b/src/conf.c
index bb256e7..e72a58a 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -2228,6 +2228,38 @@ int snd_config_imake_string(snd_config_t **config, const char *id, const char *v
 	return 0;
 }
 
+int snd_config_imake_safe_string(snd_config_t **config, const char *id, const char *value)
+{
+	int err;
+	snd_config_t *tmp;
+	char *c;
+
+	err = snd_config_make(&tmp, id, SND_CONFIG_TYPE_STRING);
+	if (err < 0)
+		return err;
+	if (value) {
+		tmp->u.string = strdup(value);
+		for (c = tmp->u.string; *c; c++) {
+			if (*c == ' ' || *c == '-' || *c == '_' ||
+				(*c >= '0' && *c <= '9') ||
+				(*c >= 'a' && *c <= 'z') ||
+				(*c >= 'A' && *c <= 'Z'))
+					continue;
+			*c = '_';
+		}
+
+		if (!tmp->u.string) {
+			snd_config_delete(tmp);
+			return -ENOMEM;
+		}
+	} else {
+		tmp->u.string = NULL;
+	}
+	*config = tmp;
+	return 0;
+}
+
+
 /**
  * \brief Creates a pointer configuration node with the given initial value.
  * \param[out] config The function puts the handle to the new node at
diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 031bee0..e365f29 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -57,7 +57,8 @@ USB-Audio.pcm.iec958_device {
 	"Scarlett 2i4 USB" 999
 	"Sennheiser USB headset" 999
 	"SWTOR Gaming Headset by Razer" 999
-	"USB Device 0x46d:0x992" 999
+	"USB Device 0x46d_0x821" 999
+	"USB Device 0x46d_0x992" 999
 }
 
 # Second iec958 device number, if any.
diff --git a/src/confmisc.c b/src/confmisc.c
index 1fb4f28..ae0275f 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -935,7 +935,7 @@ int snd_func_card_name(snd_config_t **dst, snd_config_t *root,
 	}
 	err = snd_config_get_id(src, &id);
 	if (err >= 0)
-		err = snd_config_imake_string(dst, id,
+		err = snd_config_imake_safe_string(dst, id,
 					      snd_ctl_card_info_get_name(info));
       __error:
       	if (ctl)
-- 
2.4.4
