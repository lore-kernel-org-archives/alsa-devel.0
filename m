From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] miro: OPL4 support
Date: Fri, 24 Jun 2005 22:50:41 +0200
Message-ID: <20050624205040.GA3115@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 47C47222
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 22:48:11 +0200 (MEST)
Received: from ml by tuba with local (Exim 4.50)
	id 1Dlv8L-0000ok-51
	for alsa-devel@alsa-project.org; Fri, 24 Jun 2005 22:50:41 +0200
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OPL4 support on miroSOUND PCMxx is working now. This patch makes it 
possible. Miro soundcards with OPL3 don't exist and so there's no OPL3 
fallback.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

Enjoy it!
martin

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="miro_opl4.patch"

Index: isa/opti9xx/miro.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/opti9xx/miro.c,v
retrieving revision 1.5
diff -u -r1.5 miro.c
--- isa/opti9xx/miro.c	24 Jun 2005 07:07:06 -0000	1.5
+++ isa/opti9xx/miro.c	24 Jun 2005 19:58:42 -0000
@@ -983,14 +983,14 @@
 	case OPTi9XX_HW_82C924:
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(6), 0x02, 0x02);
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(1), 0x80, 0x80);
-		snd_miro_write_mask(chip, OPTi9XX_MC_REG(2), 0x00, 0x20);
+		snd_miro_write_mask(chip, OPTi9XX_MC_REG(2), 0x20, 0x20); /* OPL4 */
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(5), 0x02, 0x02);
 		break;
 	case OPTi9XX_HW_82C929:
 		/* untested init commands for OPTi929 */
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(1), 0x80, 0x80);
-		snd_miro_write_mask(chip, OPTi9XX_MC_REG(2), 0x00, 0x20);
+		snd_miro_write_mask(chip, OPTi9XX_MC_REG(2), 0x20, 0x20); /* OPL4 */
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(4), 0x00, 0x0c);
 		snd_miro_write_mask(chip, OPTi9XX_MC_REG(5), 0x02, 0x02);
 		break;
@@ -1394,6 +1394,14 @@
 				&rmidi)))
 			snd_printk("no MPU-401 device at 0x%lx?\n", miro->mpu_port);
 
+	if (miro->fm_port > 0 && miro->fm_port != SNDRV_AUTO_PORT) {
+		opl3_t *opl3 = NULL;
+		opl4_t *opl4;
+		if (snd_opl4_create(card, miro->fm_port, miro->fm_port - 8, 
+				    2, &opl3, &opl4) < 0)
+			snd_printk("no OPL4 device at 0x%lx\n", miro->fm_port);
+	}
+
 	if ((error = snd_set_aci_init_values(miro)) < 0) {
 		snd_card_free(card);
                 return error;

--pWyiEgJYm5f9v55/--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
