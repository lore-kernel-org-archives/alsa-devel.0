From: Alex <alex@le-verger.org>
Subject: [PATCH] external plugin for adding delay to channels
Date: Tue, 30 Sep 2008 22:51:23 +0200
Message-ID: <200809302251.23243.alex@le-verger.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LFp4IW9NCrZTyOK"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.republique.smartjog.net (fw.sj.tdf-pmm.net [91.197.165.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CE0B2463F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 22:51:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mx.republique.smartjog.net (Postfix) with ESMTP id CA08C572C4
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 22:51:29 +0200 (CEST)
Received: from mx.republique.smartjog.net ([127.0.0.1])
	by localhost (mail.dmz-ext.rep.sj [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OhjIuO+OI-jz for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 22:51:24 +0200 (CEST)
Received: from platyn.localnet (cadmium.le-verger.org [88.164.73.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.republique.smartjog.net (Postfix) with ESMTP id 6EC94572BF
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 22:51:24 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_LFp4IW9NCrZTyOK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This should be interesting for home theater installations, as I was 
personnally missing a "per channel delay configuration".

Feel free to tell me what should be modified, I am not really used to proposing 
a patch.

Thx

--Boundary-00=_LFp4IW9NCrZTyOK
Content-Type: text/x-patch;
  charset="us-ascii";
  name="alsa-plugins-1.0.17_delay.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alsa-plugins-1.0.17_delay.patch"

diff -x libtool -x stamp-h1 -x .vimrc -x rate -x Makefile.in -x Makefile -x=
 .deps -x configure -x config.status -x config.h -x config.log -x a52 -x '*=
cache*' -x '*aclocal*' -Naur alsa-plugins-1.0.17/configure.in alsa-plugins-=
1.0.17+delay/configure.in
=2D-- alsa-plugins-1.0.17/configure.in	2008-07-14 10:57:59.000000000 +0200
+++ alsa-plugins-1.0.17+delay/configure.in	2008-09-24 10:52:23.000000000 +0=
200
@@ -89,6 +89,9 @@
 fi
=20
 AM_CONDITIONAL(HAVE_PPH, test "$PPH" =3D "builtin" -o "$PPH" =3D "lib")
+
+AM_CONDITIONAL(HAVE_DELAY, test x$HAVE_DELAY =3D xyes)
+
 AM_CONDITIONAL(USE_LIBSPEEX, test "$PPH" =3D "lib")
=20
 dnl ALSA plugin directory
@@ -124,6 +127,7 @@
 	a52/Makefile
 	rate-lavc/Makefile
 	maemo/Makefile
+    delay/Makefile
 	doc/Makefile
 ])
=20
diff -x libtool -x stamp-h1 -x .vimrc -x rate -x Makefile.in -x Makefile -x=
 .deps -x configure -x config.status -x config.h -x config.log -x a52 -x '*=
cache*' -x '*aclocal*' -Naur alsa-plugins-1.0.17/delay/Makefile.am alsa-plu=
gins-1.0.17+delay/delay/Makefile.am
=2D-- alsa-plugins-1.0.17/delay/Makefile.am	1970-01-01 01:00:00.000000000 +=
0100
+++ alsa-plugins-1.0.17+delay/delay/Makefile.am	2008-09-27 00:26:05.0000000=
00 +0200
@@ -0,0 +1,9 @@
+asound_module_pcm_delay_LTLIBRARIES =3D libasound_module_pcm_delay.la
+
+asound_module_pcm_delaydir =3D @ALSA_PLUGIN_DIR@
+
+AM_CFLAGS =3D -Wall -g @ALSA_CFLAGS@
+AM_LDFLAGS =3D -module -avoid-version -export-dynamic -no-undefined
+
+libasound_module_pcm_delay_la_SOURCES =3D pcm_delay.c
+libasound_module_pcm_delay_la_LIBADD =3D @ALSA_LIBS@
diff -x libtool -x stamp-h1 -x .vimrc -x rate -x Makefile.in -x Makefile -x=
 .deps -x configure -x config.status -x config.h -x config.log -x a52 -x '*=
cache*' -x '*aclocal*' -Naur alsa-plugins-1.0.17/delay/pcm_delay.c alsa-plu=
gins-1.0.17+delay/delay/pcm_delay.c
=2D-- alsa-plugins-1.0.17/delay/pcm_delay.c	1970-01-01 01:00:00.000000000 +=
0100
+++ alsa-plugins-1.0.17+delay/delay/pcm_delay.c	2008-09-30 21:57:56.0000000=
00 +0200
@@ -0,0 +1,335 @@
+/*
+ * Delay Output Plugin
+ *
+ * Copyright (c) 2008 by Alexandre BUISINE <alex@le-verger.org>
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
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <stdio.h>
+#include <assert.h>
+#include <alsa/asoundlib.h>
+#include <alsa/pcm_external.h>
+
+#define SND_PCM_DELAY_PARSE_MS      1
+#define SND_PCM_DELAY_PARSE_METER   2
+#define SND_PCM_DELAY_PARSE_FEET    3
+
+/* Ambient temperature is 20=B0 celsius */
+#define SND_PCM_DELAY_CELERITY  ( 331.5 + 0.6 * 20 )
+#define SND_PCM_DELAY_FEET  3.28083989501
+
+#define round(x) ((int)((x)+0.5))
+
+
+typedef struct {
+    snd_pcm_extplug_t   ext;
+   =20
+    double          *delay_ms;
+    unsigned int    *delay_sample;
+
+    snd_pcm_channel_area_t  *dly_areas;
+    snd_pcm_uframes_t       *dly_offset;
+
+    unsigned int    channels;
+    unsigned int    mode;
+} snd_pcm_delay_t;
+
+static int  snd_pcm_delay_parse_delay(snd_pcm_delay_t *pcm_delay,
+                                    snd_config_t    *conf_delay,
+                                    unsigned char   mode)
+{
+    snd_config_iterator_t i, next;
+    double  *delays;
+    double  delay =3D 0.0;
+    unsigned int    cnt =3D 0;
+    unsigned int    channel;
+    double  val;
+   =20
+    pcm_delay->mode =3D mode;
+    if (conf_delay) {
+        snd_config_for_each(i, next, conf_delay) {
+            snd_config_t *n =3D snd_config_iterator_entry(i);
+            const char *id;
+            if (snd_config_get_id(n, &id) < 0)
+                continue;
+            cnt++;
+        }
+        pcm_delay->delay_ms =3D delays =3D calloc(cnt, sizeof(double));
+        if (delays =3D=3D NULL)
+            return -ENOMEM;
+        pcm_delay->channels =3D cnt;
+        snd_config_for_each(i, next, conf_delay) {
+            snd_config_t    *n =3D snd_config_iterator_entry(i);
+            const char  *id;
+
+            if (snd_config_get_id(n, &id) < 0)
+                continue;
+            channel =3D atoi(id);
+            if (snd_config_get_ireal(n, &val) < 0)
+                continue;
+            if (mode =3D=3D SND_PCM_DELAY_PARSE_MS)
+                delay =3D val;
+            if (mode =3D=3D SND_PCM_DELAY_PARSE_METER)
+                delay =3D ( val / SND_PCM_DELAY_CELERITY ) * 1000;
+            if (mode =3D=3D SND_PCM_DELAY_PARSE_FEET)
+                delay =3D ( val / SND_PCM_DELAY_FEET / SND_PCM_DELAY_CELER=
ITY ) * 1000;
+            delays[channel] =3D delay;
+        }
+        if (pcm_delay->mode =3D=3D SND_PCM_DELAY_PARSE_METER
+                || pcm_delay->mode =3D=3D SND_PCM_DELAY_PARSE_FEET) {
+            double  max =3D 0.0;
+
+            unsigned int    j;
+            for (j =3D 0; j < cnt; j++)
+                max =3D delays[j] > max ? delays[j] : max;
+            for (j =3D 0; j < pcm_delay->channels; j++)
+                delays[j] =3D max - delays[j];
+        }
+   }
+    return 0;
+}
+
+static void snd_pcm_delay_free(snd_pcm_delay_t *pcm_delay) {
+    if (pcm_delay) {
+        if (pcm_delay->delay_ms)
+            free(pcm_delay->delay_ms);
+        if (pcm_delay->delay_sample)
+            free(pcm_delay->delay_sample);
+        if (pcm_delay->dly_offset)
+            free(pcm_delay->dly_offset);
+        if (pcm_delay->dly_areas) {
+            unsigned int    i;
+            for (i =3D 0; i < pcm_delay->channels; i++)
+                if (pcm_delay->dly_areas[i].addr)
+                    free(pcm_delay->dly_areas[i].addr);
+            free(pcm_delay->dly_areas);
+        }
+    }
+    free(pcm_delay);
+    return;
+}
+
+/* Converting delay in ms to delay in sample */
+static int  snd_pcm_delay_init(snd_pcm_extplug_t   *ext)
+{
+    snd_pcm_delay_t *pcm_delay =3D (snd_pcm_delay_t *)ext;
+    unsigned int    i;
+
+    pcm_delay->delay_sample =3D calloc(pcm_delay->channels, sizeof(unsigne=
d int));
+    if (pcm_delay->delay_sample =3D=3D NULL)
+        return -ENOMEM;
+    for (i =3D 0; i < pcm_delay->channels; i++)
+        pcm_delay->delay_sample[i] =3D round(pcm_delay->ext.rate
+                                        * pcm_delay->delay_ms[i]
+                                        / 1000);
+    pcm_delay->dly_offset =3D calloc(pcm_delay->channels, sizeof(snd_pcm_u=
frames_t));
+    if (pcm_delay->dly_offset =3D=3D NULL)
+        return -ENOMEM;
+    pcm_delay->dly_areas =3D calloc(pcm_delay->channels, sizeof(snd_pcm_ch=
annel_area_t));
+    if (pcm_delay->dly_areas =3D=3D NULL)
+        return -ENOMEM;
+    for (i =3D 0; i < pcm_delay->channels; i++) {
+        pcm_delay->dly_areas[i].addr =3D
+            malloc(pcm_delay->delay_sample[i]
+                * snd_pcm_format_physical_width(pcm_delay->ext.format) / 8=
);
+        pcm_delay->dly_areas[i].first =3D 0;
+        pcm_delay->dly_areas[i].step =3D snd_pcm_format_physical_width(pcm=
_delay->ext.format);
+        snd_pcm_area_silence(pcm_delay->dly_areas + i, 0,
+               pcm_delay->delay_sample[i], pcm_delay->ext.format);
+        if (pcm_delay->dly_areas[i].addr =3D=3D NULL)
+            return -ENOMEM;
+        }
+    return 0;
+}
+
+static int  snd_pcm_delay_close(snd_pcm_extplug_t   *ext)
+{
+    snd_pcm_delay_t *pcm_delay =3D (snd_pcm_delay_t *)ext;
+
+    snd_pcm_delay_free(pcm_delay);
+    return 0;
+}
+
+static snd_pcm_sframes_t    snd_pcm_delay_transfer(snd_pcm_extplug_t    *e=
xt,
+                                                const snd_pcm_channel_area=
_t    *dst_areas,
+                                                snd_pcm_uframes_t   dst_of=
fset,
+                                                const snd_pcm_channel_area=
_t    *src_areas,
+                                                snd_pcm_uframes_t   src_of=
fset,
+                                                snd_pcm_uframes_t   size)
+{
+    snd_pcm_delay_t *pcm_delay =3D (snd_pcm_delay_t *)ext;
+    unsigned int i;
+    snd_pcm_uframes_t   left;
+
+    for (i =3D 0; i < pcm_delay->ext.channels; i++) {
+        if (! pcm_delay->delay_sample[i]) {
+            snd_pcm_area_copy(dst_areas + i, dst_offset,
+                            src_areas + i, src_offset,
+                            size, pcm_delay->ext.format);
+            continue;
+        }
+        if (pcm_delay->delay_sample[i] <=3D size) {
+            assert(! pcm_delay->dly_offset[i]);
+            left =3D size - pcm_delay->delay_sample[i];
+            /* delay to dst */
+            snd_pcm_area_copy(dst_areas + i, dst_offset,
+                            pcm_delay->dly_areas + i, 0,
+                            pcm_delay->delay_sample[i], pcm_delay->ext.for=
mat);
+            if (left) {
+                /* src to dst left */
+                snd_pcm_area_copy(dst_areas + i, dst_offset + pcm_delay->d=
elay_sample[i],
+                                src_areas + i, src_offset,
+                                left, pcm_delay->ext.format);
+            }
+            /* src left to delay */
+            snd_pcm_area_copy(pcm_delay->dly_areas + i, 0,
+                            src_areas + i, src_offset + left,
+                            pcm_delay->delay_sample[i], pcm_delay->ext.for=
mat);
+            continue;
+        }
+        /* usual (small) delays wont reach this part of the code */
+        left =3D pcm_delay->dly_offset[i] + size > pcm_delay->delay_sample=
[i]
+            ? (pcm_delay->dly_offset[i] + size) % pcm_delay->delay_sample[=
i] : 0;
+        /* copy dly to dst */
+        snd_pcm_area_copy(dst_areas + i, dst_offset,
+                pcm_delay->dly_areas + i, pcm_delay->dly_offset[i],
+                size - left, pcm_delay->ext.format);
+        /* copy src to dly */
+        snd_pcm_area_copy(pcm_delay->dly_areas + i, pcm_delay->dly_offset[=
i],
+                src_areas + i, src_offset,
+                size - left, pcm_delay->ext.format);
+        if (left) {
+            /* copy dly to dst */
+            snd_pcm_area_copy(dst_areas + i, dst_offset + size - left,
+                    pcm_delay->dly_areas + i, 0,
+                    left, pcm_delay->ext.format);
+            /* copy src to dly */
+            snd_pcm_area_copy(pcm_delay->dly_areas + i, 0,
+                    src_areas + i, src_offset + size - left,
+                    left, pcm_delay->ext.format);
+            pcm_delay->dly_offset[i] =3D left;
+            continue;
+        }
+        pcm_delay->dly_offset[i] +=3D size;
+    }
+    return size;
+}
+
+static snd_pcm_extplug_callback_t   snd_pcm_delay_callback =3D {
+    .transfer =3D snd_pcm_delay_transfer,
+    .init =3D snd_pcm_delay_init,
+    .close =3D snd_pcm_delay_close,
+};
+
+/*
+ * Main entry point
+ */
+SND_PCM_PLUGIN_DEFINE_FUNC(delay)
+{
+    snd_config_iterator_t   i, next;
+    snd_config_t    *slave_conf =3D NULL;
+    snd_config_t    *delays =3D NULL;
+    snd_pcm_delay_t *pcm_delay;
+    static unsigned int chlist[6] =3D {1, 2, 3, 4, 5, 6};
+    unsigned int    parser_mode =3D 0;
+    int err;
+
+    snd_config_for_each(i, next, conf) {
+        snd_config_t *n =3D snd_config_iterator_entry(i);
+        const char *id;
+        if (snd_config_get_id(n, &id) < 0)
+            continue;
+        if (strcmp(id, "comment") =3D=3D 0 || strcmp(id, "type") =3D=3D 0)
+            continue;
+        if (strcmp(id, "slave") =3D=3D 0) {
+            slave_conf =3D n;
+            continue;
+        }
+        if (strcmp(id, "delay_ms") =3D=3D 0) {
+            if (snd_config_get_type(n) !=3D SND_CONFIG_TYPE_COMPOUND) {
+                SNDERR("Invalid type for %s", id);
+                return -EINVAL;
+            }
+            delays =3D n;
+            parser_mode =3D SND_PCM_DELAY_PARSE_MS;
+            continue;
+        }
+        if (strcmp(id, "delay_meter") =3D=3D 0) {
+            if (snd_config_get_type(n) !=3D SND_CONFIG_TYPE_COMPOUND) {
+                SNDERR("Invalid type for %s", id);
+                return -EINVAL;
+            }
+            delays =3D n;
+            parser_mode =3D SND_PCM_DELAY_PARSE_METER;
+            continue;
+        }
+        if (strcmp(id, "delay_feet") =3D=3D 0) {
+            if (snd_config_get_type(n) !=3D SND_CONFIG_TYPE_COMPOUND) {
+                SNDERR("Invalid type for %s", id);
+                return -EINVAL;
+            }
+            delays =3D n;
+            parser_mode =3D SND_PCM_DELAY_PARSE_FEET;
+            continue;
+        }
+         SNDERR("Unknown field %s", id);
+        return -EINVAL;
+    }
+
+    if (! slave_conf) {
+        SNDERR("No slave defined for delay");
+        return -EINVAL;
+    }
+
+    pcm_delay =3D calloc(1, sizeof(*pcm_delay));
+    if (pcm_delay =3D=3D NULL)
+        return -ENOMEM;
+
+    pcm_delay->ext.version =3D SND_PCM_EXTPLUG_VERSION;
+    pcm_delay->ext.name =3D "Delay plugin";
+    pcm_delay->ext.callback =3D &snd_pcm_delay_callback;
+    pcm_delay->ext.private_data =3D pcm_delay;
+
+    err =3D snd_pcm_extplug_create(&pcm_delay->ext, name, root, slave_conf=
, stream, mode);
+    if (err < 0) {
+        snd_pcm_delay_free(pcm_delay);
+        return err;
+    }
+
+    if (delays) {
+        err =3D snd_pcm_delay_parse_delay(pcm_delay, delays, parser_mode);
+        if (err < 0) {
+            snd_pcm_delay_free(pcm_delay);
+            return err;
+        }
+    }
+
+    snd_pcm_extplug_set_param_minmax(&pcm_delay->ext,
+                                    SND_PCM_EXTPLUG_HW_CHANNELS,
+                                    1, 6);
+    snd_pcm_extplug_set_param_list(&pcm_delay->ext,
+                                SND_PCM_EXTPLUG_HW_CHANNELS,
+                                6, chlist);
+    snd_pcm_extplug_set_param(&pcm_delay->ext, SND_PCM_EXTPLUG_HW_FORMAT,
+                            SND_PCM_FORMAT_S16);
+    snd_pcm_extplug_set_slave_param(&pcm_delay->ext, SND_PCM_EXTPLUG_HW_FO=
RMAT,
+                                SND_PCM_FORMAT_S16);
+
+    *pcmp =3D pcm_delay->ext.pcm;
+    return 0;
+}
+
+SND_PCM_PLUGIN_SYMBOL(delay);
diff -x libtool -x stamp-h1 -x .vimrc -x rate -x Makefile.in -x Makefile -x=
 .deps -x configure -x config.status -x config.h -x config.log -x a52 -x '*=
cache*' -x '*aclocal*' -Naur alsa-plugins-1.0.17/doc/delay.txt alsa-plugins=
=2D1.0.17+delay/doc/delay.txt
=2D-- alsa-plugins-1.0.17/doc/delay.txt	1970-01-01 01:00:00.000000000 +0100
+++ alsa-plugins-1.0.17+delay/doc/delay.txt	2008-09-30 22:36:41.000000000 +=
0200
@@ -0,0 +1,22 @@
+DELAY PLUGIN
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The delay plugin is an easy-to-use plugin for delaying 1 to 6 channels
+stream.  The number of channels to be delayed is determined by the
+slave PCM.  For example, the following PCM defines 3 delays but only 2
+will be applied:
+
+    pcm.delay3 {
+        type delay
+        delay_ms.0 10
+        delay_ms.1 10
+        delay_ms.2 20
+        slave.pcm "default"
+    }
+
+You can give the delay to be applied by using one of the following
+option:
+
+delay_ms
+delay_meter
+delay_feet
diff -x libtool -x stamp-h1 -x .vimrc -x rate -x Makefile.in -x Makefile -x=
 .deps -x configure -x config.status -x config.h -x config.log -x a52 -x '*=
cache*' -x '*aclocal*' -Naur alsa-plugins-1.0.17/doc/Makefile.am alsa-plugi=
ns-1.0.17+delay/doc/Makefile.am
=2D-- alsa-plugins-1.0.17/doc/Makefile.am	2008-07-14 10:57:59.000000000 +02=
00
+++ alsa-plugins-1.0.17+delay/doc/Makefile.am	2008-09-30 22:29:52.000000000=
 +0200
@@ -1,3 +1,3 @@
=2DEXTRA_DIST =3D README-pcm-oss README-jack README-pulse README-maemo \
+EXTRA_DIST =3D README-pcm-oss README-jack README-pulse README-maemo README=
=2Ddelay\
 	upmix.txt vdownmix.txt samplerate.txt a52.txt lavcrate.txt \
=2D	speexrate.txt
+	speexrate.txt delay.txt
diff -x libtool -x stamp-h1 -x .vimrc -x rate -x Makefile.in -x Makefile -x=
 .deps -x configure -x config.status -x config.h -x config.log -x a52 -x '*=
cache*' -x '*aclocal*' -Naur alsa-plugins-1.0.17/Makefile.am alsa-plugins-1=
=2E0.17+delay/Makefile.am
=2D-- alsa-plugins-1.0.17/Makefile.am	2008-07-14 10:57:59.000000000 +0200
+++ alsa-plugins-1.0.17+delay/Makefile.am	2008-09-24 16:25:28.000000000 +02=
00
@@ -18,7 +18,7 @@
 PPHDIR =3D pph
 endif
=20
=2DSUBDIRS =3D oss mix $(PPHDIR) $(JACKDIR) $(PULSEDIR) $(SAMPLERATEDIR) $(=
A52DIR) $(LAVCRATEDIR) $(MAEMODIR) doc
+SUBDIRS =3D oss mix delay $(PPHDIR) $(JACKDIR) $(PULSEDIR) $(SAMPLERATEDIR=
) $(A52DIR) $(LAVCRATEDIR) $(MAEMODIR) doc
 EXTRA_DIST =3D gitcompile version COPYING.GPL
 AUTOMAKE_OPTIONS =3D foreign
=20

--Boundary-00=_LFp4IW9NCrZTyOK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_LFp4IW9NCrZTyOK--
