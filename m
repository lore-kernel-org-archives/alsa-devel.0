From: Dirk Opfer <Dirk@Opfer-Online.de>
Subject: Re: [Patch] Fix compiler warnings in PXA2XX-AC97
Date: Wed, 14 Sep 2005 21:44:12 +0200
Message-ID: <0ML21M-1EFdAa1c5E-00078C@mrelayeu.kundenserver.de>
References: <0MKwtQ-1E1mHi2L9x-00028d@mrelayeu.kundenserver.de> <s5hu0i01m65.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080308020804050305050305"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0i01m65.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------080308020804050305050305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Takashi Iwai schrieb:

>At Sun, 07 Aug 2005 16:37:53 +0200,
>Dirk Opfer wrote:
>  
>
>>This patch fixes compiler warnings in the file pxa2xx-ac97.c.
>>
>>Changes:
>>
>>    -  change pxa2xx_ac97_do_suspend and pxa2xx_ac97_do_resume to use
>>the expected arguments
>>    
>>
>
>Thanks, applied to CVS.
>
>
>Takashi
>  
>
It seems with my last patch we forgot one line. Sorry for that
The attached Patch fixes this.

Cheers
Dirk

--------------080308020804050305050305
Content-Type: text/plain;
 name="pxa-ac97-suspend-r0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pxa-ac97-suspend-r0.patch"

Index: linux-2.6.13/sound/arm/pxa2xx-ac97.c
===================================================================
--- linux-2.6.13.orig/sound/arm/pxa2xx-ac97.c	2005-09-04 18:54:54.618428976 +0200
+++ linux-2.6.13/sound/arm/pxa2xx-ac97.c	2005-09-04 22:49:17.840494256 +0200
@@ -245,7 +245,7 @@
 
 #ifdef CONFIG_PM
 
-static int pxa2xx_ac97_do_suspend(snd_card_t *card, unsigned int state)
+static int pxa2xx_ac97_do_suspend(snd_card_t *card, pm_message_t state)
 {
 	if (card->power_state != SNDRV_CTL_POWER_D3cold) {
 		pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;

--------------080308020804050305050305--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
