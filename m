From: Pierre Ossman <ossman@cendio.se>
Subject: Re: [RFC][PATCH] Transparent network support through
 polypaudio
Date: Thu, 23 Feb 2006 14:02:21 +0100
Message-ID: <43FDB25D.402@cendio.se>
References: <43F09D76.9060004@cendio.se>	<43F61E6D.5020206@cendio.se>	<s5hirr8k7ra.wl%tiwai@suse.de>	<43FB420D.8010605@cendio.se>	<s5hfymck6k3.wl%tiwai@suse.de>	<43FC3374.2030701@cendio.se> <s5hirr7765t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060108020004000005000209"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28902199
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2006 14:02:25 +0100 (MET)
In-Reply-To: <s5hirr7765t.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mzcbylcnhqvb@0pointer.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060108020004000005000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Wed, 22 Feb 2006 10:48:36 +0100,
> Pierre Ossman wrote:
>> It seems your BTS cannot add cc:s, so I'll send you the diff here.
> 
> That's fine.  I always prefer mails than BTS (especially patches).
> Committed to CVS now.
> 
> Could you provide a brief instruction for polyp plugin, too?
> 

Here is a final update to the plugin and the documentation. This release 
adds capture volume and mute switches. This should also be the last API 
change in polypaudio before the next release, so this plugin should be 
stable for now.

-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com

--------------060108020004000005000209
Content-Type: text/x-patch;
 name="polyp-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="polyp-update.patch"

Index: polyp/ctl_polyp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/polyp/ctl_polyp.c,v
retrieving revision 1.1
diff -u -r1.1 ctl_polyp.c
--- polyp/ctl_polyp.c	21 Feb 2006 16:14:00 -0000	1.1
+++ polyp/ctl_polyp.c	23 Feb 2006 12:33:43 -0000
@@ -30,15 +30,23 @@
 
     snd_polyp_t *p;
 
-    char *device;
+    char *source;
+    char *sink;
 
-    pa_cvolume volume;
+    pa_cvolume sink_volume;
+    pa_cvolume source_volume;
+
+    int sink_muted;
+    int source_muted;
 
     int subscribed;
     int updated;
 } snd_ctl_polyp_t;
 
