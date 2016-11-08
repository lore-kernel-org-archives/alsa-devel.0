From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 4/4 ] iecset: allow to select control with device
	and sub-device numbers.
Date: Tue, 8 Nov 2016 09:11:15 +0100
Message-ID: <1478592675-23092-5-git-send-email-arnaud.pouliquen@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C3933266EFD
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 09:13:13 +0100 (CET)
In-Reply-To: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

ASoc implementation force the index to 0.
In case of multi devices that export the iec control, we need device and
subdevice fields to differentiate and address the different controls.
This patch extends "-D" option to be able to address control using
PCM device/sub-device id.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 iecset/iecset.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/iecset/iecset.c b/iecset/iecset.c
index 92a93e8..8d7a800 100644
--- a/iecset/iecset.c
+++ b/iecset/iecset.c
@@ -89,6 +89,8 @@ static void usage(void)
 	printf("Usage: iecset [options] [cmd arg...]\n");
 	printf("Options:\n");
 	printf("    -D device   specifies the control device to use\n");
+	printf("                for \"-Dhw:X,Y,Z\" Only control device X is mandatory\n");
+	printf("                the device(Y) and subdevice(Z) are optinal (default = 0)\n");
 	printf("    -c card     specifies the card number to use (equiv. with -Dhw:#)\n");
 	printf("    -n number   specifies the control index number (default = 0)\n");
 	printf("    -x          dump the dump the AESx hex code for IEC958 PCM parameters\n");
@@ -99,6 +101,15 @@ static void usage(void)
 	}
 }
 
+static int parse_device(char *parms, int *ctl_dev, int *dev, int *sdev)
+{
+
+	if (strncmp(parms, "hw", 2))
+		return 1;
+	sscanf(parms,"hw:%d,%d,%d",ctl_dev, dev, sdev);
+
+	return 0;
+}
 
 /*
  * parse iecset commands
@@ -312,6 +323,7 @@ int main(int argc, char **argv)
 	const char *dev = "default";
 	const char *spdif_str = SND_CTL_NAME_IEC958("", PLAYBACK, DEFAULT);
 	int spdif_index = -1;
+	int cdev, spdif_dev = -1, spdif_sdev = -1;
 	snd_ctl_t *ctl;
 	snd_ctl_elem_list_t *clist;
 	snd_ctl_elem_id_t *cid;
@@ -330,7 +342,11 @@ int main(int argc, char **argv)
 	while ((c = getopt(argc, argv, "D:c:n:xhi")) != -1) {
 		switch (c) {
 		case 'D':
-			dev = optarg;
+			if (parse_device(optarg, &cdev, &spdif_dev, &spdif_sdev))
+				dev = optarg;
+			else
+				sprintf(tmpname, "hw:%d", cdev);
+				dev = tmpname;
 			break;
 		case 'c':
 			i = atoi(optarg);
@@ -376,15 +392,19 @@ int main(int argc, char **argv)
 	}
 
 	controls = snd_ctl_elem_list_get_used(clist);
-	for (cidx = 0; cidx < controls; cidx++) {
-		if (!strcmp(snd_ctl_elem_list_get_name(clist, cidx), spdif_str))
-			if (spdif_index < 0 ||
-			    snd_ctl_elem_list_get_index(clist, cidx) == spdif_index)
+	for (cidx = 0; cidx < controls; cidx++)
+		if (!strcmp(snd_ctl_elem_list_get_name(clist, cidx), spdif_str)) {
+			if ((spdif_index < 0 ||
+			     snd_ctl_elem_list_get_index(clist, cidx) == spdif_index) &&
+			    (spdif_dev < 0 ||
+			     snd_ctl_elem_list_get_device(clist, cidx) == spdif_dev) &&
+			    (spdif_sdev < 0 ||
+			     snd_ctl_elem_list_get_subdevice(clist, cidx) == spdif_sdev))
 				break;
 	}
 	if (cidx >= controls) {
-		fprintf(stderr, "control \"%s\" (index %d) not found\n",
-			spdif_str, spdif_index);
+		fprintf(stderr, "control \"%s\" (index %d, device %d, subdevice %d) not found\n",
+			spdif_str, spdif_index, spdif_dev, spdif_sdev);
 		return 1;
 	}
 
-- 
1.9.1
