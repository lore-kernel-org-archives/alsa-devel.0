From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] iecset fixes
Date: Mon, 03 Nov 2003 08:38:14 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0311030836400.766-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- add error handler for ALSA errors
- enumerate all controls to find the desired control
  (because SPDIF is device 1 on ymfpci)


Index: alsa-utils/iecset/iecset.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/iecset/iecset.c,v
retrieving revision 1.2
diff -u -r1.2 iecset.c
--- alsa-utils/iecset/iecset.c	28 Oct 2003 17:42:28 -0000	1.2
+++ alsa-utils/iecset/iecset.c	3 Nov 2003 07:32:09 -0000
@@ -76,6 +76,12 @@
 };


+static void error(const char *s, int err)
+{
+	fprintf(stderr, "%s: %s\n", s, snd_strerror(err));
+}
+
+
 static void usage(void)
 {
 	int i;
@@ -279,13 +285,16 @@
 int main(int argc, char **argv)
 {
 	const char *dev = "default";
-	const char *spdif_str = "IEC958 Playback Default";
+	const char *spdif_str = SND_CTL_NAME_IEC958("", PLAYBACK, DEFAULT);
 	snd_ctl_t *ctl;
+	snd_ctl_elem_list_t *clist;
+	snd_ctl_elem_id_t *cid;
 	snd_ctl_elem_value_t *cval;
 	snd_aes_iec958_t iec958;
 	int from_stdin = 0;
 	int dumphex = 0;
-	int i, c;
+	int i, c, err;
+	unsigned int controls, cidx;
 	char tmpname[32];
 	int parms[IDX_LAST];

@@ -318,20 +327,42 @@
 		}
 	}

-	if (snd_ctl_open(&ctl, dev, 0) < 0) {
-		perror("snd_ctl_open");
+	if ((err = snd_ctl_open(&ctl, dev, 0)) < 0) {
+		error("snd_ctl_open", err);
 		return 1;
 	}

+	snd_ctl_elem_list_alloca(&clist);
+	if ((err = snd_ctl_elem_list(ctl, clist)) < 0) {
+		error("snd_ctl_elem_list", err);
+		return 1;
+	}
+	if ((err = snd_ctl_elem_list_alloc_space(clist, snd_ctl_elem_list_get_count(clist))) < 0) {
+		error("snd_ctl_elem_list_alloc_space", err);
+		return 1;
+	}
+	if ((err = snd_ctl_elem_list(ctl, clist)) < 0) {
+		error("snd_ctl_elem_list", err);
+		return 1;
+	}
+
+	controls = snd_ctl_elem_list_get_used(clist);
+	for (cidx = 0; cidx < controls; cidx++) {
+		if (!strcmp(snd_ctl_elem_list_get_name(clist, cidx), spdif_str))
+			break;
+	}
+	if (cidx >= controls) {
+		fprintf(stderr, "control \"%s\" not found\n", spdif_str);
+		return 1;
+	}
+
+	snd_ctl_elem_id_alloca(&cid);
+	snd_ctl_elem_list_get_id(clist, cidx, cid);
 	snd_ctl_elem_value_alloca(&cval);
-	snd_ctl_elem_value_set_interface(cval, SND_CTL_ELEM_IFACE_MIXER);
-	snd_ctl_elem_value_set_name(cval, spdif_str);
-	if (snd_ctl_elem_read(ctl, cval) < 0) {
-		snd_ctl_elem_value_set_interface(cval, SND_CTL_ELEM_IFACE_PCM);
-		if (snd_ctl_elem_read(ctl, cval) < 0) {
-			perror("snd_ctl_elem_read");
-			return 1;
-		}
+	snd_ctl_elem_value_set_id(cval, cid);
+	if ((err = snd_ctl_elem_read(ctl, cval)) < 0) {
+		error("snd_ctl_elem_read", err);
+		return 1;
 	}

 	snd_ctl_elem_value_get_iec958(cval, &iec958);
@@ -347,12 +378,12 @@
 	if (update_iec958_status(&iec958, parms)) {
 		/* store the values */
 		snd_ctl_elem_value_set_iec958(cval, &iec958);
-		if (snd_ctl_elem_write(ctl, cval) < 0) {
-			perror("snd_ctl_elem_write");
+		if ((err = snd_ctl_elem_write(ctl, cval)) < 0) {
+			error("snd_ctl_elem_write", err);
 			return 1;
 		}
-		if (snd_ctl_elem_read(ctl, cval) < 0) {
-			perror("snd_ctl_elem_write");
+		if ((err = snd_ctl_elem_read(ctl, cval)) < 0) {
+			error("snd_ctl_elem_write", err);
 			return 1;
 		}
 		snd_ctl_elem_value_get_iec958(cval, &iec958);




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
