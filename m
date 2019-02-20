From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda/realtek - Fix a typo in model
	documentation
Date: Wed, 20 Feb 2019 12:57:31 +0100
Message-ID: <20190220115732.16216-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F998F807B8
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:57:37 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3E35DAC90
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 11:57:37 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some garbage was taken via copy-and-paste error.  Clean up.

Fixes: a26d96c7802e ("ALSA: hda/realtek - Comprehensive model list for ALC259 & co")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/models.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index 368a07a165f5..ef6101a78136 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -254,7 +254,7 @@ alc274-dell-aio
     ALC274 fixups on Dell AIO machines
 alc255-dummy-lineout
     Dell Precision 3930 fixups
-alc255-dell-headset"},
+alc255-dell-headset
     Dell Precision 3630 fixups
 alc295-hp-x360
     HP Spectre X360 fixups
-- 
2.16.4
