From: Stas Sergeev <stsp@aknet.ru>
Subject: [patch] Add a software amplifier plugin
Date: Wed, 01 Aug 2007 15:58:56 +0400
Message-ID: <46B07580.6050705@aknet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080806090803060107000202"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (241-226.umostel.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 074CA245A2
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 14:00:06 +0200 (CEST)
Received: from [172.16.14.26]
	by mail.aknet.ru with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <stsp@aknet.ru>) id 1IGCs1-0002pE-3G
	for alsa-devel@alsa-project.org; Wed, 01 Aug 2007 16:00:05 +0400
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

This is a multi-part message in MIME format.
--------------080806090803060107000202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Most of the modern built-in cards do not
have an internal amplifier. This makes it
difficult to use them with those cheap small
passive speakers that were in a heavy use
15 years ago when the cards had an amplifier
builtin.
I wrote a simple software amplifier plugin,
it is attached. Of course you trade a sound
quality, but whoever uses the passive speakers,
have already made his choice anyway.

Would it be possible to apply such a patch to
the repository?

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------080806090803060107000202
Content-Type: text/x-patch;
 name="a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a.diff"

# HG changeset patch
# User Stas Sergeev <stsp@users.sourceforge.net>
# Date 1185966660 -14400
# Node ID 1164919ed31213ef9ae463e3af7a04cdd47fe019
# Parent  dc32d9f00649b5c89589e1dc5eeba6924568bf41
Add a software amplifier plugin.

diff -r dc32d9f00649 -r 1164919ed312 configure.in
--- a/configure.in	Fri Jul 13 12:44:43 2007 +0200
+++ b/configure.in	Wed Aug 01 15:11:00 2007 +0400
@@ -397,7 +397,7 @@ pcm_plugins=""
 pcm_plugins=""
 fi
 
-PCM_PLUGIN_LIST="copy linear route mulaw alaw adpcm rate plug multi shm file null empty share meter hooks lfloat ladspa dmix dshare dsnoop asym iec958 softvol extplug ioplug mmap_emul"
+PCM_PLUGIN_LIST="copy linear route mulaw alaw adpcm rate plug multi shm file null empty share meter hooks lfloat ladspa dmix dshare dsnoop asym iec958 softvol softamp extplug ioplug mmap_emul"
 
 build_pcm_plugin="no"
 for t in $PCM_PLUGIN_LIST; do
