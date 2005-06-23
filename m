From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] 1/3 miro: add firmware 0x07 which is pcm20 revE
Date: Fri, 24 Jun 2005 01:01:56 +0200
Message-ID: <20050623230156.GA3281@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 777D021E
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 00:59:33 +0200 (MEST)
Received: from ml by tuba with local (Exim 4.50)
	id 1Dlaho-0000rp-Pr
	for alsa-devel@alsa-project.org; Fri, 24 Jun 2005 01:01:56 +0200
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


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The patch adds firmware version 0x07 to the list of PCM20 firmwares.
That 0x07 card is marked as revision E, which can be identified now.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="miro_pcm20revE.patch"

--- alsa-driver/isa/opti9xx/miro.c.ORIGINAL	Thu Jun 23 21:51:34 2005
+++ alsa-driver/isa/opti9xx/miro.c	Thu Jun 23 21:53:35 2005
@@ -835,8 +835,16 @@
 
 	if ((miro->hardware == OPTi9XX_HW_82C924) &&
 	    (miro->aci_vendor == 'm') && 
-	    (miro->aci_product == 'C')) 
-		model = "miroSOUND PCM20 radio";
+	    (miro->aci_product == 'C')) {
+		switch(miro->aci_version) {
+		case 7:
+			model = "miroSOUND PCM20 radio (Rev. E)";
+			break;
+		default:
+			model = "miroSOUND PCM20 radio";
+			break;
+		}
+	}
 
 	snd_iprintf(buffer, "\nGeneral information:\n");
 	snd_iprintf(buffer, "  model   : %s\n", model);

--sdtB3X0nJg68CQEu--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
