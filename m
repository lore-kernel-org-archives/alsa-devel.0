From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: hdac_hdmi: Dereference 'edev' after
	checking for NULL
Date: Wed, 17 Feb 2016 07:09:59 -0200
Message-ID: <1455700199-18691-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com
 [209.85.161.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BE62265FB4
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 10:10:16 +0100 (CET)
Received: by mail-yw0-f172.google.com with SMTP id g127so8224956ywf.2
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 01:10:15 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, jeeja.kp@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 4a3478debf36 ("ASoC: hdac_hdmi: Add jack reporting") 
leads to the following Smatch complaint:

sound/soc/codecs/hdac_hdmi.c:971 hdac_hdmi_present_sense()
         warn: variable dereferenced before check 'edev' (see line 967)

,so deference 'edev' after checking for NULL.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/hdac_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 36f1200..920af2f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -964,13 +964,15 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
 static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 {
 	struct hdac_ext_device *edev = pin->edev;
-	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_priv *hdmi;
 	struct hdac_hdmi_pcm *pcm;
 	int val;
 
 	if (!edev)
 		return;
 
+	hdmi = edev->private_data;
+
 	pin->repoll_count = repoll;
 
 	pm_runtime_get_sync(&edev->hdac.dev);
-- 
1.9.1
