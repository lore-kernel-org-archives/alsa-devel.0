From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Wed, 14 Sep 2005 16:06:44 +0800
Message-ID: <4327DA14.3040205@netvigator.com>
References: <431D554E.8050500@netvigator.com> <20050906142917.GA30523@sashak.softier1.local> <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de> <4321B5A4.5090803@netvigator.com> <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050913174930.GA5816@titan.lahn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Sasha Khapyorsky <sashak@smlink.com>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Philipp Matthias Hahn wrote:
> Hello!
> 
> On Tue, Sep 13, 2005 at 08:35:29PM +0300, Sasha Khapyorsky wrote:
> 
>>On 10:55 Tue 13 Sep     , Philipp Matthias Hahn wrote:
>>
>>>See attached tar-file for a full copy of everything under
>>>/proc/asound/au8810 after applying the attached patch against ASLA from
>>>linux-2.6.13.1.
>>
>>ac97#0-N entries are identical there for both codecs, this is because
>>ac97_codec_read/write always accesses primary codec. Try next patch
>>please.
>>
>>--- au88x0_core.c_orig	2005-09-13 20:00:50.000000000 +0300
>>+++ au88x0_core.c	2005-09-13 20:05:36.000000000 +0300
>>@@ -2535,7 +2535,8 @@ vortex_codec_write(ac97_t * codec, unsig
>> 	}
>> 	/* write register */
>> 	hwwrite(card->mmio, VORTEX_CODEC_IO,
>>-		((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
>>+		(((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
>>+		 ((0x80*codec->num) << VORTEX_CODEC_ADDSHIFT)) |
>> 		((data << VORTEX_CODEC_DATSHIFT) & VORTEX_CODEC_DATMASK) |
>> 		VORTEX_CODEC_WRITE);
>> 
>>@@ -2560,6 +2561,7 @@ static unsigned short vortex_codec_read(
>> 	}
>> 	/* set up read address */
>> 	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK);
>>+	read_addr |= (0x80*codec->num) << VORTEX_CODEC_ADDSHIFT ;
>> 	hwwrite(card->mmio, VORTEX_CODEC_IO, read_addr);
> 

#define VORTEX_CODEC_WRITE	0x00800000
#define VORTEX_CODEC_ADDSHIFT 	16

(0x80* 1) << VORTEX_CODEC_ADDSHIFT)  is equal to  VORTEX_CODEC_WRITE

May be au8810 use different set of MMIO to read/write and report
status of the audio codec and modem codec ?

au8810.h

#define VORTEX_MODEM_CTRL	0x291ac

Make sure you have a BACKUP of all your data before you peform testing
on the modem.

It's not easy to hack the modem since we don't have any datasheet of 
au8810 and MOT6269353. (AC-link between them)

> 
> ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
> Vortex: init.... <6>done.
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> AC'97 1 does not respond - RESET
> vortex: ac97 address never arrived
> vortex: ac97 address never arrived
> AC'97 1 access is not valid [0xffffffff], removing mixer.
> Vortex: shutdown...vortex: FATAL: ResManager: resource type 3 exhausted.
> vortex: FATAL: ResManager: resource type 3 exhausted.
> vortex_adb_delroutes: route not found! 0x24a0
> src alarm
> vortex_adb_delroutes: route not found! 0x24a1
> src alarm
> vortex_adb_delroutes: route not found! 0x7e88
> vortex_adb_delroutes: route not found! 0x7f89
> vortex: FATAL: ResManager: resource type 2 exhausted.
> vortex: FATAL: ResManager: resource type 2 exhausted.
> vortex_adb_delroutes: route not found! 0x7044
> vortex_adb_delroutes: route not found! 0x7144
> vortex: FATAL: ResManager: resource type 3 exhausted.
> vortex: FATAL: ResManager: resource type 3 exhausted.
> vortex_adb_delroutes: route not found! 0x2492
> src alarm
> vortex_adb_delroutes: route not found! 0x2493
> src alarm
> done.
> ACPI: PCI interrupt for device 0000:00:06.0 disabled
> au8810: probe of 0000:00:06.0 failed with error -5
> 
> BYtE
> Philipp






-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
