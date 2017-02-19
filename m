From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASLA: emu10k1: constify snd_emux_operators
	structure
Date: Sun, 19 Feb 2017 15:51:30 +0530
Message-ID: <1487499690-32683-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E8C526668C
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 11:21:42 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id c193so2738329pfb.3
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 02:21:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_emux_operators structure as const as it is only copied into
another structure. So, snd_emux_operators structures having this property
can be made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/emu10k1/emu10k1_callback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/emu10k1_callback.c b/sound/pci/emu10k1/emu10k1_callback.c
index d2c7ea3..aa2cc27 100644
--- a/sound/pci/emu10k1/emu10k1_callback.c
+++ b/sound/pci/emu10k1/emu10k1_callback.c
@@ -61,7 +61,7 @@ static struct snd_emux_voice *get_voice(struct snd_emux *emux,
 /*
  * set up operators
  */
-static struct snd_emux_operators emu10k1_ops = {
+static const struct snd_emux_operators emu10k1_ops = {
 	.owner =	THIS_MODULE,
 	.get_voice =	get_voice,
 	.prepare =	start_voice,
-- 
1.9.1
