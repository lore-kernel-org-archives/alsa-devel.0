From: walt <w41ter@gmail.com>
Subject: [PATCH] Add another VIA audio chip to ac97 quirks list
Date: Thu, 26 Jun 2008 11:01:32 -0700
Message-ID: <g40lge$lfh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AEFD103823
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 20:00:55 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBvmB-00056r-Cf
	for alsa-devel@alsa-project.org; Thu, 26 Jun 2008 18:00:55 +0000
Received: from adsl-69-234-213-244.dsl.irvnca.pacbell.net ([69.234.213.244])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 18:00:55 +0000
Received: from w41ter by adsl-69-234-213-244.dsl.irvnca.pacbell.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 18:00:55 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Author: Walter Sheets <w41ter@gmail.com>
Date:   Thu Jun 26 10:39:19 PDT 2008

     x86: Add VIA audio device #1841 to ac97_quirk list

     Signed-off-by: Walter Sheets <w41ter@gmail.com>

---
Takashi, feel free to modify this in any way you need to.  Thanks.


diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index b585cc3..aa5c2e0 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1746,6 +1746,12 @@ static struct ac97_quirk ac97_quirks[] = {
         },
         {
                 .subvendor = 0x1019,
+               .subdevice = 0x1841,
+               .name = "ECS K7VTA3",
+               .type = AC97_TUNE_HP_ONLY
+       },
+       {
+               .subvendor = 0x1019,
                 .subdevice = 0x0a81,
                 .name = "ECS K7VTA3",
                 .type = AC97_TUNE_HP_ONLY
