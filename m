From: Sjoerd Simons <sjoerd@luon.net>
Subject: Pulseaudio alsa configure hook
Date: Sun, 27 Apr 2008 22:37:09 +0200
Message-ID: <20080427203709.GA13496@spring.luon.net>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
Content-Disposition: inline
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: alsa-devel@alsa-project.org, pulseaudio-discuss@mail.0pointer.de
List-Id: alsa-devel@alsa-project.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

  The attached patch extends the alsa pulse plugin set with a alsa
  configuration hook. Allowing one to specify some configuration parameters
  that only come into effect when pulseaudio is running.

  For example a configution file like:

    @hooks [ {
       func on_pulse_is_running
         pcm.!default { type pulse }
         ctl.!default { type pulse }
       }
   ]

  will redirect the default alsa pcm and ctl to pulse iff pulse is running.
  (Assuming you defined the hook function correctly ofcourse)

  This is usefull for distributions that don't want to force their users to
  switch completely to pulseaudio, but have things a bit more dynamic :)

  The solutions isn't optimal though. It will mean that every program loading
  accessing alsa will try to make an (extra) connection to pulse to decide what
  to do. But i think it's the best we can do for now (or at least that i can do
  with my minimal knowledge of alsa).

  A nicer solution would be a way to always specify the pulse plugin as default
  and have a sort of fallback for when that fails.

  Comments on the patch appreciated :)

  Sjoerd
PS: I'm not on alsa-devel, so please keep me in the CC
-- 
GREAT MOMENTS IN HISTORY (#7):  April 2, 1751

Issac Newton becomes discouraged when he falls up a flight of stairs.

--IS0zKkzwUGydFO0o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="pulse-running-hook.patch"

diff -r 1c30b7b2a8a3 pulse/Makefile.am
--- a/pulse/Makefile.am	Tue Apr 22 18:34:03 2008 +0200
+++ b/pulse/Makefile.am	Sun Apr 27 22:19:32 2008 +0200
@@ -1,8 +1,10 @@
 asound_module_pcm_LTLIBRARIES = libasound_module_pcm_pulse.la
 asound_module_ctl_LTLIBRARIES = libasound_module_ctl_pulse.la
+asound_module_conf_LTLIBRARIES = libasound_module_conf_pulse.la
 
 asound_module_pcmdir = @ALSA_PLUGIN_DIR@
 asound_module_ctldir = @ALSA_PLUGIN_DIR@
+asound_module_confdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@ $(PTHREAD_CFLAGS) $(pulseaudio_CFLAGS) -D_GNU_SOURCE
 AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined
@@ -12,3 +14,6 @@
 
 libasound_module_ctl_pulse_la_SOURCES = ctl_pulse.c pulse.c pulse.h
 libasound_module_ctl_pulse_la_LIBADD = @ALSA_LIBS@ $(PTHREAD_LIBS) $(pulseaudio_LIBS)
+
+libasound_module_conf_pulse_la_SOURCES = conf_pulse.c
+libasound_module_conf_pulse_la_LIBADD = @ALSA_LIBS@ $(PTHREAD_LIBS) $(pulseaudio_LIBS)
diff -r 1c30b7b2a8a3 pulse/conf_pulse.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/pulse/conf_pulse.c	Sun Apr 27 22:19:32 2008 +0200
@@ -0,0 +1,88 @@
+/*
+ * ALSA configuration function extensions for pulse
+ *
+ * Copyright (c) 2008 by Sjoerd Simons <sjoerd@luon.net>
+ *
+ * This library is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU Lesser General Public License as
+ * published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free
+ * Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+ *
+ */
+
+#include <stdio.h>
+
+#include <alsa/asoundlib.h>
+#include <pulse/pulseaudio.h>
+
+
+int
+conf_pulse_hook_on_is_running (snd_config_t *root, snd_config_t *config,
+    snd_config_t **dst, snd_config_t *private_data) {
+  snd_config_t *n = NULL;
+  pa_mainloop *loop = NULL;
+  pa_context *context = NULL;
+  int ret = 0, err, state;
+
+
+  /* Defined if we're called inside the pulsedaemon itself */
+  if (getenv("PULSE_INTERNAL") != NULL)
+    goto out;
+
+  loop = pa_mainloop_new();
+  if (loop == NULL)
+    goto out;
+
+  context = pa_context_new(pa_mainloop_get_api(loop), "Alsa hook");
+  if (context == NULL)
+    goto out;
+
+  err = pa_context_connect (context, NULL, 0, NULL);
+  if (err < 0)
+    goto out;
+
+  do {
+    err = pa_mainloop_prepare (loop, -1);
+    if (err < 0)
+       goto out;
+
+    err = pa_mainloop_poll (loop);
+    if (err < 0)
+      goto out;
+
+    err = pa_mainloop_dispatch (loop);
+    if (err < 0)
+      goto out;
+
+    state = pa_context_get_state(context);
+  } while (state < PA_CONTEXT_READY);
+
+  if (state != PA_CONTEXT_READY)
+    goto out;
+
+  ret = snd_config_expand(config, root, NULL, private_data, &n);
+
+out:
+  if (context != NULL)
+    pa_context_unref(context);
+
+  if (loop != NULL)
+    pa_mainloop_free(loop);
+
+  *dst = n;
+
+  return ret;
+}
+
+SND_DLSYM_BUILD_VERSION(conf_pulse_hook_on_is_running,
+  SND_CONFIG_DLSYM_VERSION_HOOK);

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@mail.0pointer.de
https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss

--IS0zKkzwUGydFO0o--
