From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 3/5] namehint: Fix bad free with invalid
	iface name
Date: Thu, 30 Apr 2015 15:06:16 +0200
Message-ID: <1430399178-15173-4-git-send-email-tiwai@suse.de>
References: <1430399178-15173-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F3A032615F7
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 15:06:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 38BA7AC35
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:06:19 +0000 (UTC)
In-Reply-To: <1430399178-15173-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Due to the uninitialized field before the error path, passing an
invalid iface argument may result in a bad free() call.  Initialize
the fields properly beforehand.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/control/namehint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 6c04143a185c..b3e646eb10af 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -562,6 +562,8 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 	list.list = NULL;
 	list.count = list.allocated = 0;
 	list.siface = iface;
+	list.show_all = 0;
+	list.cardname = NULL;
 	if (strcmp(iface, "card") == 0)
 		list.iface = SND_CTL_ELEM_IFACE_CARD;
 	else if (strcmp(iface, "pcm") == 0)
@@ -581,8 +583,6 @@ int snd_device_name_hint(int card, const char *iface, void ***hints)
 		goto __error;
 	}
 
-	list.show_all = 0;
-	list.cardname = NULL;
 	if (snd_config_search(local_config, "defaults.namehint.showall", &conf) >= 0)
 		list.show_all = snd_config_get_bool(conf) > 0;
 	if (card >= 0) {
-- 
2.3.6
