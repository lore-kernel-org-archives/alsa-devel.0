From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda/realtek - Add model description
	for Chrome headset button quirk
Date: Wed, 20 Feb 2019 12:57:32 +0100
Message-ID: <20190220115732.16216-2-tiwai@suse.de>
References: <20190220115732.16216-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 750E3F80C31
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:57:38 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 44339AC96
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 11:57:38 +0000 (UTC)
In-Reply-To: <20190220115732.16216-1-tiwai@suse.de>
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

Forgot to update the document.

Fixes: e854747d7593 ("ALSA: hda/realtek - Enable headset button support for new codec")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/models.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index ef6101a78136..7d7c191102a7 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -258,6 +258,8 @@ alc255-dell-headset
     Dell Precision 3630 fixups
 alc295-hp-x360
     HP Spectre X360 fixups
+alc-sense-combo
+    Headset button support for Chrome platform
 
 ALC66x/67x/892
 ==============
-- 
2.16.4
