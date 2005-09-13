From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] no templated index for mc97 controls
Date: Tue, 13 Sep 2005 03:45:59 +0300
Message-ID: <20050913004559.GA1682@tecr>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <20050905232951.GG20428@sashak.softier1.local> <s5h8xyauxxr.wl%tiwai@suse.de> <20050907160343.GA3375@sashak.softier1.local> <20050912002746.GA31233@tecr> <s5hzmqih8q2.wl%tiwai@suse.de> <s5hzmqifa6e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzmqifa6e.wl%tiwai@suse.de>
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

On 19:49 Mon 12 Sep     , Takashi Iwai wrote:
> 
> But I think we should fix the driver side rather than this
> configuration.  The index should be zero because it's the only one.

Like in the patch below? (please don't say that you fixed it already :) ).

Sasha.


No index is templated for mdoem controls.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.197
diff -u -p -r1.197 ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	9 Sep 2005 13:21:46 -0000	1.197
+++ alsa-kernel/pci/ac97/ac97_codec.c	13 Sep 2005 00:18:43 -0000
@@ -1557,7 +1557,7 @@ static int snd_ac97_modem_build(snd_card
 
 	/* build modem switches */
 	for (idx = 0; idx < ARRAY_SIZE(snd_ac97_controls_modem_switches); idx++)
-		if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_modem_switches[idx], ac97))) < 0)
+		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_ac97_controls_modem_switches[idx], ac97))) < 0)
 			return err;
 
 	/* build chip specific controls */


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
