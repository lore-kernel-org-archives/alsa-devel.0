From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] sound: emu8000: constify emu8000_ops
Date: Mon, 14 Aug 2017 19:13:26 +0200
Message-ID: <1502730806-11637-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

The structure emu8000_ops is only copied into another structure, so
it can be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/isa/sb/emu8000_callback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sb/emu8000_callback.c b/sound/isa/sb/emu8000_callback.c
index d28d712..5a48550 100644
--- a/sound/isa/sb/emu8000_callback.c
+++ b/sound/isa/sb/emu8000_callback.c
@@ -62,7 +62,7 @@ static int load_fx(struct snd_emux *emu, int type, int mode,
 /*
  * set up operators
  */
-static struct snd_emux_operators emu8000_ops = {
+static const struct snd_emux_operators emu8000_ops = {
 	.owner =	THIS_MODULE,
 	.get_voice =	get_voice,
 	.prepare =	start_voice,
