From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-motu: add missing entries to
	Kconfig
Date: Fri, 12 Oct 2018 16:08:59 +0900
Message-ID: <20181012070859.16630-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D79B926778D
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 09:09:08 +0200 (CEST)
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so5712478pfj.7
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 00:09:08 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MOTU Traveler and Audio Express are supported as well.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 529d9f405fa9..8a146b039276 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -147,7 +147,9 @@ config SND_FIREWIRE_MOTU
 	help
 	 Say Y here to enable support for FireWire devices which MOTU produced:
 	  * 828mk2
+	  * Traveler
 	  * 828mk3
+	  * Audio Express
 
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-motu.
-- 
2.19.1
