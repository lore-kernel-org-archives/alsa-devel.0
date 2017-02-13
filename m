From: Alan Young <consult.awy@gmail.com>
Subject: [PATCH] [updated] pcm: rate: Add capability to pass
 configuration node to plugins
Date: Mon, 13 Feb 2017 17:20:01 +0000
Message-ID: <e1ebb06d-6f43-fde8-7b9e-653d247a4a19@gmail.com>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
 <6d7c74b7-da90-5ae9-c355-c6884b2edf09@gmail.com>
 <s5hy3xg8zkp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------33FC7DD9D11D14E4B1894FD6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A30642669C8
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 18:20:03 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id r141so99628104wmg.1
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 09:20:03 -0800 (PST)
In-Reply-To: <s5hy3xg8zkp.wl-tiwai@suse.de>
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
--------------33FC7DD9D11D14E4B1894FD6
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Here is a revised patch.

It is useful for the converter used by a rate plugin to be capable of 
receiving configuration. This patch enables the "converter" node of the 
configuration of a "type rate" plugin to be specified as a compound and 
passed to open func of the converter plugin.

The SND_PCM_RATE_PLUGIN_CONF_ENTRY macro is used to define a rate 
converter plugin entry point that takes the additional snd_config_t 
*conf parameter. If a rate converter plugin also supports the existing 
SND_PCM_RATE_PLUGIN_ENTRY entry point, or if passed conf parameter is 
NULL then it is up to the plugin to determine whether or not this is a 
fatal condition.

Alan.


--------------33FC7DD9D11D14E4B1894FD6
Content-Type: text/x-patch;
 name="0001-pcm-rate-Add-capability-to-pass-configuration-node-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-pcm-rate-Add-capability-to-pass-configuration-node-t.pa";
 filename*1="tch"

>From 28ce5b014c922a95f9398fad47c7c02fca94665c Mon Sep 17 00:00:00 2001
From: Alan Young <consult.awy@gmail.com>
Date: Thu, 7 Apr 2016 09:15:04 +0100
Subject: [PATCH] pcm: rate: Add capability to pass configuration node to
 plugins

If a rate plugin uses a node (compound) instead of a plain string for
its "converter" then that compound will be passed as an additional
parameter to the new plugin open() function
(SND_PCM_RATE_PLUGIN_CONF_ENTRY(XXX)). The previous open() function
(SND_PCM_RATE_PLUGIN_ENTRY(XXX)) will be called if the CONF version is
not found. It is up to the plugin to determine whether the presence of
the conf parameter is mandatory.

The existing behaviour of using the first (usable) plain string value,
regardless of parameter name, within the configuration node as the
converter name is unchanged.

Signed-off-by: Alan Young <consult.awy@gmail.com>
---
 include/pcm_rate.h |  5 ++++-
 src/pcm/pcm_rate.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 10 deletions(-)

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
index cbb7618..bbfe4b1 100644
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
+	open_conf_func = snd_dlobj_cache_get(lib, open_conf_name, NULL, verbose);
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
@@ -1353,23 +1375,26 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
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
+		err = rate_open_func(rate, type, NULL, 1);
 	else if (snd_config_get_type(converter) == SND_CONFIG_TYPE_COMPOUND) {
 		snd_config_iterator_t i, next;
 		snd_config_for_each(i, next, converter) {
 			snd_config_t *n = snd_config_iterator_entry(i);
+			const char *id;
 			if (snd_config_get_string(n, &type) < 0)
 				break;
-			err = rate_open_func(rate, type, 0);
+			err = rate_open_func(rate, type, converter, 0);
 			if (!err)
 				break;
+			if (snd_config_get_id(n, &id) >= 0 && id && strcmp(id, "0") != 0)
+				break; /* not a simple array of types */
 		}
 	} else {
 		SNDERR("Invalid type for rate converter");
@@ -1386,7 +1411,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 #else
 	type = "linear";
 	open_func = SND_PCM_RATE_PLUGIN_ENTRY(linear);
-	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops);
+	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops, 0);
 	if (err < 0) {
 		snd_pcm_free(pcm);
 		free(rate);
@@ -1439,6 +1464,11 @@ pcm.name {
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


--------------33FC7DD9D11D14E4B1894FD6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------33FC7DD9D11D14E4B1894FD6--
