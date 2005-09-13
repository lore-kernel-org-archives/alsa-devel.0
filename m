From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] - allow multiple ac97 quirks for one piece of hardware
Date: Tue, 13 Sep 2005 15:52:47 +0100
Message-ID: <20050913145247.GA8422@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vavatch.codon.org.uk (cavan.codon.org.uk [217.147.92.49])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3A73C1D9
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2005 16:52:48 +0200 (MEST)
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
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_ac97_tune_hardware currently exits after applying a single ac97 
quirk. There are bits of hardware (current HPs, for instance) that 
probably want two - MUTE_LED and HP_ONLY. The following trivial patch 
only exits if a quirk fails to apply. I'll send patches adding the 
quirks when I've made sure they work as expected on these machines.

--- sound/pci/ac97/ac97_codec.c.orig	2005-09-13 15:45:35.000000000 +0100
+++ linux/sound/pci/ac97/ac97_codec.c	2005-09-13 15:46:05.000000000 +0100
@@ -2551,9 +2551,10 @@ int snd_ac97_tune_hardware(ac97_t *ac97,
 				continue;
 			snd_printdd("ac97 quirk for %s (%04x:%04x)\n", quirk->name, ac97->subsystem_vendor, ac97->subsystem_device);
 			result = apply_quirk(ac97, quirk->type);
-			if (result < 0)
+			if (result < 0) {
 				snd_printk(KERN_ERR "applying quirk type %d for %s failed (%d)\n", quirk->type, quirk->name, result);
-			return result;
+				return result;
+			}
 		}
 	}
 	return 0;

-- 
Matthew Garrett | mjg59@srcf.ucam.org


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
