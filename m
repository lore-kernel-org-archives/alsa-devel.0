From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] more proc lines for miro
Date: Sat, 26 Mar 2005 21:58:32 +0100
Message-ID: <20050326205832.GA5473@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Summary: the patch adds more helpful proc lines to the miro driver
Signed-off-by: Martin Langer <martin-langer@gmx.de>


bye,
martin

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="miroproc.patch"

--- isa/opti9xx/miro.c.ORIGINAL	Sat Mar 26 19:01:09 2005
+++ isa/opti9xx/miro.c	Sat Mar 26 21:28:32 2005
@@ -796,8 +796,7 @@
 			       snd_info_buffer_t * buffer)
 {
 	miro_t *miro = (miro_t *) entry->private_data;
-
-	snd_iprintf(buffer, "\n");
+	char* model = "unknown";
 
 	/* miroSOUND PCM1 pro, early PCM12 */
 
@@ -806,10 +805,10 @@
 	    (miro->aci_product == 'A')) {
 		switch(miro->aci_version) {
 		case 3:
-			snd_iprintf(buffer, "miroSOUND PCM1 pro\n\n");
+			model = "miroSOUND PCM1 pro";
 			break;
 		default:
-			snd_iprintf(buffer, "miroSOUND PCM1 pro / (early) PCM12\n\n");
+			model = "miroSOUND PCM1 pro / (early) PCM12";
 			break;
 		}
 	}
@@ -821,13 +820,13 @@
 	    (miro->aci_product == 'B')) {
 		switch(miro->aci_version) {
 		case 4:
-			snd_iprintf(buffer, "miroSOUND PCM12\n\n");
+			model = "miroSOUND PCM12";
 			break;
 		case 176:
-			snd_iprintf(buffer, "miroSOUND PCM12 (Rev. E)\n\n");
+			model = "miroSOUND PCM12 (Rev. E)";
 			break;
 		default:
-			snd_iprintf(buffer, "miroSOUND PCM12 / PCM12 pnp\n\n");
+			model = "miroSOUND PCM12 / PCM12 pnp";
 			break;
 		}
 	}
@@ -837,7 +836,19 @@
 	if ((miro->hardware == OPTi9XX_HW_82C924) &&
 	    (miro->aci_vendor == 'm') && 
 	    (miro->aci_product == 'C')) 
-		snd_iprintf(buffer, "miroSOUND PCM20 radio\n\n");
+		model = "miroSOUND PCM20 radio";
+
+	snd_iprintf(buffer, "\nGeneral information:\n");
+	snd_iprintf(buffer, "  model   : %s\n", model);
+	snd_iprintf(buffer, "  opti    : %s\n", miro->name);
+	snd_iprintf(buffer, "  codec   : %s\n", miro->pcm->name);
+	snd_iprintf(buffer, "  port    : 0x%lx\n", miro->wss_base);
+	snd_iprintf(buffer, "  irq     : %d\n", miro->irq);
+	snd_iprintf(buffer, "  dma     : %d,%d\n\n", miro->dma1, miro->dma2);
+
+	snd_iprintf(buffer, "MPU-401:\n");
+	snd_iprintf(buffer, "  port    : 0x%lx\n", miro->mpu_port);
+	snd_iprintf(buffer, "  irq     : %d\n\n", miro->mpu_irq);
 
 	snd_iprintf(buffer, "ACI information:\n");
 	snd_iprintf(buffer, "  vendor  : ");
@@ -868,9 +879,13 @@
 
 	snd_iprintf(buffer, "  firmware: %d (0x%x)\n",
 		    miro->aci_version, miro->aci_version);
-	snd_iprintf(buffer, "  port    : 0x%lx-0x%lx\n\n", 
+	snd_iprintf(buffer, "  port    : 0x%lx-0x%lx\n", 
 		    miro->aci_port, miro->aci_port+2);
-
+	snd_iprintf(buffer, "  wss     : 0x%x\n", wss);
+	snd_iprintf(buffer, "  ide     : 0x%x\n", ide);
+	snd_iprintf(buffer, "  solomode: 0x%x\n", miro->aci_solomode);
+	snd_iprintf(buffer, "  amp     : 0x%x\n", miro->aci_amp);
+	snd_iprintf(buffer, "  preamp  : 0x%x\n", miro->aci_preamp);
 }
 
 static void __devinit snd_miro_proc_init(miro_t * miro)

--J/dobhs11T7y2rNN--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
