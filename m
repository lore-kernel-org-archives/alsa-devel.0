From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] no templated index for si3036 modem controls
Date: Tue, 13 Sep 2005 04:06:24 +0300
Message-ID: <20050913010624.GB1682@tecr>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <20050905232951.GG20428@sashak.softier1.local> <s5h8xyauxxr.wl%tiwai@suse.de> <20050907160343.GA3375@sashak.softier1.local> <20050912002746.GA31233@tecr> <s5hzmqih8q2.wl%tiwai@suse.de> <s5hzmqifa6e.wl%tiwai@suse.de> <20050913004559.GA1682@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050913004559.GA1682@tecr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 03:45 Tue 13 Sep     , Sasha Khapyorsky wrote:
> 
> No index is templated for mdoem controls.

And same for si3036 specific controls.

Sasha.


No index is templated for si3036 modem controls.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/ac97/ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.96
diff -u -p -r1.96 ac97_patch.c
--- alsa-kernel/pci/ac97/ac97_patch.c	2 Sep 2005 13:03:07 -0000	1.96
+++ alsa-kernel/pci/ac97/ac97_patch.c	13 Sep 2005 00:22:45 -0000
@@ -2752,7 +2752,11 @@ AC97_DOUBLE("Modem Speaker Volume", 0x5c
 
 static int patch_si3036_specific(ac97_t * ac97)
 {
-	return patch_build_controls(ac97, snd_ac97_controls_si3036, ARRAY_SIZE(snd_ac97_controls_si3036));
+	int idx, err;
+	for (idx = 0; idx < ARRAY_SIZE(snd_ac97_controls_si3036); idx++)
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ctl_new1(&snd_ac97_controls_si3036[idx], ac97))) < 0)
+			return err;
+	return 0;
 }
 
 static struct snd_ac97_build_ops patch_si3036_ops = {


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
