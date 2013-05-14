From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm_adsp: memory leak in
	wm_adsp_create_control()
Date: Tue, 14 May 2013 15:02:44 +0300
Message-ID: <20130514120244.GA27826@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id CEC50261A0A
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 14:02:56 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

There are two return paths which don't kfree(name).

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1378306..d715c8e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -836,7 +836,8 @@ static int wm_adsp_create_control(struct snd_soc_codec *codec,
 		region_name = "ZM";
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_name;
 	}
 
 	snprintf(name, PAGE_SIZE, "DSP%d %s %x",
@@ -847,7 +848,7 @@ static int wm_adsp_create_control(struct snd_soc_codec *codec,
 		if (!strcmp(ctl->name, name)) {
 			if (!ctl->enabled)
 				ctl->enabled = 1;
-			return 0;
+			goto found;
 		}
 	}
 
@@ -887,6 +888,7 @@ static int wm_adsp_create_control(struct snd_soc_codec *codec,
 	INIT_WORK(&ctl_work->work, wm_adsp_ctl_work);
 	schedule_work(&ctl_work->work);
 
+found:
 	kfree(name);
 
 	return 0;
