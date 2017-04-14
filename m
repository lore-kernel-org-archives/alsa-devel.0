From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: usb-line6: constify snd_kcontrol_new
	strucutre array
Date: Fri, 14 Apr 2017 13:13:50 +0900
Message-ID: <20170414041350.9514-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 8583B266707
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 06:13:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, dev@andree.sk
Cc: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

In kernel APIs of ALSA control interface, drivers can create a control
element set by a call of snd_ctl_new1() with a template. This template
is known to have const qualifier in general cases.

This commit adds the qualifier to template array, for safer program and
runtime. Application of this change moves the symbol from .data section
to .rodata section.

Cc: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/line6/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index fab53f5..b3854f8 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -430,7 +430,7 @@ static int snd_line6_control_playback_put(struct snd_kcontrol *kcontrol,
 }
 
 /* control definition */
-static struct snd_kcontrol_new line6_controls[] = {
+static const struct snd_kcontrol_new line6_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "PCM Playback Volume",
-- 
2.9.3
