From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] wavefront: reduce stack usage
Date: Wed, 22 Dec 2004 15:01:06 -0800
Message-ID: <20041222150106.4b742a7e.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.osdl.org (fw.osdl.org [65.172.181.6])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9B9B9271
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2004 00:06:53 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pbd@op.net, perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Reduce local stack usage in wavefront_load_gus_patch()
from 984 bytes to 140 bytes (on x86-32) by using kmalloc()
instead of stack for these 840 bytes:
	wavefront_patch_info samp, pat, prog; // 3 * 280

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/wavfront.c |   56 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 21 deletions(-)

diff -Naurp ./sound/oss/wavfront.c~wavfront_stack ./sound/oss/wavfront.c
--- ./sound/oss/wavfront.c~wavfront_stack	2004-10-18 14:54:32.000000000 -0700
+++ ./sound/oss/wavfront.c	2004-12-22 14:44:22.330034016 -0800
@@ -1516,45 +1516,56 @@ wavefront_load_gus_patch (int devno, int
 			  int offs, int count, int pmgr_flag)
 {
 	struct patch_info guspatch;
-	wavefront_patch_info samp, pat, prog;
+	wavefront_patch_info *samp, *pat, *prog;
 	wavefront_patch *patp;
 	wavefront_sample *sampp;
 	wavefront_program *progp;
 
 	int i,base_note;
 	long sizeof_patch;
+	int rc = -ENOMEM;
+
+	samp = kmalloc(3 * sizeof(wavefront_patch_info), GFP_KERNEL);
+	if (!samp)
+		goto free_fail;
+	pat = samp + 1;
+	prog = pat + 1;
 
 	/* Copy in the header of the GUS patch */
 
 	sizeof_patch = (long) &guspatch.data[0] - (long) &guspatch; 
 	if (copy_from_user(&((char *) &guspatch)[offs],
-			   &(addr)[offs], sizeof_patch - offs))
-		return -EFAULT;
+			   &(addr)[offs], sizeof_patch - offs)) {
+		rc = -EFAULT;
+		goto free_fail;
+	}
 
 	if ((i = wavefront_find_free_patch ()) == -1) {
-		return -EBUSY;
+		rc = -EBUSY;
+		goto free_fail;
 	}
-	pat.number = i;
-	pat.subkey = WF_ST_PATCH;
-	patp = &pat.hdr.p;
+	pat->number = i;
+	pat->subkey = WF_ST_PATCH;
+	patp = &pat->hdr.p;
 
 	if ((i = wavefront_find_free_sample ()) == -1) {
-		return -EBUSY;
+		rc = -EBUSY;
+		goto free_fail;
 	}
-	samp.number = i;
-	samp.subkey = WF_ST_SAMPLE;
-	samp.size = guspatch.len;
-	sampp = &samp.hdr.s;
+	samp->number = i;
+	samp->subkey = WF_ST_SAMPLE;
+	samp->size = guspatch.len;
+	sampp = &samp->hdr.s;
 
-	prog.number = guspatch.instr_no;
-	progp = &prog.hdr.pr;
+	prog->number = guspatch.instr_no;
+	progp = &prog->hdr.pr;
 
 	/* Setup the patch structure */
 
 	patp->amplitude_bias=guspatch.volume;
 	patp->portamento=0;
-	patp->sample_number= samp.number & 0xff;
-	patp->sample_msb= samp.number>>8;
+	patp->sample_number= samp->number & 0xff;
+	patp->sample_msb= samp->number >> 8;
 	patp->pitch_bend= /*12*/ 0;
 	patp->mono=1;
 	patp->retrigger=1;
@@ -1587,7 +1598,7 @@ wavefront_load_gus_patch (int devno, int
 
 	/* Program for this patch */
 
-	progp->layer[0].patch_number= pat.number; /* XXX is this right ? */
+	progp->layer[0].patch_number= pat->number; /* XXX is this right ? */
 	progp->layer[0].mute=1;
 	progp->layer[0].pan_or_mod=1;
 	progp->layer[0].pan=7;
@@ -1635,11 +1646,11 @@ wavefront_load_gus_patch (int devno, int
 
 	/* Now ship it down */
 
-	wavefront_send_sample (&samp, 
+	wavefront_send_sample (samp, 
 			       (unsigned short __user *) &(addr)[sizeof_patch],
 			       (guspatch.mode & WAVE_UNSIGNED) ? 1:0);
-	wavefront_send_patch (&pat);
-	wavefront_send_program (&prog);
+	wavefront_send_patch (pat);
+	wavefront_send_program (prog);
 
 	/* Now pan as best we can ... use the slave/internal MIDI device
 	   number if it exists (since it talks to the WaveFront), or the
@@ -1651,8 +1662,11 @@ wavefront_load_gus_patch (int devno, int
 				       ((guspatch.panning << 4) > 127) ?
 				       127 : (guspatch.panning << 4));
 	}
+	rc = 0;
 
-	return(0);
+free_fail:
+	kfree(samp);
+	return rc;
 }
 
 static int


---


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
