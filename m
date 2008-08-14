From: Manuel Schneider <manuel.schneider@kanal-ratte.de>
Subject: Re: Swissonic TS22PCI / Teratec Phase 22 /
 driver	problems with ice1724
Date: Thu, 14 Aug 2008 16:09:10 +0200
Message-ID: <48A43C86.6010105@kanal-ratte.de>
References: <48A4332E.4070704@kanal-ratte.de>
	<s5habff1zft.wl%tiwai@suse.de>	<48A43A2A.7050701@kanal-ratte.de>
	<s5h63q31yoh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mastersmail.com (mx1.mastersmail.com [195.114.98.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D4AC1038B0
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Aug 2008 16:09:22 +0200 (CEST)
In-Reply-To: <s5h63q31yoh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb, Am 14.08.2008 16:03:

> At Thu, 14 Aug 2008 15:59:06 +0200,
> Manuel Schneider wrote:
>> Takashi Iwai schrieb, Am 14.08.2008 15:47:
>>
>>> Pass model=phase22 module option to snd-ice1724 driver.  Then it
>>> handles the card as if it's phase22.
>> Thanks for this hin. Unfortunately it changes nothing - still kernel 
>> error message, still no usable sound device.
> 
> Are you sure?  With the proper model name, at least you won't get
> EEPROM version error any more.




yes, pretty sure. I just reverted my patch and recompiled the driver to
check it out:

ice1712: cannot initialize pro ac97, skipped
ice1724: No matching model found for ID 0x3b157b11
ice1724: Invalid EEPROM version 0
AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0xffffffff], removing mixer.
ice1712: cannot initialize pro ac97, skipped


>> I also tried the following kernel patch, which gives me an accessible 
>> sound device and usable mixer (and no kernel error), but recording does 
>> not work (just noise).
> 
> Likely an incompatible hardware design for the recording...



I guess it's another firmware... I can't test playback as I only have
remote access to the server and it is only used for recording
(streaming) but I assume it does also not work.
I admit that this patch was just a hack to try it out.



Manuel
-- 
Kanal Ratte 104,5 MHz
...das Freie Radio im Wiesental

Hauptstrasse 82
79650 Schopfheim

Tel: +49 7622 6692-53
Fax: +49 7622 6692-54