-#define MIXER_NAME "Master"
+#define SOURCE_VOL_NAME "Capture Volume"
+#define SOURCE_MUTE_NAME "Capture Switch"
+#define SINK_VOL_NAME "Master Playback Volume"
+#define SINK_MUTE_NAME "Master Playback Switch"
 
 static void sink_info_cb(pa_context *c, const pa_sink_info *i, int is_last, void *userdata)
 {
@@ -50,18 +58,52 @@
 
     assert(ctl && i);
 
-    if (ctl->volume.channels == i->volume.channels) {
-        for (chan = 0;chan < ctl->volume.channels;chan++)
-            if (i->volume.values[chan] != ctl->volume.values[chan])
+    if (ctl->sink_volume.channels == i->volume.channels) {
+        for (chan = 0;chan < ctl->sink_volume.channels;chan++)
+            if (i->volume.values[chan] != ctl->sink_volume.values[chan])
                 break;
 
-        if (chan == ctl->volume.channels)
+        if (chan == ctl->sink_volume.channels)
             return;
 
         ctl->updated = 1;
     }
 
-    memcpy(&ctl->volume, &i->volume, sizeof(pa_cvolume));
+    memcpy(&ctl->sink_volume, &i->volume, sizeof(pa_cvolume));
+
+    if (!!ctl->sink_muted != !!i->mute) {
+        ctl->sink_muted = i->mute;
+        ctl->updated = 1;
+    }
+}
+
+static void source_info_cb(pa_context *c, const pa_source_info *i, int is_last, void *userdata)
+{
+    snd_ctl_polyp_t *ctl = (snd_ctl_polyp_t*)userdata;
+    int chan;
+
+    if (is_last)
+        return;
+
+    assert(ctl && i);
+
+    if (ctl->source_volume.channels == i->volume.channels) {
+        for (chan = 0;chan < ctl->source_volume.channels;chan++)
+            if (i->volume.values[chan] != ctl->source_volume.values[chan])
+                break;
+
+        if (chan == ctl->source_volume.channels)
+            return;
+
+        ctl->updated = 1;
+    }
+
+    memcpy(&ctl->source_volume, &i->volume, sizeof(pa_cvolume));
+
+    if (!!ctl->source_muted != !!i->mute) {
+        ctl->source_muted = i->mute;
+        ctl->updated = 1;
+    }
 }
 
 static void event_cb(pa_context *c, pa_subscription_event_type_t t,
@@ -72,9 +114,13 @@
 
     assert(ctl && ctl->p && ctl->p->context);
 
-    o = pa_context_get_sink_info_by_name(ctl->p->context, ctl->device,
+    o = pa_context_get_sink_info_by_name(ctl->p->context, ctl->sink,
         sink_info_cb, ctl);
     pa_operation_unref(o);
+
+    o = pa_context_get_source_info_by_name(ctl->p->context, ctl->source,
+        source_info_cb, ctl);
+    pa_operation_unref(o);
 }
 
 static int polyp_update_volume(snd_ctl_polyp_t *ctl)
@@ -84,26 +130,36 @@
 
     assert(ctl && ctl->p && ctl->p->context);
 
-    o = pa_context_get_sink_info_by_name(ctl->p->context, ctl->device,
+    o = pa_context_get_sink_info_by_name(ctl->p->context, ctl->sink,
         sink_info_cb, ctl);
     err = polyp_wait_operation(ctl->p, o);
     pa_operation_unref(o);
     if (err < 0)
         return err;
 
+    o = pa_context_get_source_info_by_name(ctl->p->context, ctl->source,
+        source_info_cb, ctl);
+    err = polyp_wait_operation(ctl->p, o);
+    pa_operation_unref(o);
+    if (err < 0)
+        return err;
+
     return 0;
 }
 
 static int polyp_elem_count(snd_ctl_ext_t *ext)
 {
     snd_ctl_polyp_t *ctl = ext->private_data;
+    int count = 0;
 
     assert(ctl);
 
-    if (ctl->device)
-        return 1;
+    if (ctl->source)
+        count += 2;
+    if (ctl->sink)
+        count += 2;
 
-    return 0;
+    return count;
 }
 
 static int polyp_elem_list(snd_ctl_ext_t *ext, unsigned int offset,
@@ -114,7 +170,19 @@
     assert(ctl);
 
     snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
-    snd_ctl_elem_id_set_name(id, MIXER_NAME);
+
+    if (ctl->source) {
+        if (offset == 0)
+            snd_ctl_elem_id_set_name(id, SOURCE_VOL_NAME);
+        else if (offset == 1)
+            snd_ctl_elem_id_set_name(id, SOURCE_MUTE_NAME);
+    } else
+        offset += 2;
+
+    if (offset == 2)
+        snd_ctl_elem_id_set_name(id, SINK_VOL_NAME);
+    else if (offset == 3)
+        snd_ctl_elem_id_set_name(id, SINK_MUTE_NAME);
 
     return 0;
 }
@@ -126,8 +194,14 @@
 
     name = snd_ctl_elem_id_get_name(id);
 
-    if (strcmp(name, MIXER_NAME) == 0)
+    if (strcmp(name, SOURCE_VOL_NAME) == 0)
         return 0;
+    if (strcmp(name, SOURCE_MUTE_NAME) == 0)
+        return 1;
+    if (strcmp(name, SINK_VOL_NAME) == 0)
+        return 2;
+    if (strcmp(name, SINK_MUTE_NAME) == 0)
+        return 3;
 
     return SND_CTL_EXT_KEY_NOT_FOUND;
 }
@@ -140,7 +214,7 @@
 
     assert(ctl && ctl->p);
 
-    if (key != 0)
+    if (key > 3)
         return -EINVAL;
 
     err = polyp_finish_poll(ctl->p);
@@ -155,9 +229,19 @@
     if (err < 0)
         return err;
 
-    *type = SND_CTL_ELEM_TYPE_INTEGER;
+    if (key & 1)
+        *type = SND_CTL_ELEM_TYPE_BOOLEAN;
+    else
+        *type = SND_CTL_ELEM_TYPE_INTEGER;
+
     *acc = SND_CTL_EXT_ACCESS_READWRITE;
-    *count = ctl->volume.channels;
+
+    if (key == 0)
+        *count = ctl->source_volume.channels;
+    else if (key == 2)
+        *count = ctl->sink_volume.channels;
+    else
+        *count = 1;
 
     return 0;
 }
