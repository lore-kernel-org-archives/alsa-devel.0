From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: fix regression to handle Stanton
	SCS.1m/1d
Date: Mon,  3 Apr 2017 21:13:40 +0900
Message-ID: <20170403121340.19521-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 4E16C2669D7
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 14:13:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, "# 4 . 7+" <stable@vger.kernel.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

At a commit 6c29230e2a5f ("ALSA: oxfw: delayed registration of sound
card"), ALSA oxfw driver fails to handle SCS.1m/1d, due to -EBUSY at a call
of snd_card_register(). The cause is that the driver manages to register
two rawmidi instances with the same device number 0. This is a regression
introduced since kernel 4.7.

This commit fixes the regression, by fixing up device property after
discovering stream formats.

Fixes: 6c29230e2a5f ("ALSA: oxfw: delayed registration of sound card")
Cc: <stable@vger.kernel.org> # 4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 74d7fb6..413ab63 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -227,11 +227,11 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
-	err = detect_quirks(oxfw);
+	err = snd_oxfw_stream_discover(oxfw);
 	if (err < 0)
 		goto error;
 
-	err = snd_oxfw_stream_discover(oxfw);
+	err = detect_quirks(oxfw);
 	if (err < 0)
 		goto error;
 
-- 
2.9.3
