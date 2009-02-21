From: Peter Stokes <linux@dadeos.co.uk>
Subject: [PATCH 2/2] Arcam AV Control Plugin Updates
Date: Sat, 21 Feb 2009 16:59:55 +0000
Message-ID: <200902211659.55842.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LMDoJ+dgydDLZof"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.freeserve.com (smtp3.wanadoo.co.uk [193.252.22.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A5FE24581
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:22 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3208.me.freeserve.com (SMTP Server) with ESMTP id E002C7000087
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:21 +0100 (CET)
Received: from RedDwarf.dadeos.co.uk (unknown [91.109.223.150])
	by mwinf3208.me.freeserve.com (SMTP Server) with ESMTP id 840757000088
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:21 +0100 (CET)
Received: from tuscan.dadeos.co.uk (Tuscan.dadeos.co.uk [10.0.0.243])
	(authenticated bits=0)
	by RedDwarf.dadeos.co.uk (8.14.3/8.14.2) with ESMTP id n1LHHAJj026983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 17:17:10 GMT
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

--Boundary-00=_LMDoJ+dgydDLZof
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

arcam_av: Refactor control specifications to facilitate addition of "numid" optimisation

Signed-off-by: Peter Stokes <linux@dadeos.co.uk>


--Boundary-00=_LMDoJ+dgydDLZof
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="arcam_av_numid_refactor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="arcam_av_numid_refactor.patch"

diff --git a/arcam-av/ctl_arcam_av.c b/arcam-av/ctl_arcam_av.c
index c6ca87a..d571b4f 100644
--- a/arcam-av/ctl_arcam_av.c
+++ b/arcam-av/ctl_arcam_av.c
@@ -31,16 +31,32 @@
                                  : ((b) > (c) ? (b) : ((a) > (c) ? (c) : (a))))
 
 
