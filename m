From: John Ettedgui <john.ettedgui@gmail.com>
Subject: Re: ALSA Multichannel through HDMI
Date: Thu, 25 Nov 2010 04:21:39 -0800
Message-ID: <AANLkTi=9SMLG1vYjDAPUjQJaBwzOJSMchbE+oUVGcgRN@mail.gmail.com>
References: <20100112045102.GA29735@localhost>
	<eb9000ab1001112311o4bcf98dp2b616d1afffec9e0@mail.gmail.com>
	<20100112132140.GA7647@localhost>
	<eb9000ab1001120828l6829c6b1g30916b872a0467f7@mail.gmail.com>
	<20100113010942.GA6435@localhost>
	<eb9000ab1001121732y4212e6m9596f68e24d6c226@mail.gmail.com>
	<20100113014550.GA10184@localhost>
	<eb9000ab1001122048s1ac0d9c3n130692ba83dd53d1@mail.gmail.com>
	<20100113045238.GB26275@localhost>
	<eb9000ab1001122055s54bc6697t6103def1e8ae64ae@mail.gmail.com>
	<20100113050254.GA28475@localhost>
	<AANLkTim8zHRTc0F2CcfoXtxDkH2kpYajCuheo7GoQ4zW@mail.gmail.com>
	<ickmvo$kkf$1@dough.gmane.org>
	<AANLkTi=d7RHy4KgSS7yB+deAq=JnFabbA9qfwH8WQCG2@mail.gmail.com>
	<4CEE3F1E.4010405@iki.fi>
	<AANLkTikYpKak6C5Oz=c0OxiG8FaD2qqzn7siW0kMJgzs@mail.gmail.com>
	<4CEE4B29.5090808@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00163630ff89d8082e0495dfa52f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7970C103C2C
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 13:21:40 +0100 (CET)
Received: by qyk11 with SMTP id 11so931189qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 04:21:39 -0800 (PST)
In-Reply-To: <4CEE4B29.5090808@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--00163630ff89d8082e0495dfa52f
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 25, 2010 at 3:40 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
> On 25.11.2010 13:09, John Ettedgui wrote:
>> On Thu, Nov 25, 2010 at 2:49 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>> On 25.11.2010 06:12, John Ettedgui wrote:
>>>> I'm actually trying to get a 5.1 setup working without passthrough, if
>>>> I use mplayer with passthrough my receiver behaves just fine, but I am
>>>> trying to send the 6 channels from the computer.
>>>>
>>>> I was actually told that the current ALSA driver for radeon's hdmi
>>>> does not support more than 2 channels, and that would explain why I'm
>>>> getting this behavior. Is that true though?
>>>
>>> Yes.
>>>
>>>
>>> However, strangely your log output seems to show the intel's hdmi parser
>>> being used instead:
>>>
>>>> ALSA sound/pci/hda/patch_intelhdmi.c:842: hdmi_setup_stream: NID=0x2,
>>>> stream=0x1, new-format=0x11
>>>
>>> Were you just trying some patch at the time?
>>
>> yes Wu gave me a patch to try against the kernel, I'm guessing this is
>> the reason you see something unexpected.
>
> Did 6 channels work with that patch? (possibly with a wrong channel order)
Not any better as far as I remember.
>
> Also, could you provide the patch?
> (so that I won't ask you or anyone else to test unnecessary stuff :) )
I attached it to this email.
>
> I wasn't able to locate the original thread in archives.
>
>> Since I just moved to jack/rca cables I'm in no hurry anymore, but is
>> there any reason why the driver cannot work with more than 2 channels?
>
> I don't really know (it is simply not implemented).
Alright.
>
>> Anything I could do to help with that?
>
> Possibly. But see above, so that we won't try the same things you
> already tried :)
>
Sure :)
> --
> Anssi Hannula
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Thanks,
John

--00163630ff89d8082e0495dfa52f
Content-Type: text/x-patch; charset=US-ASCII; name="intelhdmi-R6xx.patch"
Content-Disposition: attachment; filename="intelhdmi-R6xx.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggxm3ife0