@@ -165,9 +249,6 @@
 static int polyp_get_integer_info(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key,
     long *imin, long *imax, long *istep)
 {
-    if (key != 0)
-        return -EINVAL;
-
     *istep = 1;
     *imin = 0;
     *imax = PA_VOLUME_NORM;
@@ -180,12 +261,10 @@
 {
     snd_ctl_polyp_t *ctl = ext->private_data;
     int err, i;
+    pa_cvolume *vol = NULL;
 
     assert(ctl && ctl->p);
 
-    if (key != 0)
-        return -EINVAL;
-
     err = polyp_finish_poll(ctl->p);
     if (err < 0)
         return err;
@@ -198,8 +277,27 @@
     if (err < 0)
         return err;
 
-    for (i = 0;i < ctl->volume.channels;i++)
-        value[i] = ctl->volume.values[i];
+    switch (key) {
+    case 0:
+        vol = &ctl->source_volume;
+        break;
+    case 1:
+        *value = !ctl->source_muted;
+        break;
+    case 2:
+        vol = &ctl->sink_volume;
+        break;
+    case 3:
+        *value = !ctl->sink_muted;
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    if (vol) {
+        for (i = 0;i < vol->channels;i++)
+            value[i] = vol->values[i];
+    }
 
     return 0;
 }
@@ -209,14 +307,11 @@
 {
     snd_ctl_polyp_t *ctl = ext->private_data;
     int err, i;
-    pa_cvolume vol;
     pa_operation *o;
+    pa_cvolume *vol = NULL;
 
     assert(ctl && ctl->p && ctl->p->context);
 
-    if (key != 0)
-        return -EINVAL;
-
     err = polyp_finish_poll(ctl->p);
     if (err < 0)
         return err;
@@ -229,21 +324,52 @@
     if (err < 0)
         return err;
 
-    for (i = 0;i < ctl->volume.channels;i++)
-        if (value[i] != ctl->volume.values[i])
-            break;
+    switch (key) {
+    case 0:
+        vol = &ctl->source_volume;
+        break;
+    case 1:
+        if (!!ctl->source_muted == !*value)
+            return 0;
+        ctl->source_muted = !*value;
+        break;
+    case 2:
+        vol = &ctl->sink_volume;
+        break;
+    case 3:
+        if (!!ctl->sink_muted == !*value)
+            return 0;
+        ctl->sink_muted = !*value;
+        break;
+    default:
+        return -EINVAL;
+    }
 
-    if (i == ctl->volume.channels)
-        return 0;
+    if (vol) {
+        for (i = 0;i < vol->channels;i++)
+            if (value[i] != vol->values[i])
+                break;
 
-    memset(&vol, 0, sizeof(pa_cvolume));
+        if (i == vol->channels)
+            return 0;
 
-    vol.channels = ctl->volume.channels;
-    for (i = 0;i < vol.channels;i++)
-        vol.values[i] = value[i];
+        for (i = 0;i < vol->channels;i++)
+            vol->values[i] = value[i];
 
-    o = pa_context_set_sink_volume_by_name(ctl->p->context, ctl->device, &vol,
-        NULL, NULL);
+        if (key == 0)
+            o = pa_context_set_source_volume_by_name(ctl->p->context,
+                ctl->source, vol, NULL, NULL);
+        else
+            o = pa_context_set_sink_volume_by_name(ctl->p->context,
+                ctl->sink, vol, NULL, NULL);
+    } else {
+        if (key == 1)
+            o = pa_context_set_source_mute_by_name(ctl->p->context,
+                ctl->source, ctl->source_muted, NULL, NULL);
+        else
+            o = pa_context_set_sink_mute_by_name(ctl->p->context,
+                ctl->sink, ctl->sink_muted, NULL, NULL);
+    }
 
     err = polyp_wait_operation(ctl->p, o);
     pa_operation_unref(o);
@@ -325,8 +451,10 @@
     if (ctl->p)
         polyp_free(ctl->p);
 
-    if (ctl->device)
-        free(ctl->device);
+    if (ctl->source)
+        free(ctl->source);
+    if (ctl->sink)
+        free(ctl->sink);
 
 	free(ctl);
 }
@@ -351,9 +479,12 @@
 {
     snd_ctl_polyp_t *ctl = (snd_ctl_polyp_t*)userdata;
 
-    assert(ctl && i && i->default_sink_name);
+    assert(ctl && i);
 
-    ctl->device = strdup(i->default_sink_name);
+    if (i->default_source_name && !ctl->source)
+        ctl->source = strdup(i->default_source_name);
+    if (i->default_sink_name && !ctl->sink)
+        ctl->sink = strdup(i->default_sink_name);
 }
 
 SND_CTL_PLUGIN_DEFINE_FUNC(polyp)
@@ -361,6 +492,8 @@
 	snd_config_iterator_t i, next;
 	const char *server = NULL;
 	const char *device = NULL;
+	const char *source = NULL;
+	const char *sink = NULL;
 	int err;
 	snd_ctl_polyp_t *ctl;
     pa_operation *o;
@@ -386,6 +519,20 @@
             }
             continue;
         }