@@ -464,6 +464,7 @@ AM_CONDITIONAL(BUILD_PCM_PLUGIN_ASYM, te
 AM_CONDITIONAL(BUILD_PCM_PLUGIN_ASYM, test x$build_pcm_asym = xyes)
 AM_CONDITIONAL(BUILD_PCM_PLUGIN_IEC958, test x$build_pcm_iec958 = xyes)
 AM_CONDITIONAL(BUILD_PCM_PLUGIN_SOFTVOL, test x$build_pcm_softvol = xyes)
+AM_CONDITIONAL(BUILD_PCM_PLUGIN_SOFTAMP, test x$build_pcm_softamp = xyes)
 AM_CONDITIONAL(BUILD_PCM_PLUGIN_EXTPLUG, test x$build_pcm_extplug = xyes)
 AM_CONDITIONAL(BUILD_PCM_PLUGIN_IOPLUG, test x$build_pcm_ioplug = xyes)
 AM_CONDITIONAL(BUILD_PCM_PLUGIN_MMAP_EMUL, test x$build_pcm_mmap_emul = xyes)
diff -r dc32d9f00649 -r 1164919ed312 doc/doxygen.cfg
--- a/doc/doxygen.cfg	Fri Jul 13 12:44:43 2007 +0200
+++ b/doc/doxygen.cfg	Wed Aug 01 15:11:00 2007 +0400
@@ -69,6 +69,7 @@ INPUT            = index.doxygen \
 		   ../src/pcm/pcm_asym.c \
 		   ../src/pcm/pcm_iec958.c \
 		   ../src/pcm/pcm_softvol.c \
+		   ../src/pcm/pcm_softamp.c \
 		   ../src/pcm/pcm_extplug.c \
 		   ../src/pcm/pcm_ioplug.c \
 		   ../src/pcm/pcm_misc.c \
diff -r dc32d9f00649 -r 1164919ed312 include/pcm.h
--- a/include/pcm.h	Fri Jul 13 12:44:43 2007 +0200
+++ b/include/pcm.h	Wed Aug 01 15:11:00 2007 +0400
@@ -358,6 +358,8 @@ enum _snd_pcm_type {
 	SND_PCM_TYPE_IEC958,
 	/** Soft volume plugin */
 	SND_PCM_TYPE_SOFTVOL,
+	/** Soft amp plugin */
+	SND_PCM_TYPE_SOFTAMP,
 	/** External I/O plugin */
 	SND_PCM_TYPE_IOPLUG,
 	/** External filter plugin */
diff -r dc32d9f00649 -r 1164919ed312 src/pcm/Makefile.am
--- a/src/pcm/Makefile.am	Fri Jul 13 12:44:43 2007 +0200
+++ b/src/pcm/Makefile.am	Wed Aug 01 15:11:00 2007 +0400
@@ -93,6 +93,9 @@ if BUILD_PCM_PLUGIN_SOFTVOL
 if BUILD_PCM_PLUGIN_SOFTVOL
 libpcm_la_SOURCES += pcm_softvol.c
 endif
+if BUILD_PCM_PLUGIN_SOFTAMP
+libpcm_la_SOURCES += pcm_softamp.c
+endif
 if BUILD_PCM_PLUGIN_EXTPLUG
 libpcm_la_SOURCES += pcm_extplug.c
 endif
diff -r dc32d9f00649 -r 1164919ed312 src/pcm/pcm.c
--- a/src/pcm/pcm.c	Fri Jul 13 12:44:43 2007 +0200
+++ b/src/pcm/pcm.c	Wed Aug 01 15:11:00 2007 +0400
@@ -1561,7 +1561,8 @@ static const char *snd_pcm_type_names[] 
 	PCMTYPE(JACK),
         PCMTYPE(DSNOOP),
         PCMTYPE(IEC958),
-	PCMTYPE(SOFTVOL),
+        PCMTYPE(SOFTVOL),
+        PCMTYPE(SOFTAMP),
         PCMTYPE(IOPLUG),
         PCMTYPE(EXTPLUG),
 };
@@ -1983,7 +1984,7 @@ static char *build_in_pcms[] = {
 static char *build_in_pcms[] = {
 	"adpcm", "alaw", "copy", "dmix", "file", "hooks", "hw", "ladspa", "lfloat",
 	"linear", "meter", "mulaw", "multi", "null", "empty", "plug", "rate", "route", "share",
-	"shm", "dsnoop", "dshare", "asym", "iec958", "softvol", "mmap_emul",
+	"shm", "dsnoop", "dshare", "asym", "iec958", "softvol", "softamp", "mmap_emul",
 	NULL
 };
 
diff -r dc32d9f00649 -r 1164919ed312 src/pcm/pcm_softamp.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/src/pcm/pcm_softamp.c	Wed Aug 01 15:11:00 2007 +0400
@@ -0,0 +1,625 @@
+/**
+ * \file pcm/pcm_softamp.c
+ * \ingroup PCM_Plugins
+ * \brief PCM software amplification plugin
+ * \author Stas Sergeev <stsp@users.sourceforge.net>
+ * \date 2007
+ */
+/*
+ *  PCM software amplification plugin
+ *  Copyright (c) 2007 Stas Sergeev <stsp@users.sourceforge.net>
+ *  Based on softvol plugin by Takashi Iwai
+ *
+ *
+ *   This library is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU Lesser General Public License as
+ *   published by the Free Software Foundation; either version 2.1 of
+ *   the License, or (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <byteswap.h>
+#include <math.h>
+#include "pcm_local.h"
+#include "pcm_plugin.h"
+
+#ifndef PIC
+/* entry for static linking */
+const char *_snd_module_pcm_softamp = "";
+#endif
+
+#ifndef DOC_HIDDEN
+
+typedef struct {
+	/* This field need to be the first */
+	snd_pcm_plugin_t plug;
+	unsigned int cchannels;
+	snd_ctl_t *ctl;
+	snd_ctl_elem_value_t elem;
+	unsigned int cur_amp[2];
+	unsigned int max_val;     /* max index */
+} snd_pcm_softamp_t;
+
+#endif /* DOC_HIDDEN */
+
+#define AMP_MAX 3
+
+static void softamp_convert(snd_pcm_softamp_t *swamp,
+				       const snd_pcm_channel_area_t *dst_areas,
+				       snd_pcm_uframes_t dst_offset,
+				       const snd_pcm_channel_area_t *src_areas,
+				       snd_pcm_uframes_t src_offset,
+				       unsigned int channels,
+				       snd_pcm_uframes_t frames)
+{
+	const snd_pcm_channel_area_t *dst_area, *src_area;
+	unsigned int src_step, dst_step;
+	unsigned int ch, fr, am;
+	float *src, *dst;
+
+	for (ch = 0; ch < channels; ch++) {
+		src_area = &src_areas[ch];
+		dst_area = &dst_areas[ch];
+		src = snd_pcm_channel_area_addr(src_area, src_offset);
+		dst = snd_pcm_channel_area_addr(dst_area, dst_offset);
+		src_step = snd_pcm_channel_area_step(src_area) / sizeof(float);
+		dst_step = snd_pcm_channel_area_step(dst_area) / sizeof(float);
+		fr = frames;
+		while (fr--) {
+			*dst = *src;
+			for (am = 0; am < swamp->cur_amp[ch & 1]; am++)
+			    *dst = sinf(*dst * M_PI_2);
+			src += src_step;
+			dst += dst_step;
+		}
+	}
+}
+
+/*
+ * get the current value from driver
+ *
+ * TODO: mmap support?
+ */
+static void get_current_volume(snd_pcm_softamp_t *swamp)
+{
+	unsigned int val;
+	unsigned int i;
+
+	if (snd_ctl_elem_read(swamp->ctl, &swamp->elem) < 0)
+		return;
+	for (i = 0; i < swamp->cchannels; i++) {
+		val = swamp->elem.value.integer.value[i];
+		if (val > swamp->max_val)
+			val = swamp->max_val;
+		swamp->cur_amp[i] = val;
+	}
+}
+
+static void softamp_free(snd_pcm_softamp_t *swamp)
+{
+	if (swamp->plug.gen.close_slave)
+		snd_pcm_close(swamp->plug.gen.slave);
+	if (swamp->ctl)
+		snd_ctl_close(swamp->ctl);
+	free(swamp);
+}
+
+static int snd_pcm_softamp_close(snd_pcm_t *pcm)
+{
+	snd_pcm_softamp_t *swamp = pcm->private_data;
+	softamp_free(swamp);
+	return 0;
+}
+
+static int snd_pcm_softamp_hw_refine_cprepare(snd_pcm_t *pcm ATTRIBUTE_UNUSED,
+					      snd_pcm_hw_params_t *params)
+{
+	int err;
+	snd_pcm_access_mask_t access_mask = { SND_PCM_ACCBIT_SHM };
+	snd_pcm_format_mask_t format_mask = { SND_PCM_FMTBIT_FLOAT };
+
+	err = _snd_pcm_hw_param_set_mask(params, SND_PCM_HW_PARAM_ACCESS,
+					 &access_mask);
+	if (err < 0)
+		return err;
+	err = _snd_pcm_hw_param_set_mask(params, SND_PCM_HW_PARAM_FORMAT,
+					 &format_mask);
+	if (err < 0)
+		return err;
+	err = _snd_pcm_hw_params_set_subformat(params, SND_PCM_SUBFORMAT_STD);
+	if (err < 0)
+		return err;
+	err = _snd_pcm_hw_param_set_min(params, SND_PCM_HW_PARAM_CHANNELS, 1, 0);
+	if (err < 0)
+		return err;
+	params->info &= ~(SND_PCM_INFO_MMAP | SND_PCM_INFO_MMAP_VALID);
+	return 0;
+}
+
+static int snd_pcm_softamp_hw_refine_sprepare(snd_pcm_t *pcm ATTRIBUTE_UNUSED,
+		snd_pcm_hw_params_t *sparams)
+{
+	snd_pcm_access_mask_t saccess_mask = { SND_PCM_ACCBIT_MMAP };
+	_snd_pcm_hw_params_any(sparams);
+	_snd_pcm_hw_param_set_mask(sparams, SND_PCM_HW_PARAM_ACCESS,
+				   &saccess_mask);
+	_snd_pcm_hw_params_set_format(sparams, SND_PCM_FORMAT_FLOAT);
+	_snd_pcm_hw_params_set_subformat(sparams, SND_PCM_SUBFORMAT_STD);
+	return 0;
+}
+
+static int snd_pcm_softamp_hw_refine_schange(snd_pcm_t *pcm ATTRIBUTE_UNUSED,
+					     snd_pcm_hw_params_t *params,
+					     snd_pcm_hw_params_t *sparams)
+{
+	int err;
+	unsigned int links = (SND_PCM_HW_PARBIT_CHANNELS |
+			      SND_PCM_HW_PARBIT_RATE |
+			      SND_PCM_HW_PARBIT_PERIODS |
+			      SND_PCM_HW_PARBIT_PERIOD_SIZE |
+			      SND_PCM_HW_PARBIT_PERIOD_TIME |
+			      SND_PCM_HW_PARBIT_BUFFER_SIZE |
+			      SND_PCM_HW_PARBIT_BUFFER_TIME |
+			      SND_PCM_HW_PARBIT_TICK_TIME);
+	err = _snd_pcm_hw_params_refine(sparams, links, params);
+	if (err < 0)
+		return err;
+	return 0;
+}
+	
+static int snd_pcm_softamp_hw_refine_cchange(snd_pcm_t *pcm ATTRIBUTE_UNUSED,
+					     snd_pcm_hw_params_t *params,
+					    snd_pcm_hw_params_t *sparams)
+{
+	int err;
+	unsigned int links = (SND_PCM_HW_PARBIT_CHANNELS |
+			      SND_PCM_HW_PARBIT_RATE |
+			      SND_PCM_HW_PARBIT_PERIODS |
+			      SND_PCM_HW_PARBIT_PERIOD_SIZE |
+			      SND_PCM_HW_PARBIT_PERIOD_TIME |
+			      SND_PCM_HW_PARBIT_BUFFER_SIZE |
+			      SND_PCM_HW_PARBIT_BUFFER_TIME |
+			      SND_PCM_HW_PARBIT_TICK_TIME);
+	err = _snd_pcm_hw_params_refine(params, links, sparams);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static int snd_pcm_softamp_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
+{
+	return snd_pcm_hw_refine_slave(pcm, params,
+				       snd_pcm_softamp_hw_refine_cprepare,
+				       snd_pcm_softamp_hw_refine_cchange,
+				       snd_pcm_softamp_hw_refine_sprepare,
+				       snd_pcm_softamp_hw_refine_schange,
+				       snd_pcm_generic_hw_refine);
+}
+
+static int snd_pcm_softamp_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
+{
+	snd_pcm_softamp_t *swamp = pcm->private_data;
+	snd_pcm_t *slave = swamp->plug.gen.slave;
+	int err = snd_pcm_hw_params_slave(pcm, params,
+					  snd_pcm_softamp_hw_refine_cchange,
+					  snd_pcm_softamp_hw_refine_sprepare,
+					  snd_pcm_softamp_hw_refine_schange,
+					  snd_pcm_generic_hw_params);
+	if (err < 0)
+		return err;
+	if (!snd_pcm_format_float(slave->format)) {
+		SNDERR("softamp supports only FLOAT format");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static snd_pcm_uframes_t
+snd_pcm_softamp_write_areas(snd_pcm_t *pcm,
+			    const snd_pcm_channel_area_t *areas,
+			    snd_pcm_uframes_t offset,
+			    snd_pcm_uframes_t size,
+			    const snd_pcm_channel_area_t *slave_areas,
+			    snd_pcm_uframes_t slave_offset,
+			    snd_pcm_uframes_t *slave_sizep)
+{
+	snd_pcm_softamp_t *swamp = pcm->private_data;
+	if (size > *slave_sizep)
+		size = *slave_sizep;
+	get_current_volume(swamp);
+	softamp_convert(swamp, slave_areas, slave_offset,
+					   areas, offset, pcm->channels, size);
+	*slave_sizep = size;
+	return size;
+}
+
+static snd_pcm_uframes_t
+snd_pcm_softamp_read_areas(snd_pcm_t *pcm,
+			   const snd_pcm_channel_area_t *areas,
+			   snd_pcm_uframes_t offset,
+			   snd_pcm_uframes_t size,
+			   const snd_pcm_channel_area_t *slave_areas,
+			   snd_pcm_uframes_t slave_offset,
+			   snd_pcm_uframes_t *slave_sizep)
+{
+	snd_pcm_softamp_t *swamp = pcm->private_data;
+	if (size > *slave_sizep)
+		size = *slave_sizep;
+	get_current_volume(swamp);
+	softamp_convert(swamp, areas, offset, slave_areas,
+					   slave_offset, pcm->channels, size);
+	*slave_sizep = size;
+	return size;
+}
+
+static void snd_pcm_softamp_dump(snd_pcm_t *pcm, snd_output_t *out)
+{
+	snd_pcm_softamp_t *swamp = pcm->private_data;
+	snd_output_printf(out, "Soft amp PCM\n");
+	snd_output_printf(out, "Control: %s\n", swamp->elem.id.name);
+	snd_output_printf(out, "max_amp: %d\n", swamp->max_val);
+	if (pcm->setup) {
+		snd_output_printf(out, "Its setup is:\n");
+		snd_pcm_dump_setup(pcm, out);
+	}
+	snd_output_printf(out, "Slave: ");
+	snd_pcm_dump(swamp->plug.gen.slave, out);
+}
+
+static int add_tlv_info(snd_pcm_softamp_t *swamp, snd_ctl_elem_info_t *cinfo)
+{
+	unsigned int tlv[4];
+	tlv[0] = SND_CTL_TLVT_DB_SCALE;
+	tlv[1] = 2 * sizeof(int);
+	tlv[2] = 0;
+	tlv[3] = 1;
+	return snd_ctl_elem_tlv_write(swamp->ctl, &cinfo->id, tlv);
+}
+
+static int add_user_ctl(snd_pcm_softamp_t *swamp, snd_ctl_elem_info_t *cinfo, int count)
+{
+	int err;
+	int i;
+	
+	err = snd_ctl_elem_add_integer(swamp->ctl, &cinfo->id, count, 0, swamp->max_val, 0);
+	if (err < 0)
+		return err;
+	add_tlv_info(swamp, cinfo);
+	for (i = 0; i < count; i++)
+		swamp->elem.value.integer.value[i] = 0;
+	return snd_ctl_elem_write(swamp->ctl, &swamp->elem);
+}
+
+/*
+ * load and set up user-control
+ * returns 0 if the user-control is found or created,
+ * returns 1 if the control is a hw control,
+ * or a negative error code
+ */
+static int softamp_load_control(snd_pcm_t *pcm, snd_pcm_softamp_t *swamp,
+				int ctl_card, snd_ctl_elem_id_t *ctl_id,
+				int cchannels, int max_amp)
+{
+	char tmp_name[32];
+	snd_pcm_info_t *info;
+	snd_ctl_elem_info_t *cinfo;
+	int err;
+
+	if (ctl_card < 0) {
+		snd_pcm_info_alloca(&info);
+		err = snd_pcm_info(pcm, info);
+		if (err < 0)
+			return err;
+		ctl_card = snd_pcm_info_get_card(info);
+		if (ctl_card < 0) {
+			SNDERR("No card defined for softamp control");
+			return -EINVAL;
+		}
+	}
+	sprintf(tmp_name, "hw:%d", ctl_card);
+	err = snd_ctl_open(&swamp->ctl, tmp_name, 0);
+	if (err < 0) {
+		SNDERR("Cannot open CTL %s", tmp_name);
+		return err;
+	}
+
+	swamp->elem.id = *ctl_id;
+	swamp->max_val = max_amp;
+		
+	snd_ctl_elem_info_alloca(&cinfo);
+	snd_ctl_elem_info_set_id(cinfo, ctl_id);
+	if ((err = snd_ctl_elem_info(swamp->ctl, cinfo)) < 0) {
+		if (err != -ENOENT) {
+			SNDERR("Cannot get info for CTL %s", tmp_name);
+			return err;
+		}
+		err = add_user_ctl(swamp, cinfo, cchannels);
+		if (err < 0) {
+			SNDERR("Cannot add a control");
+			return err;
+		}
+	} else {
+		if (! (cinfo->access & SNDRV_CTL_ELEM_ACCESS_USER)) {
+			/* hardware control exists */
+			return 1; /* notify */
+
+		} else if (cinfo->type != SND_CTL_ELEM_TYPE_INTEGER ||
+			   cinfo->count != (unsigned int)cchannels ||
+			   cinfo->value.integer.min != 0 ||
+			   cinfo->value.integer.max != swamp->max_val) {
+			if ((err = snd_ctl_elem_remove(swamp->ctl, &cinfo->id)) < 0) {
+				SNDERR("Control %s mismatch", tmp_name);
+				return err;
+			}
+			snd_ctl_elem_info_set_id(cinfo, ctl_id); /* reset numid */
+			if ((err = add_user_ctl(swamp, cinfo, cchannels)) < 0) {
+				SNDERR("Cannot add a control");
+				return err;
+			}
+		} else {
+			/* check TLV availability */
+			unsigned int tlv[4];
+			err = snd_ctl_elem_tlv_read(swamp->ctl, &cinfo->id, tlv, sizeof(tlv));
+			if (err < 0)
+				add_tlv_info(swamp, cinfo);
+		}
+	}
+
+	return 0;
+}
+
+static snd_pcm_ops_t snd_pcm_softamp_ops = {
+	.close = snd_pcm_softamp_close,
+	.info = snd_pcm_generic_info,
+	.hw_refine = snd_pcm_softamp_hw_refine,
+	.hw_params = snd_pcm_softamp_hw_params,
+	.hw_free = snd_pcm_generic_hw_free,
+	.sw_params = snd_pcm_generic_sw_params,
+	.channel_info = snd_pcm_generic_channel_info,
+	.dump = snd_pcm_softamp_dump,
+	.nonblock = snd_pcm_generic_nonblock,
+	.async = snd_pcm_generic_async,
+	.mmap = snd_pcm_generic_mmap,
+	.munmap = snd_pcm_generic_munmap,
+};
+
+/**
+ * \brief Creates a new SoftAmp PCM
+ * \param pcmp Returns created PCM handle
+ * \param name Name of PCM
+ * \param sformat Slave format
+ * \param ctl_card card index of the control
+ * \param ctl_id The control element
+ * \param cchannels PCM channels
+ * \param max_amp maximum amplification level
+ * \param slave Slave PCM handle
+ * \param close_slave When set, the slave PCM handle is closed with copy PCM
+ * \retval zero on success otherwise a negative error code
+ * \warning Using of this function might be dangerous in the sense
+ *          of compatibility reasons. The prototype might be freely
+ *          changed in future.
+ */
+int snd_pcm_softamp_open(snd_pcm_t **pcmp, const char *name,
+			 snd_pcm_format_t sformat,
+			 int ctl_card, snd_ctl_elem_id_t *ctl_id,
+			 int cchannels, int max_amp,
+			 snd_pcm_t *slave, int close_slave)
+{
+	snd_pcm_t *pcm;
+	snd_pcm_softamp_t *swamp;
+	int err;
+	assert(pcmp && slave);
+	swamp = calloc(1, sizeof(*swamp));
+	if (! swamp)
+		return -ENOMEM;
+	err = softamp_load_control(slave, swamp, ctl_card, ctl_id, cchannels,
+					max_amp);
+	if (err < 0) {
+		softamp_free(swamp);
+		return err;
+	}
+	if (err > 0) { /* hardware control - no need for softamp! */
+		softamp_free(swamp);
+		*pcmp = slave; /* just pass the slave */
+		return 0;
+	}
+
+	/* do softamp */
+	snd_pcm_plugin_init(&swamp->plug);
+	swamp->cchannels = cchannels;
+	swamp->plug.read = snd_pcm_softamp_read_areas;
+	swamp->plug.write = snd_pcm_softamp_write_areas;
+	swamp->plug.undo_read = snd_pcm_plugin_undo_read_generic;
+	swamp->plug.undo_write = snd_pcm_plugin_undo_write_generic;
+
+	err = snd_pcm_new(&pcm, SND_PCM_TYPE_SOFTAMP, name, slave->stream, slave->mode);
+	if (err < 0) {
+		softamp_free(swamp);
+		return err;
+	}
+	pcm->ops = &snd_pcm_softamp_ops;
+	pcm->fast_ops = &snd_pcm_plugin_fast_ops;
+	pcm->private_data = swamp;
+	pcm->poll_fd = slave->poll_fd;
+	pcm->poll_events = slave->poll_events;
+	/*
+	 * Since the softamp converts on the place, and the format/channels
+	 * must be identical between source and destination, we don't need
+	 * an extra buffer.
+	 */
+	pcm->mmap_shadow = 1;
+	snd_pcm_set_hw_ptr(pcm, &swamp->plug.hw_ptr, -1, 0);
+	snd_pcm_set_appl_ptr(pcm, &swamp->plug.appl_ptr, -1, 0);
+
+	if (!snd_pcm_format_float(sformat)) {
+#ifdef BUILD_PCM_PLUGIN_LFLOAT
+		snd_pcm_t *pre_cnv;
+		err = snd_pcm_lfloat_open(&pre_cnv, NULL,
+				SND_PCM_FORMAT_FLOAT, pcm, 1);
+		if (err < 0) {
+			snd_pcm_close(pcm);
+			softamp_free(swamp);
+			return err;
+		}
+		err = snd_pcm_lfloat_open(&swamp->plug.gen.slave, NULL,
+				sformat, slave, close_slave);
+		if (err < 0) {
+			snd_pcm_close(pre_cnv);
+			snd_pcm_close(pcm);
+			softamp_free(swamp);
+			return err;
+		}
+		swamp->plug.gen.close_slave = 1;
+		*pcmp = pre_cnv;
+#else
+		SNDERR("lfloat plugin needed for softamp, is not compiled in");
+		return -EINVAL;
+#endif
+	} else {
+		swamp->plug.gen.slave = slave;
+		swamp->plug.gen.close_slave = close_slave;
+		*pcmp = pcm;
+	}
+
+	return 0;
+}
+
+/* in pcm_misc.c */
+int snd_pcm_parse_control_id(snd_config_t *conf, snd_ctl_elem_id_t *ctl_id, int *cardp,
+			     int *cchannelsp, int *hwctlp);
+
+/*! \page pcm_plugins
+
+\section pcm_plugins_softamp Plugin: Soft Volume
+
+This plugin applies the software volume amplification.
+The format, rate and channels must match for both of source and destination.
+
+\code
+pcm.name {
+        type softamp            # Soft Volume conversion PCM
+        slave STR               # Slave name
+        # or
+        slave {                 # Slave definition
+                pcm STR         # Slave PCM name
+                # or
+                pcm { }         # Slave PCM definition
+                format STR      # Slave format
+        }
+        control {
+	        name STR        # control element id string
+		card STR        # control card index
+		[iface STR]     # interface of the element
+		[index INT]     # index of the element
+		[device INT]    # device number of the element
+		[subdevice INT] # subdevice number of the element
+		[count INT]     # control channels 1 or 2 (default: 2)
+	}
+	[max_amp INT]           # maximum amplification (default: 3)
+}
+\endcode
+
+\subsection pcm_plugins_softamp_funcref Function reference
+
+<UL>
+  <LI>snd_pcm_softamp_open()
+  <LI>_snd_pcm_softamp_open()
+</UL>
+
+*/
+
+/**
+ * \brief Creates a new Soft Volume PCM
+ * \param pcmp Returns created PCM handle
+ * \param name Name of PCM
+ * \param root Root configuration node
+ * \param conf Configuration node with Soft Volume PCM description
+ * \param stream Stream type
+ * \param mode Stream mode
+ * \retval zero on success otherwise a negative error code
+ * \warning Using of this function might be dangerous in the sense
+ *          of compatibility reasons. The prototype might be freely
+ *          changed in future.
+ */
+int _snd_pcm_softamp_open(snd_pcm_t **pcmp, const char *name,
+			  snd_config_t *root, snd_config_t *conf, 
+			  snd_pcm_stream_t stream, int mode)
+{
+	snd_config_iterator_t i, next;
+	int err;
+	snd_pcm_t *spcm;
+	snd_config_t *slave = NULL, *sconf;
+	snd_config_t *control = NULL;
+	snd_pcm_format_t sformat;
+	snd_ctl_elem_id_t *ctl_id;
+	int max_amp = AMP_MAX;
+	int card = -1, cchannels = 2;
+
+	snd_config_for_each(i, next, conf) {
+		snd_config_t *n = snd_config_iterator_entry(i);
+		const char *id;
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+		if (snd_pcm_conf_generic_id(id))
+			continue;
+		if (strcmp(id, "slave") == 0) {
+			slave = n;
+			continue;
+		}
+		if (strcmp(id, "control") == 0) {
+			control = n;
+			continue;
+		}
+		if (strcmp(id, "max_amp") == 0) {
+			long v;
+			err = snd_config_get_integer(n, &v);
+			if (err < 0) {
+				SNDERR("Invalid max_amp value");
+				return err;
+			}
+			max_amp = v;
+			continue;
+		}
+		SNDERR("Unknown field %s", id);
+		return -EINVAL;
+	}
+	if (!slave) {
+		SNDERR("slave is not defined");
+		return -EINVAL;
+	}
+	if (!control) {
+		SNDERR("control is not defined");
+		return -EINVAL;
+	}
+	err = snd_pcm_slave_conf(root, slave, &sconf, 1,
+				 SND_PCM_HW_PARAM_FORMAT, SCONF_MANDATORY,
+				 &sformat);
+	if (err < 0)
+		return err;
+	err = snd_pcm_open_slave(&spcm, root, sconf, stream, mode, conf);
+	snd_config_delete(sconf);
+	if (err < 0)
+		return err;
+	snd_ctl_elem_id_alloca(&ctl_id);
+	if ((err = snd_pcm_parse_control_id(control, ctl_id, &card, &cchannels, NULL)) < 0) {
+		snd_pcm_close(spcm);
+		return err;
+	}
+	err = snd_pcm_softamp_open(pcmp, name, sformat, card, ctl_id, cchannels,
+				   max_amp, spcm, 1);
+	if (err < 0)
+		snd_pcm_close(spcm);
+	return err;
+}
+#ifndef DOC_HIDDEN
+SND_DLSYM_BUILD_VERSION(_snd_pcm_softamp_open, SND_PCM_DLSYM_VERSION);
+#endif
diff -r dc32d9f00649 -r 1164919ed312 src/pcm/pcm_symbols.c
--- a/src/pcm/pcm_symbols.c	Fri Jul 13 12:44:43 2007 +0200
+++ b/src/pcm/pcm_symbols.c	Wed Aug 01 15:11:00 2007 +0400
@@ -47,6 +47,7 @@ extern const char *_snd_module_pcm_asym;
 extern const char *_snd_module_pcm_asym;
 extern const char *_snd_module_pcm_iec958;
 extern const char *_snd_module_pcm_softvol;
+extern const char *_snd_module_pcm_softamp;
 extern const char *_snd_module_pcm_extplug;
 extern const char *_snd_module_pcm_ioplug;
 extern const char *_snd_module_pcm_mmap_emul;

--------------080806090803060107000202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080806090803060107000202--