LS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX2F0aWhkbWkuYyAgIHwgICAgMiAtLQogc291bmQvcGNp
L2hkYS9wYXRjaF9pbnRlbGhkbWkuYyB8ICAgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKLS0tIHNvdW5kLTIuNi5vcmlnL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfYXRpaGRtaS5jCTIwMTAtMDEtMTIgMTI6NDQ6MjQuMDAwMDAwMDAwICswODAwCisr
KyBzb3VuZC0yLjYvc291bmQvcGNpL2hkYS9wYXRjaF9hdGloZG1pLmMJMjAxMC0wMS0xMiAxMjo0
NTo1OC4wMDAwMDAwMDAgKzA4MDAKQEAgLTE4OSw3ICsxODksNiBAQCBzdGF0aWMgc3RydWN0IGhk
YV9jb2RlY19wcmVzZXQgc25kX2hkYV9wCiAJeyAuaWQgPSAweDEwMDI3OTNjLCAubmFtZSA9ICJS
UzYwMCBIRE1JIiwgLnBhdGNoID0gcGF0Y2hfYXRpaGRtaSB9LAogCXsgLmlkID0gMHgxMDAyNzkx
OSwgLm5hbWUgPSAiUlM2MDAgSERNSSIsIC5wYXRjaCA9IHBhdGNoX2F0aWhkbWkgfSwKIAl7IC5p
ZCA9IDB4MTAwMjc5MWEsIC5uYW1lID0gIlJTNjkwLzc4MCBIRE1JIiwgLnBhdGNoID0gcGF0Y2hf
YXRpaGRtaSB9LAotCXsgLmlkID0gMHgxMDAyYWEwMSwgLm5hbWUgPSAiUjZ4eCBIRE1JIiwgLnBh
dGNoID0gcGF0Y2hfYXRpaGRtaSB9LAogCXsgLmlkID0gMHgxMDk1MTM5MCwgLm5hbWUgPSAiU2lJ
MTM5MCBIRE1JIiwgLnBhdGNoID0gcGF0Y2hfYXRpaGRtaSB9LAogCXsgLmlkID0gMHgxN2U4MDA0
NywgLm5hbWUgPSAiQ2hyb250ZWwgSERNSSIsICAucGF0Y2ggPSBwYXRjaF9hdGloZG1pIH0sCiAJ
e30gLyogdGVybWluYXRvciAqLwpAQCAtMTk4LDcgKzE5Nyw2IEBAIHN0YXRpYyBzdHJ1Y3QgaGRh
X2NvZGVjX3ByZXNldCBzbmRfaGRhX3AKIE1PRFVMRV9BTElBUygic25kLWhkYS1jb2RlYy1pZDox
MDAyNzkzYyIpOwogTU9EVUxFX0FMSUFTKCJzbmQtaGRhLWNvZGVjLWlkOjEwMDI3OTE5Iik7CiBN
T0RVTEVfQUxJQVMoInNuZC1oZGEtY29kZWMtaWQ6MTAwMjc5MWEiKTsKLU1PRFVMRV9BTElBUygi
c25kLWhkYS1jb2RlYy1pZDoxMDAyYWEwMSIpOwogTU9EVUxFX0FMSUFTKCJzbmQtaGRhLWNvZGVj
LWlkOjEwOTUxMzkwIik7CiBNT0RVTEVfQUxJQVMoInNuZC1oZGEtY29kZWMtaWQ6MTdlODAwNDci
KTsKIAotLS0gc291bmQtMi42Lm9yaWcvc291bmQvcGNpL2hkYS9wYXRjaF9pbnRlbGhkbWkuYwky
MDEwLTAxLTEyIDEyOjQ0OjE4LjAwMDAwMDAwMCArMDgwMAorKysgc291bmQtMi42L3NvdW5kL3Bj
aS9oZGEvcGF0Y2hfaW50ZWxoZG1pLmMJMjAxMC0wMS0xMiAxMjo0NToyOC4wMDAwMDAwMDAgKzA4
MDAKQEAgLTk4Nyw2ICs5ODcsNyBAQCBzdGF0aWMgc3RydWN0IGhkYV9jb2RlY19wcmVzZXQgc25k
X2hkYV9wCiAJeyAuaWQgPSAweDgwODYyODA0LCAubmFtZSA9ICJHNDUgREVWSUJYIiwgLnBhdGNo
ID0gcGF0Y2hfaW50ZWxfaGRtaSB9LAogCXsgLmlkID0gMHg4MDg2MDA1NCwgLm5hbWUgPSAiUTU3
IERFVklCWCIsIC5wYXRjaCA9IHBhdGNoX2ludGVsX2hkbWkgfSwKIAl7IC5pZCA9IDB4MTA5NTEz
OTIsIC5uYW1lID0gIlNpSTEzOTIgSERNSSIsICAgICAucGF0Y2ggPSBwYXRjaF9pbnRlbF9oZG1p
IH0sCisJeyAuaWQgPSAweDEwMDJhYTAxLCAubmFtZSA9ICJSNnh4IEhETUkiLAkucGF0Y2ggPSBw
YXRjaF9pbnRlbF9oZG1pIH0sCiAJe30gLyogdGVybWluYXRvciAqLwogfTsKIApAQCAtOTk3LDYg
Kzk5OCw3IEBAIE1PRFVMRV9BTElBUygic25kLWhkYS1jb2RlYy1pZDo4MDg2MjgwMyIKIE1PRFVM
RV9BTElBUygic25kLWhkYS1jb2RlYy1pZDo4MDg2MjgwNCIpOwogTU9EVUxFX0FMSUFTKCJzbmQt
aGRhLWNvZGVjLWlkOjgwODYwMDU0Iik7CiBNT0RVTEVfQUxJQVMoInNuZC1oZGEtY29kZWMtaWQ6
MTA5NTEzOTIiKTsKK01PRFVMRV9BTElBUygic25kLWhkYS1jb2RlYy1pZDoxMDAyYWEwMSIpOwog
CiBNT0RVTEVfTElDRU5TRSgiR1BMIik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIkludGVsIEhETUkg
SEQtYXVkaW8gY29kZWMiKTsK
--00163630ff89d8082e0495dfa52f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00163630ff89d8082e0495dfa52f--
