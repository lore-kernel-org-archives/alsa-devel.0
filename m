From: Coywolf Qi Hunt <coywolf@sosdg.org>
Subject: [patch] support HP Compaq Presario B2800 laptop with AD1986A codec
Date: Sun, 9 Apr 2006 10:22:32 -0400
Message-ID: <20060409142232.GA26779@everest.sosdg.org>
Reply-To: qiyong@freeforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, akpm@osdl.org
List-Id: alsa-devel@alsa-project.org


This adds the support for HP Compaq Presario B2800 laptop with AD1986A codec.

Signed-off-by: Coywolf Qi Hunt <qiyong@freeforge.net>
---

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 2bfe37e..921118f 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -801,6 +801,8 @@ static struct hda_board_config ad1986a_c
 	  .config = AD1986A_LAPTOP_EAPD }, /* Samsung R65-T2300 Charis */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1213,
 	  .config = AD1986A_LAPTOP_EAPD }, /* ASUS A6J */
+	{ .pci_subvendor = 0x103c, .pci_subdevice = 0x30af,
+	  .config = AD1986A_LAPTOP_EAPD }, /* HP Compaq Presario B2800 */
 	{}
 };
 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
