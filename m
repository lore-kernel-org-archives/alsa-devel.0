From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Couple of ASOC v2 snd-core issues
Date: Tue, 29 Jan 2008 11:18:13 -0500
Message-ID: <9e4733910801290818w2360226cyeedabe37f517b24d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 8090824653
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 17:18:15 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1556867rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 08:18:13 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I had to fix these to get my drivers to load.

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1ead550..4358f74 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1330,7 +1331,7 @@ int snd_soc_codec_add_dai(struct snd_soc_codec *codec,
 		if (dai_runtime == NULL)
 			goto err;
 			
-		dai_runtime->dai = dai;
+		dai_runtime->dai = dai++;
 		dai_runtime->codec = codec;
 		
 		list_add(&dai_runtime->list, &codec->dai_list);
@@ -1382,7 +1383,7 @@ int snd_soc_platform_add_dai(struct
snd_soc_platform *platform,
 		if (dai_runtime == NULL)
 			goto err;
 			
-		dai_runtime->dai = dai;
+		dai_runtime->dai = dai++;
 		dai_runtime->platform = platform;
 		
 		list_add(&dai_runtime->list, &platform->dai_list);
@@ -1479,6 +1480,7 @@ int snd_soc_codec_create(struct snd_soc_machine *machine,
 	codec->dev.parent = machine->dev;
 	codec->dev.release = codec_dev_release;
 	codec->machine = machine;
+	codec->name = (char *)codec_id;
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dai_list);



-- 
Jon Smirl
jonsmirl@gmail.com
