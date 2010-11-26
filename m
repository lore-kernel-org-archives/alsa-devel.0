From: John Ettedgui <john.ettedgui@gmail.com>
Subject: Re: ALSA Multichannel through HDMI
Date: Thu, 25 Nov 2010 16:53:53 -0800
Message-ID: <AANLkTi=4CjtW0dY=1=kbPXEUu5N8MWYAoudMq409nKTi@mail.gmail.com>
References: <20100112045102.GA29735@localhost>
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
	<AANLkTi=9SMLG1vYjDAPUjQJaBwzOJSMchbE+oUVGcgRN@mail.gmail.com>
	<4CEEB6DF.2060905@iki.fi>
	<AANLkTim7O0vvRcQdYBmTNDnBwFhF-RskfOLtbCnKU_5M@mail.gmail.com>
	<4CEEE9F9.6040405@iki.fi>
	<AANLkTikRP7WnWc1k20qW-nZtOtNcfNimVOcxbf2uC8jD@mail.gmail.com>
	<4CEEEE0C.9090803@iki.fi>
	<AANLkTikS4C6GS2EuqdA_D58y4h9qCMBEWPSoO7JdhC9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cf7b60951430495ea28c7
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DF51103C93
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 01:53:55 +0100 (CET)
Received: by qyk11 with SMTP id 11so1538305qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 16:53:54 -0800 (PST)
In-Reply-To: <AANLkTikS4C6GS2EuqdA_D58y4h9qCMBEWPSoO7JdhC9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0015175cf7b60951430495ea28c7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 25, 2010 at 3:34 PM, John Ettedgui <john.ettedgui@gmail.com> wr=
ote:
> On Thu, Nov 25, 2010 at 3:15 PM, Anssi Hannula <anssi.hannula@iki.fi> wro=
te:
>> On 26.11.2010 01:11, John Ettedgui wrote:
>>> On Thu, Nov 25, 2010 at 2:58 PM, Anssi Hannula <anssi.hannula@iki.fi> w=
rote:
>>>> On 26.11.2010 00:42, John Ettedgui wrote:
>>>>> On Thu, Nov 25, 2010 at 11:19 AM, Anssi Hannula <anssi.hannula@iki.fi=
> wrote:
>>>>>> On 25.11.2010 14:21, John Ettedgui wrote:
>>>>>>> On Thu, Nov 25, 2010 at 3:40 AM, Anssi Hannula <anssi.hannula@iki.f=
i> wrote:
>>>>>>>> On 25.11.2010 13:09, John Ettedgui wrote:
>>>>>>>>> On Thu, Nov 25, 2010 at 2:49 AM, Anssi Hannula <anssi.hannula@iki=
.fi> wrote:
>>>>>>>>>> On 25.11.2010 06:12, John Ettedgui wrote:
>>>>>>>>>>> I'm actually trying to get a 5.1 setup working without passthro=
ugh, if
>>>>>>>>>>> I use mplayer with passthrough my receiver behaves just fine, b=
ut I am
>>>>>>>>>>> trying to send the 6 channels from the computer.
>>>>>>>>>>>
>>>>>>>>>>> I was actually told that the current ALSA driver for radeon's h=
dmi
>>>>>>>>>>> does not support more than 2 channels, and that would explain w=
hy I'm
>>>>>>>>>>> getting this behavior. Is that true though?
>>>>>>>>>>
>>>>>>>>>> Yes.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> However, strangely your log output seems to show the intel's hdm=
i parser
>>>>>>>>>> being used instead:
>>>>>>>>>>
>>>>>>>>>>> ALSA sound/pci/hda/patch_intelhdmi.c:842: hdmi_setup_stream: NI=
D=3D0x2,
>>>>>>>>>>> stream=3D0x1, new-format=3D0x11
>>>>>>>>>>
>>>>>>>>>> Were you just trying some patch at the time?
>>>>>>>>>
>>>>>>>>> yes Wu gave me a patch to try against the kernel, I'm guessing th=
is is
>>>>>>>>> the reason you see something unexpected.
>>>>>>>>
>>>>>>>> Did 6 channels work with that patch? (possibly with a wrong channe=
l order)
>>>>>>> Not any better as far as I remember.
>>>>>>
>>>>>> OK. Did 2 channel audio continue to work with it?
>>>>>>
>>>>>> If you are not sure, here's the patch doing the same thing against
>>>>>> current alsa driver:
>>>>>> http://stuff.onse.fi/0001-ALSA-hda-Use-generic-HDMI-code-for-ATI-HDM=
I-codecs.patch
>>>>>>
>>>>>> Confirming that would help (it would allow to switch the ATI chip to=
 use
>>>>>> the generic parser instead of the ATI-specific one), though not with=
 the
