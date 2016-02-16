From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Tue, 16 Feb 2016 17:44:15 +0100
Message-ID: <1455641066-4014858-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id F342E26068F
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 17:44:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

When CONFIG_SND_JACK is disabled, the hdmi driver tries to create
a new output jack structure and dereferences it even though
the pointer is never assigned:

sound/pci/hda/patch_hdmi.c: In function 'generic_hdmi_build_jack':
sound/pci/hda/patch_hdmi.c:2534:30: error: 'jack' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/pci/hda/patch_hdmi.c:2526:19: note: 'jack' was declared here

This makes snd_jack_new() return an error when SND_JACK is disabled,
forcing all users to handle errors gracefully and avoiding the
problem in all callers that correctly check the return code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 788d441a164c ("ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling")
---
 include/sound/jack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 23bede121c78..1e84a2e413f8 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -99,7 +99,7 @@ void snd_jack_report(struct snd_jack *jack, int status);
 static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
 			       struct snd_jack **jack, bool initial_kctl, bool phantom_jack)
 {
-	return 0;
+	return -ENXIO;
 }
 
 static inline int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask)
-- 
2.7.0
