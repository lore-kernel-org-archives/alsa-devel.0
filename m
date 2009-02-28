From: Peter Stokes <linux@dadeos.co.uk>
Subject: [PATCH] Arcam AV Control Plugin Update
Date: Sat, 28 Feb 2009 18:14:21 +0000
Message-ID: <200902281814.21098.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_97XqJVkOgE/TJJz"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.freeserve.com (unknown [193.252.22.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 66C3F243E0
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 19:15:10 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3603.me.freeserve.com (SMTP Server) with ESMTP id CA6197000086
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 19:15:09 +0100 (CET)
Received: from RedDwarf.dadeos.co.uk (unknown [91.109.232.222])
	by mwinf3603.me.freeserve.com (SMTP Server) with ESMTP id 913627000085
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 19:15:09 +0100 (CET)
Received: from tuscan.dadeos.co.uk (Tuscan.dadeos.co.uk [10.0.0.243])
	(authenticated bits=0)
	by RedDwarf.dadeos.co.uk (8.14.3/8.14.2) with ESMTP id n1SIF8FW009873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 18:15:08 GMT
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

--Boundary-00=_97XqJVkOgE/TJJz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

arcam_av: Refactor event callback to facilitate addition of "numid" optimisation

Signed-off-by: Peter Stokes <linux@dadeos.co.uk>


--Boundary-00=_97XqJVkOgE/TJJz
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="arcam_av_read_event_refactor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="arcam_av_read_event_refactor.patch"

