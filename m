From: Manuel Schneider <manuel.schneider@kanal-ratte.de>
Subject: Re:
	=?iso-8859-1?q?Swissonic_TS22PCI_/_Teratec_Phase_22_?=
	=?iso-8859-1?q?/_driver=09problems_with_ice1724?=
Date: Thu, 14 Aug 2008 18:05:27 +0200
Message-ID: <200808141805.28109.manuel.schneider@kanal-ratte.de>
References: <48A4332E.4070704@kanal-ratte.de> <48A43C11.10904@kanal-ratte.de>
	<s5hzlnfznty.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mastersmail.com (mx1.mastersmail.com [195.114.98.122])
	by alsa0.perex.cz (Postfix) with ESMTP id E7B71244D0
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Aug 2008 18:05:47 +0200 (CEST)
In-Reply-To: <s5hzlnfznty.wl%tiwai@suse.de>
Content-Disposition: inline
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

Am Donnerstag, 14. August 2008 schrieb Takashi Iwai:
> > I guess it's another firmware...
>
> The board has no firmware to load.

well, I was thinking of the eeprom.

> First you should check whether the exactly same codec chip, AK4524, on
> it.

Yes, it has, but another model no (or whatever it is). I just have both 
cards - the original Phase 22 and the new TS22 here:

Phase 22:
AKM AK4524VF 193A0547N
VIA ENVY24HT-S VT1721-0522CD 2IA0000551

TS22:
AKM AK4524VF 247A0805N
VIA ENVY24HT-S VT1721-0810CD 2IA0001861

The PCBs are nearly the same, but the TS22 lacks the following parts:
X3 quartz
UD09 and UD10 (both ICs)

On the Back of the Swissonic TS22 it says "Terrasoniq" - which is knows as yet 
another vendor of sound cards. Swissonic seems to be just another brand of 
the same product.

Something about the noise / recording:
When I unpug the lines, the noise still persists.
When I fade down both ADC lines with alsamixer, the noise perists until I 
reach 0. Then it is mute.
When I fade up ADC1 I can hear some of the to-be-recorded signal very 
distorted behind the noise.

Greets,


Manuel

-- 
Kanal Ratte 104,5 MHz
...das Freie Radio im Wiesental

Hauptstrasse 82
79650 Schopfheim

Tel: +49 7622 6692-53
Fax: +49 7622 6692-54
