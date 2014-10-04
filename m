From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/14] ALSA: dice: remove experimental state
Date: Sat,  4 Oct 2014 20:27:24 +0900
Message-ID: <1412422044-15133-15-git-send-email-o-takashi@sakamocchi.jp>
References: <1412422044-15133-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB9D26057F
 for <alsa-devel@alsa-project.org>; Sat,  4 Oct 2014 13:27:50 +0200 (CEST)
In-Reply-To: <1412422044-15133-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some developers test this driver, thus it's better to remove its
experimental state.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index c8e704c..1ea249d 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -13,12 +13,12 @@ config SND_FIREWIRE_LIB
 	select SND_RAWMIDI
 
 config SND_DICE
-	tristate "DICE-based DACs (EXPERIMENTAL)"
+	tristate "DICE-based DACs support"
 	select SND_HWDEP
 	select SND_FIREWIRE_LIB
 	help
 	  Say Y here to include support for many DACs based on the DICE
-	  chip family (DICE-II/Jr/Mini) from TC Applied Technologies.
+	  chip family (DICE-II/Jr/Mini) from TC Applied Technologies:
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-dice.
-- 
1.9.1