>>>>>> multichannel issue (see below).
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>>> Since I just moved to jack/rca cables I'm in no hurry anymore, bu=
t is
>>>>>>>>> there any reason why the driver cannot work with more than 2 chan=
nels?
>>>>>>>>
>>>>>>>> I don't really know (it is simply not implemented).
>>>>>>> Alright.
>>>>>>>>
>>>>>>>>> Anything I could do to help with that?
>>>>>>>>
>>>>>>>> Possibly. But see above, so that we won't try the same things you
>>>>>>>> already tried :)
>>>>>>>>
>>>>>>> Sure :)
>>>>>>
>>>>>> Looking again at the the alsa info output you provided, I don't thin=
k I
>>>>>> have any great ideas. It looks like the chip simply reports that it
>>>>>> supports a maximum of 2 channels.
>>>>>>
>>>>>> One option could be hardcoding "chans =3D 8;" in generic_hdmi_build_=
pcms()
>>>>>> in sound/pci/hda/patch_hdmi.c (assuming you have the above patch and=
 2
>>>>>> channel audio works with it). However, I find it rather unlikely tha=
t it
>>>>>> would make any difference.
>>>>>>
>>>>>> --
>>>>>> Anssi Hannula
>>>>>>
>>>>>
>>>>> Anssi,
>>>>> the patch fails on my kernel, I cannot find the hda_codec_preset
>>>>> manually in there either.
>>>>> Did you want me to try that against a 2.6.37 rc instead of a 2.6.36?
>>>>
>>>> For 2.6.36 I think you can just use your earlier patch.
>>>>
>>>> Note that on that kernel generic_hdmi_build_pcms() is
>>>> intel_hdmi_build_pcms() in patch_intelhdmi.c.
>>>>
>>> ok
>>>> BTW, I've just been informed by another ATI user that his card was
>>>> actually stereo-only, while he thought earlier it was multichannel
>>>> capable. So, are you sure your card is a multichannel one?
>>>> (if not, it would explain why the card says it is not)
>>>>
>>>> --
>>>> Anssi Hannula
>>>>
>>> Yes, it works fine in Window =C2=A0so I believe the hardware part is go=
od.
>>
>> And you are sure it is multichannel PCM, and not e.g. multichannel DTS
>> or multichannel AC-3 with on-the-fly compression, which are possible
>> with stereo hdmi as well?
>>
>> Just making sure :)
>>
>> --
>> Anssi Hannula
>>
>
> Well, I have not super tested it, but the reason I believe it is is
> simple, when I use passthrough my receiver says Dolby digital or
> something like that, but in Windows just going around or playing games
> it says Multichannel.
>
> I'll get the patch applied in a few minutes, I was running out of
> memory and my system was getting really slow... :)
>

I am not sure if I did it right but now I don't even get hdmi sound
working anymore.
It is not listed in aplay-l, and dmesg gives me this:
[drm:radeon_dvi_detect] *ERROR* HDMI Type A-1: probed a monitor but
no|invalid EDID

I've attached the patch I used, since I could not used the previous
one I had to hack it, maybe I broke something?
(I have not set channels to 8 yet, just changed the parser)

Thanks,
John

--0015175cf7b60951430495ea28c7
Content-Type: text/x-patch; charset=US-ASCII; name="intel.patch"
Content-Disposition: attachment; filename="intel.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggyczc3k0

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
MDAKQEAgLTE4NywzICsxODcsNCBAQCB7IC5pZCA9IDB4ODA4NjI4MDUsIC5uYW1lID0gIkNvdWdh
clBvaW50IEhETUkiLCAgIC5wYXRjaCA9IHBhdGNoX2ludGVsX2hkbWkgfSwKIHsgLmlkID0gMHgx
MDk1MTM5MiwgLm5hbWUgPSAiU2lJMTM5MiBIRE1JIiwgICAucGF0Y2ggPSBwYXRjaF9pbnRlbF9o
ZG1pIH0sCit7IC5pZCA9IDB4MTAwMmFhMDEsIC5uYW1lID0gIlI2eHggSERNSSIsCS5wYXRjaCA9
IHBhdGNoX2ludGVsX2hkbWkgfSwKIHt9IC8qIHRlcm1pbmF0b3IgKi8KIH07CiAKQEAgLTE5NSw2
ICsxOTUsNyBAQCBNT0RVTEVfQUxJQVMoInNuZC1oZGEtY29kZWMtaWQ6ODA4NjI4MDMiCiBNT0RV
TEVfQUxJQVMoInNuZC1oZGEtY29kZWMtaWQ6ODA4NjI4MDQiKTsKIE1PRFVMRV9BTElBUygic25k
LWhkYS1jb2RlYy1pZDo4MDg2MjgwNSIpOwogTU9EVUxFX0FMSUFTKCJzbmQtaGRhLWNvZGVjLWlk
OjgwODYwMDU0Iik7CiBNT0RVTEVfQUxJQVMoInNuZC1oZGEtY29kZWMtaWQ6MTA5NTEzOTIiKTsK
K01PRFVMRV9BTElBUygic25kLWhkYS1jb2RlYy1pZDoxMDAyYWEwMSIpOwogCiBNT0RVTEVfTElD
RU5TRSgiR1BMIik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIkludGVsIEhETUkgSEQtYXVkaW8gY29k
ZWMiKTsK
--0015175cf7b60951430495ea28c7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015175cf7b60951430495ea28c7--