-static const char* arcam_av_name		= "Arcam AV";
-static const char* arcam_av_power_name		= "Power Switch";
-static const char* arcam_av_volume_name		= "Master Playback Volume";
-static const char* arcam_av_mute_name		= "Master Playback Switch";
-static const char* arcam_av_direct_name		= "Direct Playback Switch";
-static const char* arcam_av_source_name		= "Source Playback Route";
-static const char* arcam_av_source_type_name	= "Source Type Playback Route";
-static const char* arcam_av_stereo_decode_name	= "Stereo Decode Playback Route";
-static const char* arcam_av_multi_decode_name	= "Multi-Channel Decode Playback Route";
-static const char* arcam_av_stereo_effect_name	= "Stereo Effect Playback Route";
+static const char* arcam_av_name =		"Arcam AV";
+
+static const struct {
+	arcam_av_cc_t			code;
+	const char*			name;
+} arcam_av_zone1[] = {
+	{ARCAM_AV_POWER,			"Power Switch"				},
+	{ARCAM_AV_VOLUME_SET,			"Master Playback Volume"		},
+	{ARCAM_AV_MUTE,				"Master Playback Switch"		},
+	{ARCAM_AV_DIRECT,			"Direct Playback Switch"		},
+	{ARCAM_AV_SOURCE,			"Source Playback Route"			},
+	{ARCAM_AV_SOURCE_TYPE,			"Source Type Playback Route"		},
+	{ARCAM_AV_STEREO_DECODE,		"Stereo Decode Playback Route"		},
+	{ARCAM_AV_MULTI_DECODE,			"Multi-Channel Decode Playback Route"	},
+	{ARCAM_AV_STEREO_EFFECT,		"Stereo Effect Playback Route"		}
+};
+
+static const struct {
+	arcam_av_cc_t			code;
+	const char*			name;
+} arcam_av_zone2[] = {
+	{ARCAM_AV_POWER,			"Power Switch"				},
+	{ARCAM_AV_VOLUME_SET,			"Master Playback Volume"		},
+	{ARCAM_AV_MUTE,				"Master Playback Switch"		},
+	{ARCAM_AV_SOURCE,			"Source Playback Route"			}
+};
 
 static const struct {
 	arcam_av_source_t		code;
@@ -145,7 +161,15 @@ static int arcam_av_elem_count(snd_ctl_ext_t *ext)
 {
 	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
 
-	return arcam_av->zone == ARCAM_AV_ZONE1 ? 9 : 4;
+	switch(arcam_av->zone) {
+	case ARCAM_AV_ZONE1:
+		return ARRAY_SIZE(arcam_av_zone1);
+
+	case ARCAM_AV_ZONE2:
+		return ARRAY_SIZE(arcam_av_zone2);
+	}
+
+	return 0;
 }
 
 static int arcam_av_elem_list(snd_ctl_ext_t *ext, unsigned int offset, snd_ctl_elem_id_t *id)
@@ -153,92 +177,59 @@ static int arcam_av_elem_list(snd_ctl_ext_t *ext, unsigned int offset, snd_ctl_e
 	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
 
 	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
-	
-	if (arcam_av->zone == ARCAM_AV_ZONE1) {
-		switch(offset) {
-		case 0:
-			snd_ctl_elem_id_set_name(id, arcam_av_power_name);
-			break;
-
-		case 1:
-			snd_ctl_elem_id_set_name(id, arcam_av_volume_name);
-			break;
 
-		case 2:
-			snd_ctl_elem_id_set_name(id, arcam_av_mute_name);
-			break;
+	switch(arcam_av->zone) {
+	case ARCAM_AV_ZONE1:
+		if (offset < ARRAY_SIZE(arcam_av_zone1))
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[offset].name);
+		break;
 
-		case 3:
-			snd_ctl_elem_id_set_name(id, arcam_av_direct_name);
-			break;
+	case ARCAM_AV_ZONE2:
+		if (offset < ARRAY_SIZE(arcam_av_zone2))
+			snd_ctl_elem_id_set_name(id, arcam_av_zone2[offset].name);
+		break;
+	}
 
-		case 4:
-			snd_ctl_elem_id_set_name(id, arcam_av_source_name);
-			break;
+	return 0;
+}
 
-		case 5:
-			snd_ctl_elem_id_set_name(id, arcam_av_source_type_name);
-			break;
+static snd_ctl_ext_key_t arcam_av_find_elem(snd_ctl_ext_t *ext,
+					    const snd_ctl_elem_id_t *id)
+{
+	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+	unsigned int numid, search;
+	const char *name;
 
-		case 6:
-			snd_ctl_elem_id_set_name(id, arcam_av_stereo_decode_name);
-			break;
+	numid = snd_ctl_elem_id_get_numid(id);
+	if (numid > 0) {
+		numid--;
 
-		case 7:
-			snd_ctl_elem_id_set_name(id, arcam_av_multi_decode_name);
+		switch(arcam_av->zone) {
+		case ARCAM_AV_ZONE1:
+			if (numid < ARRAY_SIZE(arcam_av_zone1))
+				return arcam_av_zone1[numid].code;
 			break;
 
-		case 8:
-			snd_ctl_elem_id_set_name(id, arcam_av_stereo_effect_name);
+		case ARCAM_AV_ZONE2:
+			if (numid < ARRAY_SIZE(arcam_av_zone2))
+				return arcam_av_zone2[numid].code;
 			break;
 		}
-	} else {
-		switch(offset) {
-		case 0:
-			snd_ctl_elem_id_set_name(id, arcam_av_power_name);
-			break;
-
-		case 1:
-			snd_ctl_elem_id_set_name(id, arcam_av_volume_name);
-			break;
-
-		case 2:
-			snd_ctl_elem_id_set_name(id, arcam_av_mute_name);
-			break;
-
-		case 3:
-			snd_ctl_elem_id_set_name(id, arcam_av_source_name);
-			break;
-		}	
 	}
 
-	return 0;
-}
-
-static snd_ctl_ext_key_t arcam_av_find_elem(snd_ctl_ext_t *ext ATTRIBUTE_UNUSED,
-					    const snd_ctl_elem_id_t *id)
-{
-	const char *name;
-
 	name = snd_ctl_elem_id_get_name(id);
-	if (!strcmp(name, arcam_av_power_name)) {
-		return ARCAM_AV_POWER;
-	} else if (!strcmp(name, arcam_av_volume_name)) {
-		return ARCAM_AV_VOLUME_SET;
-	} else if (!strcmp(name, arcam_av_mute_name)) {
-		return ARCAM_AV_MUTE;
-	} else if (!strcmp(name, arcam_av_direct_name)) {
-		return ARCAM_AV_DIRECT;
-	} else if (!strcmp(name, arcam_av_source_name)) {
-		return ARCAM_AV_SOURCE;
-	} else if (!strcmp(name, arcam_av_source_type_name)) {
-		return ARCAM_AV_SOURCE_TYPE;
-	} else if (!strcmp(name, arcam_av_stereo_decode_name)) {
-		return ARCAM_AV_STEREO_DECODE;
-	} else if (!strcmp(name, arcam_av_multi_decode_name)) {
-		return ARCAM_AV_MULTI_DECODE;
-	} else if (!strcmp(name, arcam_av_stereo_effect_name)) {
-		return ARCAM_AV_STEREO_EFFECT;
+	switch(arcam_av->zone) {
+	case ARCAM_AV_ZONE1:
+		for (search = 0; search < ARRAY_SIZE(arcam_av_zone1); search++)
+			if (!strcmp(name, arcam_av_zone1[search].name))
+				return arcam_av_zone1[search].code;
+		break;
+
+	case ARCAM_AV_ZONE2:
+		for (search = 0; search < ARRAY_SIZE(arcam_av_zone2); search++)
+			if (!strcmp(name, arcam_av_zone2[search].name))
+				return arcam_av_zone2[search].code;
+		break;
 	}
 
 	return SND_CTL_EXT_KEY_NOT_FOUND;
@@ -697,8 +688,7 @@ static int arcam_av_write_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key, lon
 static int arcam_av_write_enumerated(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key, unsigned int *item)
 {
 	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
-
-	char code;
+	unsigned char code;
 
 	switch(key) {
 	case ARCAM_AV_SOURCE:
@@ -830,31 +820,31 @@ static int arcam_av_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *id, unsign
 	switch(arcam_av->zone) {
 	case ARCAM_AV_ZONE1:
 		if (arcam_av->local.zone1.power != arcam_av->global->zone1.power) {
-			snd_ctl_elem_id_set_name(id, arcam_av_power_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[0].name);
 			arcam_av->local.zone1.power = arcam_av->global->zone1.power;
 		} else if (arcam_av->local.zone1.volume != arcam_av->global->zone1.volume) {
-			snd_ctl_elem_id_set_name(id, arcam_av_volume_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[1].name);
 			arcam_av->local.zone1.volume = arcam_av->global->zone1.volume;
 		} else if (arcam_av->local.zone1.mute != arcam_av->global->zone1.mute) {
-			snd_ctl_elem_id_set_name(id, arcam_av_mute_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[2].name);
 			arcam_av->local.zone1.mute = arcam_av->global->zone1.mute;
 		} else if (arcam_av->local.zone1.direct != arcam_av->global->zone1.direct) {
-			snd_ctl_elem_id_set_name(id, arcam_av_direct_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[3].name);
 			arcam_av->local.zone1.direct = arcam_av->global->zone1.direct;
 		} else if (arcam_av->local.zone1.source != arcam_av->global->zone1.source) {
-			snd_ctl_elem_id_set_name(id, arcam_av_source_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[4].name);
 			arcam_av->local.zone1.source = arcam_av->global->zone1.source;
 		} else if (arcam_av->local.zone1.source_type != arcam_av->global->zone1.source_type) {
-			snd_ctl_elem_id_set_name(id, arcam_av_source_type_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[5].name);
 			arcam_av->local.zone1.source_type = arcam_av->global->zone1.source_type;
 		} else if (arcam_av->local.zone1.stereo_decode != arcam_av->global->zone1.stereo_decode) {
-			snd_ctl_elem_id_set_name(id, arcam_av_stereo_decode_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[6].name);
 			arcam_av->local.zone1.stereo_decode = arcam_av->global->zone1.stereo_decode;
 		} else if (arcam_av->local.zone1.stereo_effect != arcam_av->global->zone1.stereo_effect) {
-			snd_ctl_elem_id_set_name(id, arcam_av_stereo_effect_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[7].name);
 			arcam_av->local.zone1.stereo_effect = arcam_av->global->zone1.stereo_effect;
 		} else if (arcam_av->local.zone1.multi_decode != arcam_av->global->zone1.multi_decode) {
-			snd_ctl_elem_id_set_name(id, arcam_av_multi_decode_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone1[8].name);
 			arcam_av->local.zone1.multi_decode = arcam_av->global->zone1.multi_decode;
 		} else {
 			char buf[10];
@@ -871,16 +861,16 @@ static int arcam_av_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *id, unsign
 
 	case ARCAM_AV_ZONE2:
 		if (arcam_av->local.zone2.power != arcam_av->global->zone2.power) {
-			snd_ctl_elem_id_set_name(id, arcam_av_power_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone2[0].name);
 			arcam_av->local.zone2.power = arcam_av->global->zone2.power;
 		} else if (arcam_av->local.zone2.volume != arcam_av->global->zone2.volume) {
-			snd_ctl_elem_id_set_name(id, arcam_av_volume_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone2[1].name);
 			arcam_av->local.zone2.volume = arcam_av->global->zone2.volume;
 		} else if (arcam_av->local.zone2.mute != arcam_av->global->zone2.mute) {
-			snd_ctl_elem_id_set_name(id, arcam_av_mute_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone2[2].name);
 			arcam_av->local.zone2.mute = arcam_av->global->zone2.mute;
 		} else if (arcam_av->local.zone2.source != arcam_av->global->zone2.source) {
-			snd_ctl_elem_id_set_name(id, arcam_av_source_name);
+			snd_ctl_elem_id_set_name(id, arcam_av_zone2[3].name);
 			arcam_av->local.zone2.source = arcam_av->global->zone2.source;
 		} else {
 			char buf[10];
@@ -934,7 +924,7 @@ SND_CTL_PLUGIN_DEFINE_FUNC(arcam_av)
 		const char *id;
 		if (snd_config_get_id(n, &id) < 0)
 			continue;
-		if (strcmp(id, "comment") == 0 || strcmp(id, "type") == 0)
+		if (strcmp(id, "comment") == 0 || strcmp(id, "type") == 0 || strcmp(id, "hint") == 0)
 			continue;
 		if (strcmp(id, "port") == 0) {
 			if (snd_config_get_string(n, &port) < 0) {
@@ -978,7 +968,7 @@ SND_CTL_PLUGIN_DEFINE_FUNC(arcam_av)
 	arcam_av->ext.callback = &arcam_av_ext_callback;
 	arcam_av->ext.private_data = arcam_av;
 
-	arcam_av->shm_id= -1;
+	arcam_av->shm_id = -1;
 	arcam_av->port_fd = -1;
 	arcam_av->port = strcpy((char*)(arcam_av + 1), port);
 	arcam_av->zone = zone != 2 ? ARCAM_AV_ZONE1 : ARCAM_AV_ZONE2;

--Boundary-00=_LMDoJ+dgydDLZof
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_LMDoJ+dgydDLZof--
