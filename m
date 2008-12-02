From: scott@waye.co.uk
Subject: [PATCH - patch_nvhdmi.c 1/1] Added id for MCP67.
	Please note that I'm not really sure what I'm doing but this
	works for me :-)
Date: Tue,  2 Dec 2008 20:35:37 +0000
Message-ID: <1228250137-4780-1-git-send-email-scott@waye.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from giradot.waye.co.uk (mail.waye.co.uk [213.152.36.33])
	by alsa0.perex.cz (Postfix) with SMTP id D6DF81037EB
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 21:35:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, root <scott@waye.co.uk>
List-Id: alsa-devel@alsa-project.org

From: root <scott@waye.co.uk>


Signed-off-by: root <scott@waye.co.uk>

diff --git a/pci/hda/patch_nvhdmi.c b/pci/hda/patch_nvhdmi.c
index 1360d54..b78c8f2 100644
--- a/pci/hda/patch_nvhdmi.c
+++ b/pci/hda/patch_nvhdmi.c
@@ -162,5 +162,6 @@ static int patch_nvhdmi(struct hda_codec *codec)
 struct hda_codec_preset snd_hda_preset_nvhdmi[] = {
 	{ .id = 0x10de0002, .name = "NVIDIA MCP78 HDMI", .patch = patch_nvhdmi },
 	{ .id = 0x10de0007, .name = "NVIDIA MCP7A HDMI", .patch = patch_nvhdmi },
+	{ .id = 0x10de0067, .name = "NVIDIA MCP67 HDMI", .patch = patch_nvhdmi },
 	{} /* terminator */
 };
-- 
1.5.6
