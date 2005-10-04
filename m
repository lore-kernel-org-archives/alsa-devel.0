From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error
 recognising the SB Live Platinum.
Date: Tue, 04 Oct 2005 12:08:53 +0100
Message-ID: <434262C5.80608@superbug.co.uk>
References: <dc7e3d7c111741a991e11a1a39ca9262@pobox.sk> <s5h4q7xeesw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C3FB1A9
	for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2005 13:08:56 +0200 (MEST)
In-Reply-To: <s5h4q7xeesw.wl%tiwai@suse.de>
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
Cc: Peter Zubaj <pzad@pobox.sk>, Dave Jones <davej@redhat.com>, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Tue, 04 Oct 2005 08:39:36 +0200,
>Peter Zubaj wrote:
>  
>
>>If ac97_chip=1 and ac97 doesn't exists - driver will refuse to load.
>>If ac97_chip=2 and ac97 doesn't exists - driver should ignore ac97
>>
>>But I don't know if this is correct (I am not author of patch and I not tested it).
>>if message is printed then there is
>>goto no_ac97; /* FIXME: get rid of ugly gotos.. */
>>this will skip ac97 mixer creation (if ac97 is not there this will fail and driver refuses to load)
>>But I don't know if snd_ac97_bus will fail if there is no ac97 codec (I think - not, and this is not correct), then test should be done on snd_ac97_mixer and not on snd_ac97_bus creation.
>>    
>>
>
>You're right.  The additional patch below fixes it.
>
>
>Takashi
>
>
>--- linux/sound/pci/emu10k1/emumixer.c	29 Sep 2005 17:59:43 -0000	1.38
>+++ linux/sound/pci/emu10k1/emumixer.c	4 Oct 2005 10:48:42 -0000
>@@ -802,21 +802,21 @@
> 			.read = snd_emu10k1_ac97_read,
> 		};
> 
>-		if ((err = snd_ac97_bus(emu->card, 0, &ops, NULL, &pbus)) < 0) {
>-			if (emu->card_capabilities->ac97_chip == 1)
>-				return err;
>-			snd_printd(KERN_INFO "emu10k1: AC97 is optional on this board\n");
>-			snd_printd(KERN_INFO"          Proceeding without ac97 mixers...\n");
>-			goto no_ac97; /* FIXME: get rid of ugly gotos.. */
>-		}
>+		if ((err = snd_ac97_bus(emu->card, 0, &ops, NULL, &pbus)) < 0)
>+			return err;
> 		pbus->no_vra = 1; /* we don't need VRA */
> 		
> 		memset(&ac97, 0, sizeof(ac97));
> 		ac97.private_data = emu;
> 		ac97.private_free = snd_emu10k1_mixer_free_ac97;
> 		ac97.scaps = AC97_SCAP_NO_SPDIF;
>-		if ((err = snd_ac97_mixer(pbus, &ac97, &emu->ac97)) < 0)
>-			return err;
>+		if ((err = snd_ac97_mixer(pbus, &ac97, &emu->ac97)) < 0) {
>+			if (emu->card_capabilities->ac97_chip == 1)
>+				return err;
>+			snd_printd(KERN_INFO "emu10k1: AC97 is optional on this board\n");
>+			snd_printd(KERN_INFO"          Proceeding without ac97 mixers...\n");
>+			goto no_ac97; /* FIXME: get rid of ugly gotos.. */
>+		}
> 		if (emu->audigy) {
> 			/* set master volume to 0 dB */
> 			snd_ac97_write(emu->ac97, AC97_MASTER, 0x0000);
>
>
>  
>
Surely is the snd_ac97_bus() always passes, and then the 
snd_ac97_mixer()  fails, it would be cleaner to undo the snd_ac97_bus() 
as well.




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