+        if (strcmp(id, "source") == 0) {
+            if (snd_config_get_string(n, &source) < 0) {
+                SNDERR("Invalid type for %s", id);
+                return -EINVAL;
+            }
+            continue;
+        }
+        if (strcmp(id, "sink") == 0) {
+            if (snd_config_get_string(n, &sink) < 0) {
+                SNDERR("Invalid type for %s", id);
+                return -EINVAL;
+            }
+            continue;
+        }
 		SNDERR("Unknown field %s", id);
 		return -EINVAL;
 	}
@@ -403,9 +550,17 @@
     if (err < 0)
         goto error;
 
-    if (device)
-        ctl->device = strdup(device);
-    else {
+    if (source)
+        ctl->source = strdup(source);
+    else if (device)
+        ctl->source = strdup(device);
+
+    if (sink)
+        ctl->sink = strdup(sink);
+    else if (device)
+        ctl->sink = strdup(device);
+
+    if (!ctl->source || !ctl->sink) {
         o = pa_context_get_server_info(ctl->p->context, server_info_cb, ctl);
         err = polyp_wait_operation(ctl->p, o);
         pa_operation_unref(o);
@@ -415,7 +570,8 @@
 
     pa_context_set_subscribe_callback(ctl->p->context, event_cb, ctl);
 
-    o = pa_context_subscribe(ctl->p->context, PA_SUBSCRIPTION_MASK_SINK, NULL, NULL);
+    o = pa_context_subscribe(ctl->p->context,
+        PA_SUBSCRIPTION_MASK_SINK | PA_SUBSCRIPTION_MASK_SOURCE, NULL, NULL);
     err = polyp_wait_operation(ctl->p, o);
     pa_operation_unref(o);
     if (err < 0)
@@ -441,8 +597,10 @@
     return 0;
 
 error:
-    if (ctl->device)
-        free(ctl->device);
+    if (ctl->source)
+        free(ctl->source);
+    if (ctl->sink)
+        free(ctl->sink);
 
     if (ctl->p)
         polyp_free(ctl->p);

--------------060108020004000005000209
Content-Type: text/plain;
 name="README-polyp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README-polyp"

Polypaudio <--> ALSA plugins
============================

This plugin allows any program that uses the ALSA API to access a Polypaudio
sound daemon. In other words, native ALSA applications can play and record
sound across a network.

There are two plugins in the suite, one for PCM and one for mixer control. A
typical configuration will look like:

    pcm.polyp {
        type polyp
    }

    ctl.polyp {
        type polyp
    }

Put the above in ~/.asoundrc, or /etc/asound.conf, and use "polyp" as device
in your ALSA applications. For example:

    % aplay -Dpolyp foo.wav
    % amixer -Dpolyp

Polypaudio will accept more or less any format you throw at it. So a plug
wrapper is unnecessary. Mixing is also handled so dmix will only cause a
performance hit without any gain.

The plugins will respect your Polypaudio environment variables (like
POLYP_SERVER), but you can override these in ALSA's configuration files.

Both plugins accept the "server" parameter, specifying which Polypaudio server
to contact. Both also accept the "device" parameter, which indicate which
source and sink to use.

The mixer control plugin also accepts the parameters "source" and "sink" for
when you need to specify a sink/source combination with different names. If
you need to do this with PCM:s then specify two PCM:s with different "device".

If you do not specify any source and/or sink, then the server's defaults will
be used.

--------------060108020004000005000209--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
