From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix setting update bits for
 WM8741_DACRMSB_ATTENUATION
Date: Mon, 03 Oct 2011 11:09:01 +0800
Message-ID: <1317611341.5065.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EF2310381C
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 05:09:14 +0200 (CEST)
Received: by ywn1 with SMTP id 1so3493746ywn.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 20:09:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

After checking the code and datasheet, I think what we want in the second
snd_soc_update_bits call is to update WM8741_DACRMSB_ATTENUATION register
instead of WM8741_DACRLSB_ATTENUATION.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I don't have this hardware handy, thus I only check the the code and datasheet.
The bug is there since commit 992bee40 "ASoC: Initial WM8741 CODEC driver".
I'd appreciate if someone can test this patch.

Regards,
Axel
 sound/soc/codecs/wm8741.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 78c9e5a..a42b282 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -462,7 +462,7 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 			    WM8741_UPDATELM, WM8741_UPDATELM);
 	snd_soc_update_bits(codec, WM8741_DACRLSB_ATTENUATION,
 			    WM8741_UPDATERL, WM8741_UPDATERL);
-	snd_soc_update_bits(codec, WM8741_DACRLSB_ATTENUATION,
+	snd_soc_update_bits(codec, WM8741_DACRMSB_ATTENUATION,
 			    WM8741_UPDATERM, WM8741_UPDATERM);
 
 	snd_soc_add_controls(codec, wm8741_snd_controls,
-- 
1.7.4.1
