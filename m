From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2] hda_hwdep: Fix possible buffer overflow
Date: Tue,  1 Nov 2011 09:40:07 +0100
Message-ID: <1320136807-4956-1-git-send-email-alexander.stein@systec-electronic.com>
References: <s5hd3djsxcl.wl%tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd3djsxcl.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

If a line in the firmware file is larger than the given buffer size (and
so the firmware file size), size is set to a value larger than the actual
buffer size. This results in an overflow in the buffer passed.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v2:
* Just remove the erroneous check

 sound/pci/hda/hda_hwdep.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 72e5885..7e7d078 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -756,8 +756,6 @@ static int get_line_from_fw(char *buf, int size, struct firmware *fw)
 	}
 	if (!fw->size)
 		return 0;
-	if (size < fw->size)
-		size = fw->size;
 
 	for (len = 0; len < fw->size; len++) {
 		if (!*p)
-- 
1.7.3.4
