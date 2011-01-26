From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - [hdspm] RayDAT/AIO 2/2] ALSA: Add RayDAT and
	AIO strings to Kconfig
Date: Wed, 26 Jan 2011 19:32:15 +0100
Message-ID: <1296066735-11280-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1296066735-11280-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1296066735-11280-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Inform users about the newly added support for RayDAT and AIO.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 9823d59..1fb3e24 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -572,13 +572,13 @@ comment "Don't forget to add built-in firmwares for HDSP driver"
 	depends on SND_HDSP=y
 
 config SND_HDSPM
-	tristate "RME Hammerfall DSP MADI"
+	tristate "RME Hammerfall DSP MADI/RayDAT/AIO"
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
 	help
-	  Say Y here to include support for RME Hammerfall DSP MADI
-	  soundcards.
+	  Say Y here to include support for RME Hammerfall DSP MADI,
+	  RayDAT and AIO soundcards.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-hdspm.
-- 
1.7.2.3