diff --git a/arcam-av/arcam_av.h b/arcam-av/arcam_av.h
index 85e9219..5d8624e 100644
--- a/arcam-av/arcam_av.h
+++ b/arcam-av/arcam_av.h
@@ -133,22 +133,28 @@ int arcam_av_send(int fd, arcam_av_cc_t command, unsigned char param1, unsigned
 
 
 typedef struct arcam_av_state {
-	struct {
-		arcam_av_power_t		power;
-		unsigned char			volume;
-		arcam_av_mute_t			mute;
-		arcam_av_direct_t		direct;
-		arcam_av_source_t		source;
-		arcam_av_source_type_t		source_type;
-		arcam_av_stereo_decode_t	stereo_decode;
-		arcam_av_stereo_effect_t	stereo_effect;
-		arcam_av_multi_decode_t		multi_decode;
+	union {
+		struct {
+			unsigned char		power;
+			unsigned char		volume;
+			unsigned char		mute;
+			unsigned char		direct;
+			unsigned char		source;
+			unsigned char		source_type;
+			unsigned char		stereo_decode;
+			unsigned char		stereo_effect;
+			unsigned char		multi_decode;
+		};
+		unsigned char			state[9];
 	} zone1;
-	struct {
-		arcam_av_power_t		power;
-		unsigned char			volume;
-		arcam_av_mute_t			mute;
-		arcam_av_source_t		source;
+	union {
+		struct {
+			unsigned char		power;
+			unsigned char		volume;
+			unsigned char		mute;
+			unsigned char		source;
+		};
+		unsigned char			state[4];
 	} zone2;
 } arcam_av_state_t;
 
diff --git a/arcam-av/ctl_arcam_av.c b/arcam-av/ctl_arcam_av.c
index d571b4f..0ab1460 100644
--- a/arcam-av/ctl_arcam_av.c
+++ b/arcam-av/ctl_arcam_av.c
@@ -816,81 +816,51 @@ static int arcam_av_write_enumerated(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key,
 static int arcam_av_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *id, unsigned int *event_mask)
 {
 	snd_ctl_arcam_av_t *arcam_av = ext->private_data;
+	unsigned int elem;
+	int result = 0;
 
 	switch(arcam_av->zone) {
 	case ARCAM_AV_ZONE1:
-		if (arcam_av->local.zone1.power != arcam_av->global->zone1.power) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[0].name);
-			arcam_av->local.zone1.power = arcam_av->global->zone1.power;
-		} else if (arcam_av->local.zone1.volume != arcam_av->global->zone1.volume) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[1].name);
-			arcam_av->local.zone1.volume = arcam_av->global->zone1.volume;
-		} else if (arcam_av->local.zone1.mute != arcam_av->global->zone1.mute) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[2].name);
-			arcam_av->local.zone1.mute = arcam_av->global->zone1.mute;
-		} else if (arcam_av->local.zone1.direct != arcam_av->global->zone1.direct) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[3].name);
-			arcam_av->local.zone1.direct = arcam_av->global->zone1.direct;
-		} else if (arcam_av->local.zone1.source != arcam_av->global->zone1.source) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[4].name);
-			arcam_av->local.zone1.source = arcam_av->global->zone1.source;
-		} else if (arcam_av->local.zone1.source_type != arcam_av->global->zone1.source_type) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[5].name);
-			arcam_av->local.zone1.source_type = arcam_av->global->zone1.source_type;
-		} else if (arcam_av->local.zone1.stereo_decode != arcam_av->global->zone1.stereo_decode) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[6].name);
-			arcam_av->local.zone1.stereo_decode = arcam_av->global->zone1.stereo_decode;
-		} else if (arcam_av->local.zone1.stereo_effect != arcam_av->global->zone1.stereo_effect) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[7].name);
-			arcam_av->local.zone1.stereo_effect = arcam_av->global->zone1.stereo_effect;
-		} else if (arcam_av->local.zone1.multi_decode != arcam_av->global->zone1.multi_decode) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone1[8].name);
-			arcam_av->local.zone1.multi_decode = arcam_av->global->zone1.multi_decode;
-		} else {
-			char buf[10];
-			if (recv(arcam_av->ext.poll_fd, buf, sizeof(buf), 0) <= 0) {
-				close(arcam_av->ext.poll_fd);
-				arcam_av->ext.poll_fd = arcam_av_client(arcam_av->port);
-				if (arcam_av->ext.poll_fd > 0)
-					fcntl(arcam_av->ext.poll_fd, F_SETFL, O_NONBLOCK);
+		for (elem = 0; elem < ARRAY_SIZE(arcam_av_zone1); ++elem) {
+			if (arcam_av->local.zone1.state[elem] != arcam_av->global->zone1.state[elem]) {
+				snd_ctl_elem_id_set_name(id, arcam_av_zone1[elem].name);
+				snd_ctl_elem_id_set_numid(id, elem + 1);
+				arcam_av->local.zone1.state[elem] = arcam_av->global->zone1.state[elem];
+				result = 1;
+				break;
 			}
-
-			return -EAGAIN;
-		}
+		}		
 		break;
 
 	case ARCAM_AV_ZONE2:
-		if (arcam_av->local.zone2.power != arcam_av->global->zone2.power) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone2[0].name);
-			arcam_av->local.zone2.power = arcam_av->global->zone2.power;
-		} else if (arcam_av->local.zone2.volume != arcam_av->global->zone2.volume) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone2[1].name);
-			arcam_av->local.zone2.volume = arcam_av->global->zone2.volume;
-		} else if (arcam_av->local.zone2.mute != arcam_av->global->zone2.mute) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone2[2].name);
-			arcam_av->local.zone2.mute = arcam_av->global->zone2.mute;
-		} else if (arcam_av->local.zone2.source != arcam_av->global->zone2.source) {
-			snd_ctl_elem_id_set_name(id, arcam_av_zone2[3].name);
-			arcam_av->local.zone2.source = arcam_av->global->zone2.source;
-		} else {
-			char buf[10];
-			if (recv(arcam_av->ext.poll_fd, buf, sizeof(buf), 0) <= 0) {
-				close(arcam_av->ext.poll_fd);
-				arcam_av->ext.poll_fd = arcam_av_client(arcam_av->port);
-				if (arcam_av->ext.poll_fd > 0)
-					fcntl(arcam_av->ext.poll_fd, F_SETFL, O_NONBLOCK);
+		for (elem = 0; elem < ARRAY_SIZE(arcam_av_zone2); ++elem) {
+			if (arcam_av->local.zone2.state[elem] != arcam_av->global->zone2.state[elem]) {
+				snd_ctl_elem_id_set_name(id, arcam_av_zone2[elem].name);
+				snd_ctl_elem_id_set_numid(id, elem + 1);
+				arcam_av->local.zone2.state[elem] = arcam_av->global->zone2.state[elem];
+				result = 1;
+				break;
 			}
-
-			return -EAGAIN;
 		}
 		break;
 	}
 
-	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
+	if (!result) {
+		char buf[10];
+		if (recv(arcam_av->ext.poll_fd, buf, sizeof(buf), 0) <= 0) {
+			close(arcam_av->ext.poll_fd);
+			arcam_av->ext.poll_fd = arcam_av_client(arcam_av->port);
+			if (arcam_av->ext.poll_fd > 0)
+				fcntl(arcam_av->ext.poll_fd, F_SETFL, O_NONBLOCK);
+		}
 
-	*event_mask = SND_CTL_EVENT_MASK_VALUE;
+		result = -EAGAIN;
+	} else {
+		snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
+		*event_mask = SND_CTL_EVENT_MASK_VALUE;
+	}
 
-	return 1;
+	return result;
 }
 
 

--Boundary-00=_97XqJVkOgE/TJJz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_97XqJVkOgE/TJJz--
