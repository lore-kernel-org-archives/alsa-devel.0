From: Anton Worshevsky <gbdj@linux.spb.org>
Subject: Re: VIA 8233A, 8235 with ALC650 codec
Date: Tue, 18 Feb 2003 07:43:26 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <10321.030218@linux.spb.org>
References: <s5hel6g4hv0.wl@alsa2.suse.de>
Reply-To: Anton Worshevsky <gbdj@linux.spb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------12811A1C8B4A1AC"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: p z oooo <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------------12811A1C8B4A1AC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear Takashi Iwai,

Monday, February 10, 2003, 12:14:59 PM, you wrote:

>> When I changed VIA_REV_8233A to TYPE_VIA8233A my onboard soundcard
>> (VIA8233A + ALC650) works (2 channel, 4 cannel).
>>
>> 5.1 has problem - swaped channels. (LF, RF, Center - OK, LS - Woofer,
>> RS - LS, Woofer - RS.

TI> which program are you using?

TI> please check the ac97 register 0x6a in /proc/asound/card0/ac97#0regs
TI> and whether the bits 30-31 (zero-based) are off.

Do you mean bit 14-15 ?

As i posted before, i have similar channel swapping with VIA8235 + ALC650.
If bits 14-15 (slot modify) set to 0 - channels has incorrect placement.
It can be fixed by exchanging Rear and Center/LFE jacks.
When i set bit 14 to 1 - OK
Surely via8235 transmit multi-channel data in AC-Link in 3,4,6,9,7,8 order,
instead of 3,4,7,8,6,9 as specified in AC97.
I switch codec to 3,4,6,9,7,8 mode by setting bit 14 with following patch
in attachment for ac97_patch.c.


Other option is to apply may old patch to via82xx.c like this:

812,813c812,815
<       case 5: slots = (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16); break;
<       case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
---
> //    case 5: slots = (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16); break;
> //    case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
>       case 5: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16); break;
>       case 6: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16) | (6<<20); break;

We can't do this if there are any positive reports for 5.1 playback on via82xx.


May be better to create a new ALC650 specific mixer switch for bit 14 of 0x6a register ?
By this way we can solve all such future problems too.


Please commit one of this solutions to cvs.

Sincerely yours

Anton Worshevsky
------------12811A1C8B4A1AC
Content-Type: application/octet-stream; name="ac97_patch.c.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ac97_patch.c.diff"

LS0tIC91c3Ivc3JjL2Fsc2EvYWM5N19wYXRjaC5jCTIwMDMtMDEtMjggMTQ6MzU6NTMuMDAwMDAw
MDAwICswMzAwCisrKyAvdXNyL3NyYy9hbHNhL2Fsc2EtMjAwMzAyMTAvYWxzYS1rZXJuZWwvcGNp
L2FjOTcvYWM5N19wYXRjaC5jCTIwMDMtMDItMTAgMDc6MjY6NDUuMDAwMDAwMDAwICswMzAwCkBA
IC0zNjUsNyArMzY1LDggQEAKIAkJYWM5Ny0+ZXh0X2lkICY9IH5BQzk3X0VJX1NQRElGOyAvKiBk
aXNhYmxlIGV4dGVuZGVkLWlkICovCiAKIAl2YWwgPSBzbmRfYWM5N19yZWFkKGFjOTcsIEFDOTdf
QUxDNjUwX01VTFRJQ0gpOwotCXZhbCAmPSB+MHhjMDAwOyAvKiBzbG90OiAzLDQsNyw4LDYsOSAq
LworCS8vIHZhbCAmPSB+MHhjMDAwOyAvKiBzbG90OiAzLDQsNyw4LDYsOSAqLworCXZhbCB8PSAw
eDQwMDA7IC8qIHNsb3Q6IDMsNCw2LDksNyw4ICovCiAJc25kX2FjOTdfd3JpdGVfY2FjaGUoYWM5
NywgQUM5N19BTEM2NTBfTVVMVElDSCwgdmFsIHwgMHgwMyk7CiAKIAkvKiBmdWxsIERBQyB2b2x1
bWUgKi8K
------------12811A1C8B4A1AC--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
