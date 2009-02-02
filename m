From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 6/8] ASoC: em-x270: make the driver also support CM-X300 and
	eXeda platforms
Date: Mon,  2 Feb 2009 08:57:56 +0200
Message-ID: <8f36a8b56a2a09286b3d15fc8c13fda1b64ddd3a.1233557530.git.mike@compulab.co.il>
References: <cover.1233557530.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <cover.1233557530.git.mike@compulab.co.il>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: eric.miao@marvell.com
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Mike Rapoport <mike@compulab.co.il>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 sound/soc/pxa/em-x270.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index 949be9c..782b761 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -68,7 +68,8 @@ static int __init em_x270_init(void)
 {
 	int ret;
 
-	if (!machine_is_em_x270())
+	if (!(machine_is_em_x270() || machine_is_exeda()
+	      || machine_is_cm_x300()))
 		return -ENODEV;
 
 	em_x270_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.5.6.4


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
