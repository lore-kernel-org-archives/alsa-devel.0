From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3] ASoC: hdac_hdmi: check error return
Date: Tue,  1 Dec 2015 14:29:35 +0530
Message-ID: <1448960375-9710-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ED122659E2
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 09:59:45 +0100 (CET)
Received: by pacej9 with SMTP id ej9so215549527pac.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Dec 2015 00:59:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

As hdac->num_nodes is unsigned we can not check if
snd_hdac_get_sub_nodes() has returned error or success. Lets have a
temporary int to check the error value.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v2: made num_nodes as int, but Takashi said that num_nodes should really
be an unsigned.
v1: removed the error check as that condition is always false.

 sound/soc/codecs/hdac_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 205f2c2..1a2f33b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -409,17 +409,18 @@ static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev,
 static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 {
 	hda_nid_t nid;
-	int i;
+	int i, num_nodes;
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	int cvt_nid = 0, pin_nid = 0;
 
-	hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
-	if (!nid || hdac->num_nodes < 0) {
+	num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
+	if (!nid || num_nodes < 0) {
 		dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
 		return -EINVAL;
 	}
 
+	hdac->num_nodes = num_nodes;
 	hdac->start_nid = nid;
 
 	for (i = 0; i < hdac->num_nodes; i++, nid++) {
-- 
1.9.1
