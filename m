From: Rene Rebe <rene.rebe@gmx.net>
Subject: [PATCH] pmac also apply the DMA stop work around to fix capture on
 iBook2
Date: Fri, 30 Jul 2004 16:56:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410A619D.6010102@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020006060509050404080108"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a multi-part message in MIME format.
--------------020006060509050404080108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

the attached patch for the pmac driver fixes capture for at least all 
iBook2s I have access to. Without the fix arround 33% percent of all 
recordings are just white noise.

Have fun,
  René Rebe

--------------020006060509050404080108
Content-Type: text/plain;
 name="alsa-pmac2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-pmac2.patch"

--- ppc/pmac.c~	2004-07-30 14:14:36.643095880 +0200
+++ ppc/pmac.c	2004-07-30 14:16:47.039272648 +0200
@@ -224,15 +224,15 @@
 	/* We really want to execute a DMA stop command, after the AWACS
 	 * is initialized.
 	 * For reasons I don't understand, it stops the hissing noise
-	 * common to many PowerBook G3 systems (like mine :-).
+	 * common to many PowerBook G3 systems and random noise otherwise
+	 * captured on iBook2's about every third time. -ReneR
 	 */
 	spin_lock_irq(&chip->reg_lock);
 	snd_pmac_dma_stop(rec);
-	if (rec->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		st_le16(&chip->extra_dma.cmds->command, DBDMA_STOP);
-		snd_pmac_dma_set_command(rec, &chip->extra_dma);
-		snd_pmac_dma_run(rec, RUN);
-	}
+	st_le16(&chip->extra_dma.cmds->command, DBDMA_STOP);
+	snd_pmac_dma_set_command(rec, &chip->extra_dma);
+	snd_pmac_dma_run(rec, RUN);
+	mdelay(5);
 	/* continuous DMA memory type doesn't provide the physical address,
 	 * so we need to resolve the address here...
 	 */



--------------020006060509050404080108--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
