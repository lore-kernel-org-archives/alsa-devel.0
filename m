From: Anton Worshevsky <gbdj@linux.spb.org>
Subject: Re[2]: via8235 swaped channels
Date: Mon, 27 Jan 2003 22:40:58 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <17945.030127@linux.spb.org>
References: <s5h4r7ypmpe.wl@alsa2.suse.de>
Reply-To: Anton Worshevsky <gbdj@linux.spb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1251
Content-Transfer-Encoding: 8bit
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Friday, January 24, 2003, 6:54:53 PM, you wrote:

>> >> >  if someone has VIA8233, VIA8233A, VIA8233C or VIA8235 chipset, could
>> >> >  you help the testing of the new driver?
>> >> >  the new driver code is found at
>> >> >
>> >> >         http://www.alsa-project.org/~iwai/via82xx.c
>> >>
>> >> i has VIA8235 and ALC650 codec. After installing new driver from cvs from
>> >> 20030113, there is following problem:
>> >>
>> >> In 5.1-channel dvd playback with xine using surround51 device,
>> >> i has swapped Rear and Center/lfe channels.
>> >> RL <-> Center, RR <-> LFE
>>
>> this can be fixed just by exchanging Rear and Center/LFE jacks
>>
>> >> i fixed this with following patch for via82xx.c
>> >>
>> >> 812,813c812,815
>> >> <       case 5: slots = (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16); break;
>> >> <       case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
>> >> ---
>> >> > //    case 5: slots = (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16); break;
>> >> > //    case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
>> >> >       case 5: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16); break;
>> >> >       case 6: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16) | (6<<20); break;
>> >>
>> >> I'm not sure that it is alsa problem, xine' may be.
>>
>> TI> hmm, it could be due to the setting of ALC650.  how is the status of
>> TI> "Exchange Center/LFE" mixer switch?
>>
>> This switch has no effect. Strange. Usually its muted.
>> Now i think this is ALC650 problem.
>> Is there problem exist on via8235 with other codecs?

TI> the switch above is irrelevant to this behavior.  sorry for confusion.
TI> but there is another register bits, and i fixed it on the cvs.

TI> please update your alsa-kernel tree via cvs and give a try.

cvs from 25.01 don`t change this. as i understand we must to modify bits
15:14 in ALC650 vendor specific register MX6A (Multi-Channel Control).
i see that value of this register is always 0000h. in addition,
"Exchange Center/LFE" mixer switch, which must to set MX6A.3=1 do
nothing. MX6A still has 0000h value.

ALC650 uses following default slot mapping (as in AC’97 spec. rev2.2)
if MX6A=0000h
L  R  SL SR CEN LFE
3  4  7  8  6   9
now i`m again not sure that this is codec problem.

can anyone test this with other codec ?

Anton Worshevsky




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
