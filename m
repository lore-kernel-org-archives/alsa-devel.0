From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/pci/rme9652/hdspm.c: fix off-by-one errors
Date: Sat, 11 Mar 2006 04:43:21 +0100
Message-ID: <20060311034321.GL21864__41324.1868875504$1142048658$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 87652129
	for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2006 04:43:20 +0100 (MET)
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
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes off-by-one errors found by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/sound/pci/rme9652/hdspm.c.old	2006-03-11 03:11:15.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/sound/pci/rme9652/hdspm.c	2006-03-11 03:12:10.000000000 +0100
@@ -474,7 +474,7 @@
 static inline int hdspm_read_in_gain(struct hdspm * hdspm, unsigned int chan,
 				     unsigned int in)
 {
-	if (chan > HDSPM_MIXER_CHANNELS || in > HDSPM_MIXER_CHANNELS)
+	if (chan >= HDSPM_MIXER_CHANNELS || in >= HDSPM_MIXER_CHANNELS)
 		return 0;
 
 	return hdspm->mixer->ch[chan].in[in];
@@ -483,7 +483,7 @@
 static inline int hdspm_read_pb_gain(struct hdspm * hdspm, unsigned int chan,
 				     unsigned int pb)
 {
-	if (chan > HDSPM_MIXER_CHANNELS || pb > HDSPM_MIXER_CHANNELS)
+	if (chan >= HDSPM_MIXER_CHANNELS || pb >= HDSPM_MIXER_CHANNELS)
 		return 0;
 	return hdspm->mixer->ch[chan].pb[pb];
 }



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
