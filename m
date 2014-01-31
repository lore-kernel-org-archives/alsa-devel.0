From: "Corfu, ValentinX" <valentinx.corfu@intel.com>
Subject: [alsa-plugins] [PATCH 2/2] Allow number of channels
Date: Fri, 31 Jan 2014 14:05:48 +0000
Message-ID: <9900E8BE2ADAAB43B2A4471493EDB7F94B12EB@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "patch@alsa-project.org" <patch@alsa-project.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Trandafir,
 IonutX" <ionutx.trandafir@intel.com>
List-Id: alsa-devel@alsa-project.org

>From 92cf8488d3d2e271fdb4b1fb41fbc006cc59677b Mon Sep 17 00:00:00 2001
From: Valentin Corfu <valentinx.corfu@intel.com>
Date: Fri, 31 Jan 2014 08:08:51 -0500
Subject: [PATCH 2/2] Allow number of channels

The modification allows to specify the number of channels as parameters in the configuration file
The given number of channels are then created but not connected.

Signed-off-by: Valentin Corfu <valentinx.corfu@intel.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 475c619..feef4a0 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -325,7 +325,7 @@ static int make_nonblock(int fd)
 static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
                  snd_config_t *playback_conf,
                  snd_config_t *capture_conf,
-                 snd_pcm_stream_t stream, int mode)
+                 snd_pcm_stream_t stream, int mode, long num_channels)
 {
     snd_pcm_jack_t *jack;
     int err;
@@ -341,11 +341,19 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
     jack->fd = -1;
     jack->io.poll_fd = -1;

-    err = parse_ports(jack, stream == SND_PCM_STREAM_PLAYBACK ?
-              playback_conf : capture_conf);
-    if (err) {
-        snd_pcm_jack_free(jack);
-        return err;
+    if (num_channels > 0) {
+        jack->num_ports = num_channels;
+        jack->port_names = calloc(num_channels, sizeof(char*));
+        if (jack->port_names == NULL)
+            return -ENOMEM;
+    }
+    else {
+        err = parse_ports(jack, stream == SND_PCM_STREAM_PLAYBACK ?
+                  playback_conf : capture_conf);
+        if (err) {
+            snd_pcm_jack_free(jack);
+            return err;
+        }
     }

     jack->channels = jack->num_ports;
@@ -422,6 +430,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
     snd_config_t *playback_conf = NULL;
     snd_config_t *capture_conf = NULL;
     int err;
+    long num_channels = 0;

     snd_config_for_each(i, next, conf) {
         snd_config_t *n = snd_config_iterator_entry(i);
@@ -434,6 +443,10 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
             snd_config_get_string(n, &name);
             continue;
         }
+        if (strcmp(id, "nchan") == 0) {
+            snd_config_get_integer(n, &num_channels);
+            continue;
+        }
         if (strcmp(id, "playback_ports") == 0) {
             if (snd_config_get_type(n) != SND_CONFIG_TYPE_COMPOUND) {
                 SNDERR("Invalid type for %s", id);
@@ -454,7 +467,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(jack)
         return -EINVAL;
     }

-    err = snd_pcm_jack_open(pcmp, name, playback_conf, capture_conf, stream, mode);
+    err = snd_pcm_jack_open(pcmp, name, playback_conf, capture_conf, stream, mode, num_channels);

     return err;
 }
--
1.8.1.4

--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.
