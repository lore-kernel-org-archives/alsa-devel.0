From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Problems with multiple simultaneous ac97 quirks
Date: Thu, 15 Sep 2005 21:28:58 +0100
Message-ID: <20050915202858.GA5169@srcf.ucam.org>
References: <20050915180415.GA24705@srcf.ucam.org> <s5h4q8mm7qi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vavatch.codon.org.uk (cavan.codon.org.uk [217.147.92.49])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40C87175
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 22:28:59 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5h4q8mm7qi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 15, 2005 at 09:49:41PM +0200, Takashi Iwai wrote:

> I think the new quirk is the only solution in this case.
> And there won't be so many combinations in the real world, I'd
> expect.

Ok. Something like the following patch? It introduces 
AC97_TUNE_HP_MUTE_LED (yes, it's a poor name...) which is identical to 
AC97_TUNE_MUTE_LED except it calls bind_hp_volsw_put instead of 
snd_ac97_put_volsw and removes the headphone mixer controls.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ac97.diff"

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

--Kj7319i9nmIyA2yE--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
