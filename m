From: Alan Young <consult.awy@gmail.com>
Subject: [PATCH] pcm: rate: Add capability to pass
 configuration node to plugins
Date: Wed, 8 Feb 2017 10:50:44 +0000
Message-ID: <6d7c74b7-da90-5ae9-c355-c6884b2edf09@gmail.com>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------FCAEBB1346D64805222F83DA"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C11426684C
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 11:50:46 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id r141so182118029wmg.1
 for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2017 02:50:46 -0800 (PST)
In-Reply-To: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------FCAEBB1346D64805222F83DA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

It is useful for the converter used by a rate plugin to be capable of 
receiving configuration. This patch enables the "converter" node of the 
configuration of a "type rate" plugin to be specified as a compound and 
passed to open func of the converter plugin.

The SND_PCM_RATE_PLUGIN_VERSION is incremented and 
SND_PCM_RATE_PLUGIN_VERSION_CONFIGURE is defined so that a converter 
plugin can test whether it should expect the extra parameter on its open 
func.

Alan.


--------------FCAEBB1346D64805222F83DA
Content-Type: text/x-patch;
 name="0001-pcm-rate-Add-capability-to-pass-configuration-node-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-pcm-rate-Add-capability-to-pass-configuration-node-t.pa";
 filename*1="tch"

>From febb2e95682e99fee04f5853f783ba48748850b5 Mon Sep 17 00:00:00 2001
From: Alan Young <consult.awy@gmail.com>
Date: Thu, 7 Apr 2016 09:15:04 +0100
Subject: [PATCH] pcm: rate: Add capability to pass configuration node to
 plugins

If a rate plugin uses a node (compound) instead of a plain string for
its "converter" then that compound will be passed as an additional
parameter to the plugin open() function
(SND_PCM_RATE_PLUGIN_ENTRY(XXX)).

The existing behaviour of using the first (usable) plain string value,
regardless of parameter name, within the configuration node as the
converter name is unchanged.

Signed-off-by: Alan Young <consult.awy@gmail.com>
---
 include/pcm_rate.h |  5 +++--
 src/pcm/pcm_rate.c | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/pcm_rate.h b/include/pcm_rate.h
index 4d70df2..fb7ec55 100644
--- a/include/pcm_rate.h
+++ b/include/pcm_rate.h
@@ -38,7 +38,8 @@ extern "C" {
 /**
  * Protocol version
  */
-#define SND_PCM_RATE_PLUGIN_VERSION	0x010002
+#define SND_PCM_RATE_PLUGIN_VERSION	0x010003
+#define SND_PCM_RATE_PLUGIN_VERSION_CONFIGURE	0x010003
 
 /** hw_params information for a single side */
 typedef struct snd_pcm_rate_side_info {
@@ -118,7 +119,7 @@ typedef struct snd_pcm_rate_ops {
 
 /** open function type */
 typedef int (*snd_pcm_rate_open_func_t)(unsigned int version, void **objp,
-					snd_pcm_rate_ops_t *opsp);
+					snd_pcm_rate_ops_t *opsp, const snd_config_t *conf);
 
 /**
  * Define the object entry for external PCM rate-converter plugins
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index cbb7618..c0a60d7 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1258,7 +1258,7 @@ static const char *const default_rate_plugins[] = {
 	"speexrate", "linear", NULL
 };
 
-static int rate_open_func(snd_pcm_rate_t *rate, const char *type, int verbose)
+static int rate_open_func(snd_pcm_rate_t *rate, const char *type, const snd_config_t *converter_conf, int verbose)
 {
 	char open_name[64], lib_name[128], *lib = NULL;
 	snd_pcm_rate_open_func_t open_func;
@@ -1279,7 +1279,7 @@ static int rate_open_func(snd_pcm_rate_t *rate, const char *type, int verbose)
 	rate->rate_max = SND_PCM_PLUGIN_RATE_MAX;
 	rate->plugin_version = SND_PCM_RATE_PLUGIN_VERSION;
 
-	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops);
+	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops, converter_conf);
 	if (!err) {
 		rate->plugin_version = rate->ops.version;
 		if (rate->ops.get_supported_rates)
@@ -1292,7 +1292,7 @@ static int rate_open_func(snd_pcm_rate_t *rate, const char *type, int verbose)
 	/* try to open with the old protocol version */
 	rate->plugin_version = SND_PCM_RATE_PLUGIN_VERSION_OLD;
 	err = open_func(SND_PCM_RATE_PLUGIN_VERSION_OLD,
-			&rate->obj, &rate->ops);
+			&rate->obj, &rate->ops, NULL);
 	if (err) {
 		snd_dlobj_cache_put(open_func);
 		rate->open_func = NULL;
@@ -1353,21 +1353,21 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
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
 			if (snd_config_get_string(n, &type) < 0)
 				break;
-			err = rate_open_func(rate, type, 0);
+			err = rate_open_func(rate, type, converter, 0);
 			if (!err)
 				break;
 		}
@@ -1386,7 +1386,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 #else
 	type = "linear";
 	open_func = SND_PCM_RATE_PLUGIN_ENTRY(linear);
-	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops);
+	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops, 0);
 	if (err < 0) {
 		snd_pcm_free(pcm);
 		free(rate);
@@ -1439,6 +1439,11 @@ pcm.name {
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


--------------FCAEBB1346D64805222F83DA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------FCAEBB1346D64805222F83DA--
