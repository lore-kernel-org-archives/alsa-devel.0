From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: usb-audio: Add sample rate quirk for
	Plantronics C310/C520-M
Date: Wed, 20 Sep 2017 09:21:40 +0800
Message-ID: <20170920012140.7861-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B43A266D08
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 03:21:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Like other Plantronics devices, C310 and C520-M do not support sample
rate reading. Add them to the sample rate quirk accordingly.

BugLink: https://bugs.launchpad.net/bugs/1708499
BugLink: https://bugs.launchpad.net/bugs/1709282
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 913552078285..b8cb57aeec77 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1137,6 +1137,8 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x047F, 0x02F7): /* Plantronics BT-600 */
 	case USB_ID(0x047F, 0x0415): /* Plantronics BT-300 */
 	case USB_ID(0x047F, 0xAA05): /* Plantronics DA45 */
+	case USB_ID(0x047F, 0xC022): /* Plantronics C310 */
+	case USB_ID(0x047F, 0xC036): /* Plantronics C520-M */
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
 	case USB_ID(0x0556, 0x0014): /* Phoenix Audio TMX320VC */
 	case USB_ID(0x05A3, 0x9420): /* ELP HD USB Camera */
-- 
2.14.1
