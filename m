From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Fix num_adc_nids assignment for eeepc p701 config
	preset
Date: Sat, 23 Feb 2008 01:31:06 -0300
Message-ID: <200802230131.06597.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id BCED8103843
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 05:31:09 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 457B03AA05
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 01:31:07 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id A2OoEUK+Q3Wi for <alsa-devel@alsa-project.org>;
	Sat, 23 Feb 2008 01:31:07 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id EB7373A9CA
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 01:31:06 -0300 (BRT)
Received: from [172.21.225.14] (unknown [172.21.225.14])
	by fox.conectiva (Postfix) with ESMTP id DD8652F599
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 01:31:06 -0300 (BRT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix num_adc_nids assignment for eeepc p701 config preset.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 586d98f..6f7dd96 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -13388,7 +13388,7 @@ static struct alc_config_preset alc662_presets[] = {
 				alc662_eeepc_sue_init_verbs },
 		.num_dacs = ARRAY_SIZE(alc662_dac_nids),
 		.dac_nids = alc662_dac_nids,
-		.num_adc_nids = ARRAY_SIZE(alc861vd_adc_nids),
+		.num_adc_nids = ARRAY_SIZE(alc662_adc_nids),
 		.adc_nids = alc662_adc_nids,
 		.num_channel_mode = ARRAY_SIZE(alc662_3ST_2ch_modes),
 		.channel_mode = alc662_3ST_2ch_modes,

--
[]'s
Herton
