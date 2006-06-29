From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] add codec-specific controls for UCB1400
Date: Thu, 29 Jun 2006 14:37:20 +0200
Message-ID: <44A3C980.7080808@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030003020305020406040307"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030003020305020406040307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds some codec-specific controls for Philips UCB1400 codec.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>

-- 
Sincerely yours,
Mike Rapoport



--------------030003020305020406040307
Content-Type: text/x-diff;
 name="ac97.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97.patch"

 sound/pci/ac97/ac97_codec.c |    2 +-
 sound/pci/ac97/ac97_patch.c |   30 ++++++++++++++++++++++++++++++
 sound/pci/ac97/ac97_patch.h |    1 +
 3 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 3020ca2..ba1dc8a 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -150,7 +150,7 @@ static const struct ac97_codec_id snd_ac
 { 0x4e534300, 0xffffffff, "LM4540,43,45,46,48",	NULL,		NULL }, // only guess --jk
 { 0x4e534331, 0xffffffff, "LM4549",		NULL,		NULL },
 { 0x4e534350, 0xffffffff, "LM4550",		NULL,		NULL },
-{ 0x50534304, 0xffffffff, "UCB1400",		NULL,		NULL },
+{ 0x50534304, 0xffffffff, "UCB1400",		patch_ucb1400,	NULL },
 { 0x53494c20, 0xffffffe0, "Si3036,8",		mpatch_si3036,	mpatch_si3036, AC97_MODEM_PATCH },
 { 0x54524102, 0xffffffff, "TR28022",		NULL,		NULL },
 { 0x54524106, 0xffffffff, "TR28026",		NULL,		NULL },
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index a444a78..0bb1d71 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -2823,3 +2823,33 @@ int mpatch_si3036(struct snd_ac97 * ac97
 	snd_ac97_write_cache(ac97, 0x68, 0);
 	return 0;
 }
+
+/* 
+ *  UCB1400 codec
+ */
+static const struct snd_kcontrol_new snd_ac97_controls_ucb1400[] = {
+AC97_SINGLE("Headphone driver", 0x6a, 6, 1, 0),
+AC97_SINGLE("DC filter", 0x6a, 4, 1, 0),
+AC97_SINGLE("Smart power mode", 0x6c, 4, 3, 0),
+};
+
+static int patch_ucb1400_specific(struct snd_ac97 * ac97)
+{
+	int idx, err;
+	for (idx = 0; idx < ARRAY_SIZE(snd_ac97_controls_ucb1400); idx++)
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ctl_new1(&snd_ac97_controls_ucb1400[idx], ac97))) < 0)
+			return err;
+	return 0;
+}
+
+static struct snd_ac97_build_ops patch_ucb1400_ops = {
+	.build_specific	= patch_ucb1400_specific,
+};
+
+int patch_ucb1400(struct snd_ac97 * ac97)
+{
+	ac97->build_ops = &patch_ucb1400_ops;
+	snd_ac97_write(ac97, 0x6a, 0x0050);
+	snd_ac97_write(ac97, 0x6c, 0x0030);
+	return 0;
+}
diff --git a/sound/pci/ac97/ac97_patch.h b/sound/pci/ac97/ac97_patch.h
index 5060cb6..068b674 100644
--- a/sound/pci/ac97/ac97_patch.h
+++ b/sound/pci/ac97/ac97_patch.h
@@ -58,4 +58,5 @@ int patch_cm9780(struct snd_ac97 * ac97)
 int patch_vt1616(struct snd_ac97 * ac97);
 int patch_vt1617a(struct snd_ac97 * ac97);
 int patch_it2646(struct snd_ac97 * ac97);
+int patch_ucb1400(struct snd_ac97 * ac97);
 int mpatch_si3036(struct snd_ac97 * ac97);

--------------030003020305020406040307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------030003020305020406040307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------030003020305020406040307--
