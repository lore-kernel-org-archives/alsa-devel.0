From: p z oooo <pzad@pobox.sk>
Subject: Re: ALC650 GPIO bits
Date: Wed, 3 Mar 2004 18:22:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403031722.i23HMBe7011723@www5.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de, James@superbug.demon.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,

My fault.

This is what is in datasheets:

>There are two option circuits for MIC to disable bias voltage. For=20
>ALC650 ver.E or later, there is Vrefout-disabled function, so
>bias voltage from Vrefout(pin28) is recommended as option2 circuit.=20
>When MIC is shared with Center/LFE, software should
>disable Vrefout. For ALC650 ver.C/ver.D, Vrefout-disabled function=20
>is not implemented yet, so GPIO is used to switch bias
>voltage as option1/option3 circuit.

ALC650 ver. C, D and uses GPIO
ALC650 ver. E and later can use GPIO or Vrefout (register MX74=20
MISCELLANEOUS CONTROL bit 12 - it is used similiar as GPIO), maybe=20
all motherboards uses GPIO (but vrefout needs less components)

and there is this too:

>Vrefout Disable (Supported by the ALC650 Rev. E and Rev.F)
>0: Vrefout is driven by the internal reference (Default)
>1: Vrefout is in high-Z mode.
>Software must set this bit to disable Vrefout output before MX6A.10=20
>is set (MIC1 and MIC2 are shared as Center and LFE output).

Peter Zubaj



=0A____________________________________=0Ahttp://www.pobox.sk/ - spolahliva=
 a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
