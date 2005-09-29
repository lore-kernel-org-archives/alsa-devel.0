From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: no Sound with SiS965L / Realtek ALC655
Date: Thu, 29 Sep 2005 22:30:24 +0200
Message-ID: <433C4EE0.3010309@gmx.net>
References: <433285F4.5060509@gmx.net> <s5hmzlwdn0n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040707090102050204070008"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzlwdn0n.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net, Rainer Koenig <Rainer.Koenig@fujitsu-siemens.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040707090102050204070008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

yesterday i have build a minor patch against  alsa intel8x0.c  nearly
alsa 1.0.10-rc1.
I have removed 2 checks for the AC97 codec ready status. And it works now.

The status will go later to ready, if you start a play.

regards
Uwe Koziolek


>At Thu, 22 Sep 2005 12:22:44 +0200,
>Uwe Koziolek wrote:
>  
>
>>Hello,
>>
>>I have Prolems with the ALSA-sound:
>>
>>Sep 22 12:09:54 uk5 kernel: ACPI: PCI Interrupt 0000:00:02.7[C] -> Link
>>[LNKC] -> GSI 11 (level, low) -> IRQ 11
>>Sep 22 12:09:55 uk5 kernel: ALSA
>>/usr/src/alsa-driver-1.0.10rc1/pci/intel8x0.c:2216: codec_ready: codec
>>is not ready [0x340000]
>>    
>>
>
>This is often related with ACPI setting.
>Try acpi=off boot option once.
>If this doesn't work...  well, it's hard to fix.
>
>
>Takashi
>
>
>  
>


--------------040707090102050204070008
Content-Type: application/gzip;
 name="alsa.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="alsa.patch.gz"

H4sICPoYO0MAA2Fsc2EucGF0Y2gAhZBva9swEMZfy5/iVtiw68iWnTRNUtKlf0wXVlLIyt60
QziWUosmkrHlLmH0u/eceC1jZRMCSXf33D36CbVcAp2VNayUrjc0DvpB1A0rU2sRFpkKlbZy
NdiwIGsrBCrezTuUUkjfTZGYsSPKhjTqQzQc9bqjuBew3wt8hnnH931Y/FseD4GxUTTA/Zd8
MgF6dNztRBhozj5MJg4QkhkhMxjDg7RcZTnfvflCWTfLVdGB3ds7wdJnBxxKwsN9CEqZii18
hsMQo2oJrquwh/hpStFKpxdf5smVe3V9c86/3Z55Hnxq28F4DMxDHSmlrUsNNJnenDgUp2D/
M701WkJuVkLpB0ihkuu0yE0pYWlKiGBd4fwqN/VKwEI2NxsEQeMEiFVrid+JGEPP+0WEgV87
AHEcDzrH4OPZeyXQeP8AlU1tXXlYiKHGhTbtR1WFY5H6vj8hlRa8KBH/o/s1mc94Mp/DwR7b
jsnoTaeNbTndsc3HzY97fdCB/2JC2kjmTzQ4uOHf2m2E9FTIJ5VJbreFbIBeJt+nFwmfzm6T
a45Ne57zAhQtbni/AgAA
--------------040707090102050204070008--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
