From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 03/19] ALSA: Oxygen: Add mute mask for the
	OXYGEN_PLAY_ROUTING register
Date: Fri, 24 Jan 2014 16:18:04 +0400
Message-ID: <1390565900-3337-3-git-send-email-v1ron@mail.ru>
References: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Roman Volkov <v1ron@mail.ru>
List-Id: alsa-devel@alsa-project.org

The Xonar DG/DGX driver needs this mask to mute unnecessary
channels.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/oxygen_regs.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/oxygen/oxygen_regs.h b/sound/pci/oxygen/oxygen_regs.h
index 63dc7a0..8c191ba 100644
--- a/sound/pci/oxygen/oxygen_regs.h
+++ b/sound/pci/oxygen/oxygen_regs.h
@@ -318,6 +318,7 @@
 #define  OXYGEN_PLAY_MUTE23		0x0002
 #define  OXYGEN_PLAY_MUTE45		0x0004
 #define  OXYGEN_PLAY_MUTE67		0x0008
+#define  OXYGEN_PLAY_MUTE_MASK		0x000f
 #define  OXYGEN_PLAY_MULTICH_MASK	0x0010
 #define  OXYGEN_PLAY_MULTICH_I2S_DAC	0x0000
 #define  OXYGEN_PLAY_MULTICH_AC97	0x0010
-- 
1.7.10.4
