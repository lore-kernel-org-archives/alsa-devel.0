From: Anton Worshevsky <gbdj@linux.spb.org>
Subject: Re: VIA 8233A, 8235 with ALC650 codec
Date: Thu, 20 Feb 2003 05:51:01 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16243.030220@linux.spb.org>
References: <s5hfzqlh66b.wl@alsa2.suse.de>
Reply-To: Anton Worshevsky <gbdj@linux.spb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Dear Takashi Iwai,

Tuesday, February 18, 2003, 8:03:56 PM, you wrote:

TI> At Tue, 18 Feb 2003 07:43:26 +0300,
TI> Anton Worshevsky wrote:
>>
>> >> When I changed VIA_REV_8233A to TYPE_VIA8233A my onboard soundcard
>> >> (VIA8233A + ALC650) works (2 channel, 4 cannel).
>> >> 5.1 has problem - swaped channels. (LF, RF, Center - OK, LS - Woofer,
>> >> RS - LS, Woofer - RS.
>>
>> As i posted before, i have similar channel swapping with VIA8235 + ALC650.
>> If bits 14-15 (slot modify) set to 0 - channels has incorrect placement.
>> It can be fixed by exchanging Rear and Center/LFE jacks.
>> When i set bit 14 to 1 - OK
>> Surely via8235 transmit multi-channel data in AC-Link in 3,4,6,9,7,8 order,
>> instead of 3,4,7,8,6,9 as specified in AC97.
>> I switch codec to 3,4,6,9,7,8 mode by setting bit 14 with following patch
>> in attachment for ac97_patch.c.

TI> well, then your investigation may be correct.  i have also no
TI> datasheet regarding this.
TI> i'll ask VIA guys whether the correct order is 3/4/6/9/7/8 or
TI> 3/4/7/8/6/9.

There are following slot assignments accordantly AC97 spec. v2.2 and v.2.3
LF/RF/LR/RR/C/LFE -- 3/4/7/8/6/9

In this ALC650 data sheet
http://www.realtek.com.tw/downloads/downloads1-3.aspx?refdesign=True&compamodel=ALC650
there are next:
LF/RF/LR/RR/C/LFE -- 3/4/7/8/6/9 if 0x6a.14=0 (default)
LF/RF/LR/RR/C/LFE -- 3/4/6/9/7/8 if 0x6a.14=1

As i see on VIA website, there is no via82xx spec freely available.
I don't understand their position in this question.

Now i made tests with last cvs for 4 channel too :
VIA8235 + ALC650
0x6a.14=0 : 4ch - OK; 5.1 - swaped
0x6a.14=1 : 4ch - swaped; 5.1 - OK

As you see - setting bit 14 of 0x6a reg is not an option.

We need to apply following patch again. =)

@@ -919,8 +920,8 @@
        case 2: slots = (1<<0) | (2<<4); break;
        case 3: slots = (1<<0) | (2<<4) | (5<<8); break;
        case 4: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12); break;
-       case 5: slots = (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16); break;
-       case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
+       case 5: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16); break;
+       case 6: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16) | (6<<20); break;
        default: slots = 0; break;
        }
        /* STOP index is never reached */

All working fine with this for VIA8235 + ALC650
It does not affect on VIA8233A as you remembered. =)
What chip combination is working wrong with this ?
It's much better solution for via8235, than

if (runtime->channels > 4)
    val = 0x4000;
else
    val = 0;
snd_ac97_update_bits(chip->ac97, AC97_ALC650_MULTICH, 0xc000, val);

Sincerely yours

Anton Worshevsky




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
