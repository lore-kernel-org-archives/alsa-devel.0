From: Anton Worshevsky <gbdj@linux.spb.org>
Subject: Re: VIA 8233A, 8235 with ALC650 codec
Date: Mon, 24 Feb 2003 00:50:27 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1135.030224@linux.spb.org>
References: <s5hvfzffhee.wl@alsa2.suse.de>
Reply-To: Anton Worshevsky <gbdj@linux.spb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------119192A06038311"
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

------------119192A06038311
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear Takashi Iwai,

Thursday, February 20, 2003, 12:08:57 PM, you wrote:

>> Now i made tests with last cvs for 4 channel too :
>> VIA8235 + ALC650
>> 0x6a.14=0 : 4ch - OK; 5.1 - swaped
>> 0x6a.14=1 : 4ch - swaped; 5.1 - OK
>>
>> As you see - setting bit 14 of 0x6a reg is not an option.
>>
>> We need to apply following patch again. =)
>>
>> @@ -919,8 +920,8 @@
>>         case 2: slots = (1<<0) | (2<<4); break;
>>         case 3: slots = (1<<0) | (2<<4) | (5<<8); break;
>>         case 4: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12); break;
>> -       case 5: slots = (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16); break;
>> -       case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
>> +       case 5: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16); break;
>> +       case 6: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16) | (6<<20); break;
>>         default: slots = 0; break;
>>         }
>>         /* STOP index is never reached */

TI> ok.  i'll take the change back again.

Playback in alsa applications now is GOOD. =)
simultaneous multiple streams - OK
5.1ch - OK
Only in some games working with oss-emulation sound is still bad
(tux-racer, ut, heroes3)

>> All working fine with this for VIA8235 + ALC650
>> It does not affect on VIA8233A as you remembered. =)
>> What chip combination is working wrong with this ?

TI> no idea.  i hope both via8233 and 8233c follow to the same rule.

I suggest to add ALC650 specific control for 0x6a.14 "Slot Modify" (see my
patch). I think this will make a life of future testers a little bit easy.
There is also small fix (i think) for ac97_patch.c in my patch.

I found that "Exchange Center/LFE" is not working on my hardware.
After changing bit 0x6a.3 by snd_ac97_write_cache() it still has 0 value.
All other controls for 0x6a register works fine
( "Duplicate Front", "Mic As Center/LFE", "Line-In As Surround",
"Center/LFE Down Mix", "Surround Down Mix" and my new "Slot Modify" ).
I think that bit 0x6a.3 can not be set on my combination of hardware.
Is it possible ? Or just another software bug ?

Sincerely yours

Anton Worshevsky

------------119192A06038311
Content-Type: application/octet-stream; name="slotcontrol.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="slotcontrol.diff"

ZGlmZiAtdSAtciBjb250cm9sLWJ1aWxkL2Fsc2Eta2VybmVsL3BjaS9hYzk3L2FjOTdfY29kZWMu
YyBhbHNhLTIwMDMwMjIzL2Fsc2Eta2VybmVsL3BjaS9hYzk3L2FjOTdfY29kZWMuYwotLS0gY29u
dHJvbC1idWlsZC9hbHNhLWtlcm5lbC9wY2kvYWM5Ny9hYzk3X2NvZGVjLmMJMjAwMy0wMi0yMCAx
NDowMDozOS4wMDAwMDAwMDAgKzAzMDAKKysrIGFsc2EtMjAwMzAyMjMvYWxzYS1rZXJuZWwvcGNp
L2FjOTcvYWM5N19jb2RlYy5jCTIwMDMtMDItMjMgMjM6MzE6MzYuMDAwMDAwMDAwICswMzAwCkBA
IC0xMDgxLDYgKzEwODEsNyBAQAogCS8qIDg6IHJlc2VydmVkICovCiAJQUM5N19TSU5HTEUoIkxp
bmUtSW4gQXMgU3Vycm91bmQiLCBBQzk3X0FMQzY1MF9NVUxUSUNILCA5LCAxLCAwKSwKIAlBQzk3
X1NJTkdMRSgiTWljIEFzIENlbnRlci9MRkUiLCBBQzk3X0FMQzY1MF9NVUxUSUNILCAxMCwgMSwg
MCksCisJQUM5N19TSU5HTEUoIlNsb3QgTW9kaWZ5IiwgQUM5N19BTEM2NTBfTVVMVElDSCwgMTQs
IDEsIDApLAogI2lmIDAgLyogYWx3YXlzIHNldCBpbiBwYXRjaF9hbGM2NTAgKi8KIAlBQzk3X1NJ
TkdMRSgiSUVDOTU4IElucHV0IENsb2NrIEVuYWJsZSIsIEFDOTdfQUxDNjUwX0NMT0NLLCAwLCAx
LCAwKSwKIAlBQzk3X1NJTkdMRSgiSUVDOTU4IElucHV0IFBpbiBFbmFibGUiLCBBQzk3X0FMQzY1
MF9DTE9DSywgMSwgMSwgMCksCmRpZmYgLXUgLXIgY29udHJvbC1idWlsZC9hbHNhLWtlcm5lbC9w
Y2kvYWM5Ny9hYzk3X3BhdGNoLmMgYWxzYS0yMDAzMDIyMy9hbHNhLWtlcm5lbC9wY2kvYWM5Ny9h
Yzk3X3BhdGNoLmMKLS0tIGNvbnRyb2wtYnVpbGQvYWxzYS1rZXJuZWwvcGNpL2FjOTcvYWM5N19w
YXRjaC5jCTIwMDMtMDEtMjggMTQ6MzU6NTMuMDAwMDAwMDAwICswMzAwCisrKyBhbHNhLTIwMDMw
MjIzL2Fsc2Eta2VybmVsL3BjaS9hYzk3L2FjOTdfcGF0Y2guYwkyMDAzLTAyLTIzIDIzOjI3OjMw
LjAwMDAwMDAwMCArMDMwMApAQCAtMzY2LDcgKzM2Niw3IEBACiAKIAl2YWwgPSBzbmRfYWM5N19y
ZWFkKGFjOTcsIEFDOTdfQUxDNjUwX01VTFRJQ0gpOwogCXZhbCAmPSB+MHhjMDAwOyAvKiBzbG90
OiAzLDQsNyw4LDYsOSAqLwotCXNuZF9hYzk3X3dyaXRlX2NhY2hlKGFjOTcsIEFDOTdfQUxDNjUw
X01VTFRJQ0gsIHZhbCB8IDB4MDMpOworCXNuZF9hYzk3X3dyaXRlX2NhY2hlKGFjOTcsIEFDOTdf
QUxDNjUwX01VTFRJQ0gsIHZhbCk7CiAKIAkvKiBmdWxsIERBQyB2b2x1bWUgKi8KIAlzbmRfYWM5
N193cml0ZV9jYWNoZShhYzk3LCBBQzk3X0FMQzY1MF9TVVJSX0RBQ19WT0wsIDB4MDgwOCk7Cg==
------------119192A06038311--




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
