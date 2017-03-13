From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: cs35l35: returning uninitialized in
	probe()
Date: Mon, 13 Mar 2017 15:32:37 +0300
Message-ID: <20170313123237.GA9287@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D44D2669C4
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 13:33:05 +0100 (CET)
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
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

If cs35l35->pdata.stereo is false then "ret" isn't initialized.

Fixes: 6387f866a2cc ("ASoC: Add support for Cirrus Logic CS35L35 Amplifier")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 260ed42c71e9..142ae642eaa1 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -964,7 +964,7 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_cs35l35 = {
