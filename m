From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: echoaudio: Fix improper return value in
	function load_asic
Date: Tue, 29 Nov 2016 20:00:29 +0100
Message-ID: <20161129190029.31414-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A67B2668DC
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 20:00:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pan Bian <bianpan2016@163.com>
List-Id: alsa-devel@alsa-project.org

From: Pan Bian <bianpan2016@163.com>

When the second call to load_asic_generic() fails in function
load_asic(), "false" is returned. The real value of "false" is 0, which
indicates success in the context. As a result, the execution status and
the return value may be inconsistent. This patch fixes the bug.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188761
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/echoaudio/layla24_dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/echoaudio/layla24_dsp.c b/sound/pci/echoaudio/layla24_dsp.c
index df28e5117359..c02bc1dcc170 100644
--- a/sound/pci/echoaudio/layla24_dsp.c
+++ b/sound/pci/echoaudio/layla24_dsp.c
@@ -135,7 +135,7 @@ static int load_asic(struct echoaudio *chip)
 	err = load_asic_generic(chip, DSP_FNC_LOAD_LAYLA24_EXTERNAL_ASIC,
 				FW_LAYLA24_2S_ASIC);
 	if (err < 0)
-		return false;
+		return err;
 
 	/* Now give the external ASIC a little time to set up */
 	mdelay(10);
-- 
2.10.2
