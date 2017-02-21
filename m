From: Alan Young <Alan.Young@IEE.org>
Subject: Re: [PATCH] [updated] pcm: rate: Add capability to
 pass configuration node to plugins
Date: Tue, 21 Feb 2017 15:04:54 +0000
Message-ID: <2cb132c7-638b-6d93-621d-3460654660b8@IEE.org>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
 <6d7c74b7-da90-5ae9-c355-c6884b2edf09@gmail.com>
 <s5hy3xg8zkp.wl-tiwai@suse.de>
 <e1ebb06d-6f43-fde8-7b9e-653d247a4a19@gmail.com>
 <s5h4lzxxn9c.wl-tiwai@suse.de>
 <a15b8e68-a9b5-2ed2-29b2-a0ab5b997d7e@gmail.com>
 <a66a494e-3bd6-c813-6786-ca9deceabdc0@IEE.org> <s5hwpcosqrp.wl-tiwai@suse.de>
 <7b3c655f-4b7a-e10a-90ff-5cb480332f3f@IEE.org> <s5hefywsnoz.wl-tiwai@suse.de>
 <da34dc72-db60-d707-4747-1601123e7f81@IEE.org> <s5hr32r67l4.wl-tiwai@suse.de>
 <3b8cd9c9-8248-b22a-ebb8-dce7d901951d@IEE.org> <s5hbmtv61uq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------78146C965469F69247713201"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com
 [209.85.128.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 054DD2666EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 16:04:56 +0100 (CET)
Received: by mail-wr0-f176.google.com with SMTP id 89so79300735wrr.3
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 07:04:56 -0800 (PST)
In-Reply-To: <s5hbmtv61uq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------78146C965469F69247713201
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Update patch.

On 21/02/17 14:43, Takashi Iwai wrote:
>
> The error handling is missing when no name is given.
> You should handle the error explicitly instead of the success.
>
> 		if (!type) {
> 			SNDERR("No name is given for rate converter");
> 			.....
> 			return -EINVAL;
> 		}
>
> 		err = rate_open_func(....);
>
>
> Takashi


--------------78146C965469F69247713201
Content-Type: text/x-patch;
 name="0001-pcm-rate-Add-capability-to-pass-configuration-node-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-pcm-rate-Add-capability-to-pass-configuration-node-t.pa";
 filename*1="tch"

>From 6eb392e6e2b5749bd8f2c67907b2a08da8cfe863 Mon Sep 17 00:00:00 2001
From: Alan Young <consult.awy@gmail.com>
Date: Thu, 7 Apr 2016 09:15:04 +0100
Subject: [PATCH] pcm: rate: Add capability to pass configuration node to
 plugins

If a rate plugin uses a node (compound) instead of a plain string for
its "converter", and that compound is not a simple string array, then
the compound will be passed as an additional parameter to the new plugin
open() function (SND_PCM_RATE_PLUGIN_CONF_ENTRY(XXX)). The previous
open() function (SND_PCM_RATE_PLUGIN_ENTRY(XXX)) will be called if the
CONF version is not found. It is up to the plugin to determine whether
the presence of the conf parameter is mandatory.

Signed-off-by: Alan Young <consult.awy@gmail.com>
---
 include/pcm_rate.h |  5 +++-
 src/pcm/pcm_rate.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/include/pcm_rate.h b/include/pcm_rate.h
index 4d70df2..da278ac 100644
--- a/include/pcm_rate.h
+++ b/include/pcm_rate.h
@@ -120,11 +120,14 @@ typedef struct snd_pcm_rate_ops {
 typedef int (*snd_pcm_rate_open_func_t)(unsigned int version, void **objp,
 					snd_pcm_rate_ops_t *opsp);
 
+typedef int (*snd_pcm_rate_open_conf_func_t)(unsigned int version, void **objp,
+					snd_pcm_rate_ops_t *opsp, const snd_config_t *conf);
+
 /**
  * Define the object entry for external PCM rate-converter plugins
  */
 #define SND_PCM_RATE_PLUGIN_ENTRY(name) _snd_pcm_rate_##name##_open
-
+#define SND_PCM_RATE_PLUGIN_CONF_ENTRY(name) _snd_pcm_rate_##name##_open_conf
 
 #ifndef DOC_HIDDEN
 /* old rate_ops for protocol version 0x010001 */
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index cbb7618..2021247 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1258,26 +1258,48 @@ static const char *const default_rate_plugins[] = {
 	"speexrate", "linear", NULL
 };
 
-static int rate_open_func(snd_pcm_rate_t *rate, const char *type, int verbose)
+static int rate_open_func(snd_pcm_rate_t *rate, const char *type, const snd_config_t *converter_conf, int verbose)
 {
-	char open_name[64], lib_name[128], *lib = NULL;
+	char open_name[64], open_conf_name[64], lib_name[128], *lib = NULL;
 	snd_pcm_rate_open_func_t open_func;
+	snd_pcm_rate_open_conf_func_t open_conf_func;
 	int err;
 
 	snprintf(open_name, sizeof(open_name), "_snd_pcm_rate_%s_open", type);
+	snprintf(open_conf_name, sizeof(open_conf_name), "_snd_pcm_rate_%s_open_conf", type);
 	if (!is_builtin_plugin(type)) {
 		snprintf(lib_name, sizeof(lib_name),
 				 "%s/libasound_module_rate_%s.so", ALSA_PLUGIN_DIR, type);
 		lib = lib_name;
 	}
+
+	rate->rate_min = SND_PCM_PLUGIN_RATE_MIN;
+	rate->rate_max = SND_PCM_PLUGIN_RATE_MAX;
+	rate->plugin_version = SND_PCM_RATE_PLUGIN_VERSION;
+
+	open_conf_func = snd_dlobj_cache_get(lib, open_conf_name, NULL, verbose && converter_conf != NULL);
+	if (open_conf_func) {
+		err = open_conf_func(SND_PCM_RATE_PLUGIN_VERSION,
+				     &rate->obj, &rate->ops, converter_conf);
+		if (!err) {
+			rate->plugin_version = rate->ops.version;
+			if (rate->ops.get_supported_rates)
+				rate->ops.get_supported_rates(rate->obj,
+							      &rate->rate_min,
+							      &rate->rate_max);
+			rate->open_func = open_conf_func;
+			return 0;
+		} else {
+			snd_dlobj_cache_put(open_conf_func);
+			return err;
+		}
+	}
+
 	open_func = snd_dlobj_cache_get(lib, open_name, NULL, verbose);
 	if (!open_func)
 		return -ENOENT;
 
 	rate->open_func = open_func;
-	rate->rate_min = SND_PCM_PLUGIN_RATE_MIN;
-	rate->rate_max = SND_PCM_PLUGIN_RATE_MAX;
-	rate->plugin_version = SND_PCM_RATE_PLUGIN_VERSION;
 
 	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops);
 	if (!err) {
@@ -1301,6 +1323,30 @@ static int rate_open_func(snd_pcm_rate_t *rate, const char *type, int verbose)
 }
 #endif
 
+/*
+ * If the conf is an array of alternatives then the id of
+ * the first element will be "0" (or maybe NULL). Otherwise assume it is
+ * a structure.
+ */
+static int is_string_array(const snd_config_t *conf)
+{
+	snd_config_iterator_t i;
+
+	if (snd_config_get_type(conf) != SND_CONFIG_TYPE_COMPOUND)
+		return 0;
+
+	i = snd_config_iterator_first(conf);
+	if (i && i != snd_config_iterator_end(conf)) {
+		snd_config_t *n = snd_config_iterator_entry(i);
+		const char *id;
+		snd_config_get_id(n, &id);
+		if (id && strcmp(id, "0") != 0)
+			return 0;
+	}
+
+	return 1;
+}
+
 /**
  * \brief Creates a new rate PCM
  * \param pcmp Returns created PCM handle
@@ -1353,24 +1399,41 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	if (!converter) {
 		const char *const *types;
 		for (types = default_rate_plugins; *types; types++) {
-			err = rate_open_func(rate, *types, 0);
+			err = rate_open_func(rate, *types, NULL, 0);
 			if (!err) {
 				type = *types;
 				break;
 			}
 		}
 	} else if (!snd_config_get_string(converter, &type))
-		err = rate_open_func(rate, type, 1);
-	else if (snd_config_get_type(converter) == SND_CONFIG_TYPE_COMPOUND) {
+		err = rate_open_func(rate, type, NULL, 1);
+	else if (is_string_array(converter)) {
 		snd_config_iterator_t i, next;
 		snd_config_for_each(i, next, converter) {
 			snd_config_t *n = snd_config_iterator_entry(i);
 			if (snd_config_get_string(n, &type) < 0)
 				break;
-			err = rate_open_func(rate, type, 0);
+			err = rate_open_func(rate, type, NULL, 0);
 			if (!err)
 				break;
 		}
+	}
+	else if (snd_config_get_type(converter) == SND_CONFIG_TYPE_COMPOUND) {
+		snd_config_iterator_t i, next;
+		snd_config_for_each(i, next, converter) {
+			snd_config_t *n = snd_config_iterator_entry(i);
+			const char *id;
+			snd_config_get_id(n, &id);
+			if (strcmp(id, "name") != 0)
+				continue;
+			snd_config_get_string(n, &type);
+			break;
+		}
+		if (!type) {
+			SNDERR("No name given for rate converter");
+			return -EINVAL;
+		}
+		err = rate_open_func(rate, type, converter, 1);
 	} else {
 		SNDERR("Invalid type for rate converter");
 		snd_pcm_free(pcm);
@@ -1439,6 +1502,11 @@ pcm.name {
 	converter [ STR1 STR2 ... ]	# optional
 				# Converter type, default is taken from
 				# defaults.pcm.rate_converter
+	# or
+	converter {		# optional
+		name STR	# Convertor type
+		xxx yyy		# optional convertor-specific configuration
+	}
 }
 \endcode
 
-- 
2.5.5


--------------78146C965469F69247713201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------78146C965469F69247713201--
