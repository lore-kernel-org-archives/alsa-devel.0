From: Kostas <hunter18@gmail.com>
Subject: Re: REGRESSION: Webcam mic for 145f:015b not longer
 working with 1.0.24 and above (OK with 1.0.23)
Date: Tue, 28 Aug 2012 12:47:36 +0300
Message-ID: <503C93B8.1010505@gmail.com>
References: <503B372B.4050807@gmail.com> <503B3D48.5030206@gmail.com>
 <503B4CEE.2070200@gmail.com> <503B5DB9.9080804@gmail.com>
 <503B982E.4060703@gmail.com> <503BF284.4060300@gmail.com>
 <503C5AA4.8070408@gmail.com> <503C85BA.6020505@gmail.com>
 <503C8658.400@gmail.com> <503C87AD.2010204@gmail.com>
 <503C8A03.809@gmail.com> <503C8CCC.2000801@gmail.com>
 <503C8F9A.7020104@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010004010603020100040800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 79108265CAB
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 11:47:40 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1342445bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 02:47:40 -0700 (PDT)
In-Reply-To: <503C8F9A.7020104@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010004010603020100040800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 28/08/2012 12:30 =CE=BC=CE=BC, Daniel Mack wrote:
> On 28.08.2012 11:18, Kostas wrote:
>> On 28/08/2012 12:06 =C3=8E=C2=BC=C3=8E=C2=BC, Daniel Mack wrote:
>>> On 28.08.2012 10:56, Kostas wrote:
>>>> On 28/08/2012 11:50 =C3=8F=C2=80=C3=8E=C2=BC, Daniel Mack wrote:
>>>>> On 28.08.2012 10:47, Kostas wrote:
>>>>>> On 28/08/2012 08:44 =C3=83=C2=8F=C3=82=C2=80=C3=83=C2=8E=C3=82=C2=BC=
, Daniel Mack wrote:
>>>>>>> On 28.08.2012 00:19, Kostas wrote:
>>>>>>>> On 27/08/2012 06:54 =C3=83=C2=8E=C3=82=C2=BC=C3=83=C2=8E=C3=82=C2=
=BC, Kostas wrote:
>>>>>>>>> On 27/08/2012 02:44 =C3=83=C2=8E=C3=82=C2=BC=C3=83=C2=8E=C3=82=C2=
=BC, Daniel Mack wrote:
>>>>>>>>>> On 27.08.2012 12:33, Kostas wrote:
>>>>>>>>>>> On 27/08/2012 12:26 =C3=83=C2=8E=C3=82=C2=BC=C3=83=C2=8E=C3=82=
=C2=BC, Daniel Mack wrote:
>>>>>>>>>>>> On 27.08.2012 11:00, Kostas wrote:
>>>>>>>>>>>>> Hi All,
>>>>>>>>>>>>>
>>>>>>>>>>>>> I have a 'Trust Webcam' (USB ID: 145f:015b) that comes with=
 a
>>>>>>>>>>>>> microphone.
>>>>>>>>>>>>> The microphone works with Alsa 1.0.23 but it does not work =
with the
>>>>>>>>>>>>> latest Alsa 1.0.25 neither with Alsa 1.0.24.
>>>>>>>>>>>>> Apparently this is a regression.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What shall I do to figure out the source of the problem?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Here are attached my alsa-infos, with Alsa 1.0.23 (working)=
,
>>>>>>>>>>>>> 1.0.24 (NOT
>>>>>>>>>>>>> working) and 1.0.25 (NOT working).
>>>>>>>>>>>> Can you provide dmesg protocols for both a working and a non=
-working
>>>>>>>>>>>> case please?
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>> Below are attached the dmesg files.
>>>>>>>>>>>
>>>>>>>>>> Thanks - the logs look both good, I guess the interesting mess=
ages are
>>>>>>>>>> only generated once you try to start the stream. Can you try t=
his?
>>>>>>>>> How i do that?
>>>>>>>>> I tried to make a test call in skype and also recording a video=
 in
>>>>>>>>> cheese but no changes in dmesg.
>>>>>>>>> Is there another way to start the stream?
>>>>>>>> Also tried to record voice with sound recorder...with alsa 1.0.2=
3
>>>>>>>> recording is fine..i hear my voice when playback the file but wi=
th alsa
>>>>>>>> 1.0.24 and above nothing is recorded.
>>>>>>>> In both cases nothing is changed in dmesg output.
>>>>>>>> What else could i do to help you out?
>>>>>>>>
>>>>>>> Comparing the two dmesg logs, I'm under the impression that in th=
e
>>>>>>> second case (the newer kernel), the hda driver kicks in and creat=
es a
>>>>>>> sound device before the usb audio driver does. Hence, the default=
 card
>>>>>>> changes and you're recording from your internal sound card rather=
 than
>>>>>>> the Webcam.
>>>>>>>
>>>>>>> Could you please send the output of 'aplay -l' in both cases?
>>>>>>>
>>>>>>>
>>>>>>> Daniel
>>>>>>>
>>>>>> Output of working case
>>>>>> **** List of PLAYBACK Hardware Devices ****
>>>>>> card 0: SB [HDA ATI SB], device 0: AD198x Analog [AD198x Analog]
>>>>>> =C3=83=C2=82  Subdevices: 1/1
>>>>>> =C3=83=C2=82  Subdevice #0: subdevice #0
>>>>>> card 0: SB [HDA ATI SB], device 1: AD198x Digital [AD198x Digital]
>>>>>> =C3=83=C2=82  Subdevices: 1/1
>>>>>> =C3=83=C2=82  Subdevice #0: subdevice #0
>>>>>> card 2: Generic [HD-Audio Generic], device 3: HDMI 0 [HDMI 0]
>>>>>> =C3=83=C2=82  Subdevices: 1/1
>>>>>> =C3=83=C2=82  Subdevice #0: subdevice #0
>>>>> Sorry, there's of course no playback on a webcam. Try 'arecord -l'
>>>>> instead, please.
>>>>>
>>>>>
>>>>> Daniel
>>>>>
>>>> Output of non-working case
>>>> **** List of CAPTURE Hardware Devices ****
>>>> card 0: SB [HDA ATI SB], device 0: AD198x Analog [AD198x Analog]
>>>>      Subdevices: 3/3
>>>>      Subdevice #0: subdevice #0
>>>>      Subdevice #1: subdevice #1
>>>>      Subdevice #2: subdevice #2
>>>> card 1: Webcam [Trust 2MP Auto Focus Webcam], device 0: USB Audio [U=
SB
>>>> Audio]
>>>>      Subdevices: 1/1
>>>>      Subdevice #0: subdevice #0
>>>>
>>>>
>>>> Output of working case
>>>> **** List of CAPTURE Hardware Devices ****
>>>> card 0: SB [HDA ATI SB], device 0: AD198x Analog [AD198x Analog]
>>>>      Subdevices: 3/3
>>>>      Subdevice #0: subdevice #0
>>>>      Subdevice #1: subdevice #1
>>>>      Subdevice #2: subdevice #2
>>>> card 1: default [Trust 2MP Auto Focus Webcam ], device 0: USB Audio =
[USB
>>>> Audio]
>>>>      Subdevices: 1/1
>>>>      Subdevice #0: subdevice #0
>>>>
>>> Try 'arecord -f cd -Dplughw:1 foo.wav' and see if that works. For
>>> whatever reason, the webcam is not the default in the non-working cas=
e.
>>> Are you using the same userspace and configs in both cases?
>>>
>>>
>>> Daniel
>>>
>> Unfortunately it doesn't work...voice is recorded only in 1.0.23 alsa
>> version.
>> In above version nothing is recorded.
>> I use the same Ubuntu release just the kernel changes
>> 1.0.23 alsa is in kernel 2.6.38
>> newer alsa versions that don't work are in newer kernels.
> I still think it is all related to configs and settings. Can you please
> go check all relevant volume settings and routing switches with amixer
> or alsamixer? The fact that the default changes tells me that
> something's different in the behaviour in which ALSA handles the device=
s.
>
> Also note that 1.0.24 is rather ancient already, and while the driver
> has seen quiet some refactoring lately, I haven't heard about
> regressions in that version yet - and I'm sure we would have gotten a
> whole lot of reports if there was such a tremendous breakage. And
> there's no signs of errors in the kernel logs either. But you never
> know, of course.
>
>
> Daniel
>
Alsamixer working case http://imagebin.org/226143
Alsamixer non-working case http://imagebin.org/226142

I also attach amixer output for both cases.

--------------010004010603020100040800
Content-Type: text/plain; charset=UTF-8;
 name="amixer_non_working.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="amixer_non_working.txt"

U2ltcGxlIG1peGVyIGNvbnRyb2wgJ01hc3RlcicsMAogIENhcGFiaWxpdGllczogcHZvbHVt
ZSBwdm9sdW1lLWpvaW5lZCBwc3dpdGNoIHBzd2l0Y2gtam9pbmVkIHBlbnVtCiAgUGxheWJh
Y2sgY2hhbm5lbHM6IE1vbm8KICBMaW1pdHM6IFBsYXliYWNrIDAgLSAzOQogIE1vbm86IFBs
YXliYWNrIDM5IFsxMDAlXSBbMC4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdQ
Q00nLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUgcGVudW0KICBQbGF5YmFjayBjaGFubmVs
czogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMjU1
CiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFswLjAwZEJdCiAg
RnJvbnQgUmlnaHQ6IFBsYXliYWNrIDI1NSBbMTAwJV0gWzAuMDBkQl0KU2ltcGxlIG1peGVy
IGNvbnRyb2wgJ0Zyb250JywwCiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lIHBzd2l0Y2ggcGVu
dW0KICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGlt
aXRzOiBQbGF5YmFjayAwIC0gMzkKICBNb25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDM5
IFsxMDAlXSBbMC4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDM5IFsxMDAl
XSBbMC4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdTdXJyb3VuZCcsMAogIENh
cGFiaWxpdGllczogcHZvbHVtZSBwc3dpdGNoIHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6
IEZyb250IExlZnQgLSBGcm9udCBSaWdodAogIExpbWl0czogUGxheWJhY2sgMCAtIDM5CiAg
TW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5YmFjayAzOSBbMTAwJV0gWzAuMDBkQl0gW29uXQog
IEZyb250IFJpZ2h0OiBQbGF5YmFjayAzOSBbMTAwJV0gWzAuMDBkQl0gW29uXQpTaW1wbGUg
bWl4ZXIgY29udHJvbCAnQ2VudGVyJywwCiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lIHB2b2x1
bWUtam9pbmVkIHBzd2l0Y2ggcHN3aXRjaC1qb2luZWQgcGVudW0KICBQbGF5YmFjayBjaGFu
bmVsczogTW9ubwogIExpbWl0czogUGxheWJhY2sgMCAtIDM5CiAgTW9ubzogUGxheWJhY2sg
MzkgWzEwMCVdIFswLjAwZEJdIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ0xGRScsMAog
IENhcGFiaWxpdGllczogcHZvbHVtZSBwdm9sdW1lLWpvaW5lZCBwc3dpdGNoIHBzd2l0Y2gt
am9pbmVkIHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBMaW1pdHM6IFBsYXli
YWNrIDAgLSAzOQogIE1vbm86IFBsYXliYWNrIDM5IFsxMDAlXSBbMC4wMGRCXSBbb25dClNp
bXBsZSBtaXhlciBjb250cm9sICdTaWRlJywwCiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lIHBz
d2l0Y2ggcGVudW0KICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJp
Z2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMzkKICBNb25vOgogIEZyb250IExlZnQ6IFBs
YXliYWNrIDM5IFsxMDAlXSBbMC4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNr
IDM5IFsxMDAlXSBbMC4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdMaW5lJyww
CiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lIHBzd2l0Y2ggcGVudW0KICBQbGF5YmFjayBjaGFu
bmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0g
MzEKICBNb25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDAgWzAlXSBbLTM0LjUwZEJdIFtv
bl0KICBGcm9udCBSaWdodDogUGxheWJhY2sgMCBbMCVdIFstMzQuNTBkQl0gW29uXQpTaW1w
bGUgbWl4ZXIgY29udHJvbCAnTGluZScsMQogIENhcGFiaWxpdGllczogcHZvbHVtZSBwc3dp
dGNoIHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBSaWdo
dAogIExpbWl0czogUGxheWJhY2sgMCAtIDMxCiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5
YmFjayAwIFswJV0gWy0zNC41MGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDAg
WzAlXSBbLTM0LjUwZEJdIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ0NEJywwCiAgQ2Fw
YWJpbGl0aWVzOiBwdm9sdW1lIHBzd2l0Y2ggcGVudW0KICBQbGF5YmFjayBjaGFubmVsczog
RnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMzEKICBN
b25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDAgWzAlXSBbLTM0LjUwZEJdIFtvZmZdCiAg
RnJvbnQgUmlnaHQ6IFBsYXliYWNrIDAgWzAlXSBbLTM0LjUwZEJdIFtvZmZdClNpbXBsZSBt
aXhlciBjb250cm9sICdNaWMnLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUgcHN3aXRjaCBw
ZW51bQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBM
aW1pdHM6IFBsYXliYWNrIDAgLSAzMQogIE1vbm86CiAgRnJvbnQgTGVmdDogUGxheWJhY2sg
MzEgWzEwMCVdIFsxMi4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDMxIFsx
MDAlXSBbMTIuMDBkQl0gW29uXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnTWljIEJvb3N0Jyww
CiAgQ2FwYWJpbGl0aWVzOiB2b2x1bWUgcGVudW0KICBQbGF5YmFjayBjaGFubmVsczogRnJv
bnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgQ2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAt
IEZyb250IFJpZ2h0CiAgTGltaXRzOiAwIC0gMwogIEZyb250IExlZnQ6IDAgWzAlXSBbMC4w
MGRCXQogIEZyb250IFJpZ2h0OiAwIFswJV0gWzAuMDBkQl0KU2ltcGxlIG1peGVyIGNvbnRy
b2wgJ0lFQzk1OCcsMAogIENhcGFiaWxpdGllczogcHZvbHVtZSBwc3dpdGNoIHBzd2l0Y2gt
am9pbmVkIHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBS
aWdodAogIExpbWl0czogUGxheWJhY2sgMCAtIDM5CiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQ
bGF5YmFjayAzOSBbMTAwJV0gWzAuMDBkQl0gW29uXQogIEZyb250IFJpZ2h0OiBQbGF5YmFj
ayAzOSBbMTAwJV0gWzAuMDBkQl0gW29uXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnSUVDOTU4
IERlZmF1bHQgUENNJywwCiAgQ2FwYWJpbGl0aWVzOiBwc3dpdGNoIHBzd2l0Y2gtam9pbmVk
IHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBNb25vOiBQbGF5YmFjayBbb2Zm
XQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnSUVDOTU4IFBsYXliYWNrIFNvdXJjZScsMAogIENh
cGFiaWxpdGllczogZW51bQogIEl0ZW1zOiAnUENNJyAnQURDMScgJ0FEQzInICdBREMzJwog
IEl0ZW0wOiAnUENNJwpTaW1wbGUgbWl4ZXIgY29udHJvbCAnQmVlcCcsMAogIENhcGFiaWxp
dGllczogcHZvbHVtZSBwdm9sdW1lLWpvaW5lZCBwc3dpdGNoIHBzd2l0Y2gtam9pbmVkIHBl
bnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBMaW1pdHM6IFBsYXliYWNrIDAgLSAx
NQogIE1vbm86IFBsYXliYWNrIDE1IFsxMDAlXSBbMC4wMGRCXSBbb2ZmXQpTaW1wbGUgbWl4
ZXIgY29udHJvbCAnQ2FwdHVyZScsMAogIENhcGFiaWxpdGllczogY3ZvbHVtZSBjc3dpdGNo
IHBlbnVtCiAgQ2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAg
TGltaXRzOiBDYXB0dXJlIDAgLSA1NAogIEZyb250IExlZnQ6IENhcHR1cmUgMzEgWzU3JV0g
Wy0xMi4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IENhcHR1cmUgMzEgWzU3JV0gWy0xMi4w
MGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdDYXB0dXJlJywxCiAgQ2FwYWJpbGl0
aWVzOiBjdm9sdW1lIGNzd2l0Y2ggcGVudW0KICBDYXB0dXJlIGNoYW5uZWxzOiBGcm9udCBM
ZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IENhcHR1cmUgMCAtIDU0CiAgRnJvbnQgTGVm
dDogQ2FwdHVyZSA1NCBbMTAwJV0gWzIyLjUwZEJdIFtvZmZdCiAgRnJvbnQgUmlnaHQ6IENh
cHR1cmUgNTQgWzEwMCVdIFsyMi41MGRCXSBbb2ZmXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAn
Q2FwdHVyZScsMgogIENhcGFiaWxpdGllczogY3ZvbHVtZSBjc3dpdGNoIHBlbnVtCiAgQ2Fw
dHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBDYXB0
dXJlIDAgLSA1NAogIEZyb250IExlZnQ6IENhcHR1cmUgNTQgWzEwMCVdIFsyMi41MGRCXSBb
b2ZmXQogIEZyb250IFJpZ2h0OiBDYXB0dXJlIDU0IFsxMDAlXSBbMjIuNTBkQl0gW29mZl0K
U2ltcGxlIG1peGVyIGNvbnRyb2wgJ0FuYWxvZyBNaXgnLDAKICBDYXBhYmlsaXRpZXM6IHB2
b2x1bWUgcHN3aXRjaCBwZW51bQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0g
RnJvbnQgUmlnaHQKICBMaW1pdHM6IFBsYXliYWNrIDAgLSAzMQogIE1vbm86CiAgRnJvbnQg
TGVmdDogUGxheWJhY2sgMzEgWzEwMCVdIFswLjAwZEJdIFtvbl0KICBGcm9udCBSaWdodDog
UGxheWJhY2sgMzEgWzEwMCVdIFswLjAwZEJdIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wg
J0RpZ2l0YWwnLDAKICBDYXBhYmlsaXRpZXM6IGN2b2x1bWUgcGVudW0KICBDYXB0dXJlIGNo
YW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IENhcHR1cmUgMCAt
IDEyMAogIEZyb250IExlZnQ6IENhcHR1cmUgNjAgWzUwJV0gWzAuMDBkQl0KICBGcm9udCBS
aWdodDogQ2FwdHVyZSA2MCBbNTAlXSBbMC4wMGRCXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAn
SW5wdXQgU291cmNlJywwCiAgQ2FwYWJpbGl0aWVzOiBjZW51bQogIEl0ZW1zOiAnTWljJyAn
TGluZScgJ0xpbmUgMScgJ0NEJyAnTWl4JwogIEl0ZW0wOiAnTWljJwpTaW1wbGUgbWl4ZXIg
Y29udHJvbCAnSW5wdXQgU291cmNlJywxCiAgQ2FwYWJpbGl0aWVzOiBjZW51bQogIEl0ZW1z
OiAnTWljJyAnTGluZScgJ0xpbmUgMScgJ0NEJyAnTWl4JwogIEl0ZW0wOiAnTWljJwpTaW1w
bGUgbWl4ZXIgY29udHJvbCAnSW5wdXQgU291cmNlJywyCiAgQ2FwYWJpbGl0aWVzOiBjZW51
bQogIEl0ZW1zOiAnTWljJyAnTGluZScgJ0xpbmUgMScgJ0NEJyAnTWl4JwogIEl0ZW0wOiAn
TWljJwo=
--------------010004010603020100040800
Content-Type: text/plain; charset=UTF-8;
 name="amixer_working.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="amixer_working.txt"

U2ltcGxlIG1peGVyIGNvbnRyb2wgJ01hc3RlcicsMAogIENhcGFiaWxpdGllczogcHZvbHVt
ZSBwdm9sdW1lLWpvaW5lZCBwc3dpdGNoIHBzd2l0Y2gtam9pbmVkIHBlbnVtCiAgUGxheWJh
Y2sgY2hhbm5lbHM6IE1vbm8KICBMaW1pdHM6IFBsYXliYWNrIDAgLSAzOQogIE1vbm86IFBs
YXliYWNrIDM5IFsxMDAlXSBbMC4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdQ
Q00nLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUgcGVudW0KICBQbGF5YmFjayBjaGFubmVs
czogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMjU1
CiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFswLjAwZEJdCiAg
RnJvbnQgUmlnaHQ6IFBsYXliYWNrIDI1NSBbMTAwJV0gWzAuMDBkQl0KU2ltcGxlIG1peGVy
IGNvbnRyb2wgJ0Zyb250JywwCiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lIHBzd2l0Y2ggcGVu
dW0KICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGlt
aXRzOiBQbGF5YmFjayAwIC0gMzkKICBNb25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDM5
IFsxMDAlXSBbMC4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDM5IFsxMDAl
XSBbMC4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdTdXJyb3VuZCcsMAogIENh
cGFiaWxpdGllczogcHZvbHVtZSBwc3dpdGNoIHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6
IEZyb250IExlZnQgLSBGcm9udCBSaWdodAogIExpbWl0czogUGxheWJhY2sgMCAtIDM5CiAg
TW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5YmFjayAzOSBbMTAwJV0gWzAuMDBkQl0gW29uXQog
IEZyb250IFJpZ2h0OiBQbGF5YmFjayAzOSBbMTAwJV0gWzAuMDBkQl0gW29uXQpTaW1wbGUg
bWl4ZXIgY29udHJvbCAnQ2VudGVyJywwCiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lIHB2b2x1
bWUtam9pbmVkIHBzd2l0Y2ggcHN3aXRjaC1qb2luZWQgcGVudW0KICBQbGF5YmFjayBjaGFu
bmVsczogTW9ubwogIExpbWl0czogUGxheWJhY2sgMCAtIDM5CiAgTW9ubzogUGxheWJhY2sg
MzkgWzEwMCVdIFswLjAwZEJdIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ0xGRScsMAog
IENhcGFiaWxpdGllczogcHZvbHVtZSBwdm9sdW1lLWpvaW5lZCBwc3dpdGNoIHBzd2l0Y2gt
am9pbmVkIHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBMaW1pdHM6IFBsYXli
YWNrIDAgLSAzOQogIE1vbm86IFBsYXliYWNrIDM5IFsxMDAlXSBbMC4wMGRCXSBbb25dClNp
bXBsZSBtaXhlciBjb250cm9sICdTaWRlJywwCiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lIHBz
d2l0Y2ggcGVudW0KICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJp
Z2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMzkKICBNb25vOgogIEZyb250IExlZnQ6IFBs
YXliYWNrIDM5IFsxMDAlXSBbMC4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNr
IDM5IFsxMDAlXSBbMC4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdMaW5lJyww
CiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lIHBzd2l0Y2ggcGVudW0KICBQbGF5YmFjayBjaGFu
bmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0g
MzEKICBNb25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDAgWzAlXSBbLTM0LjUwZEJdIFtv
bl0KICBGcm9udCBSaWdodDogUGxheWJhY2sgMCBbMCVdIFstMzQuNTBkQl0gW29uXQpTaW1w
bGUgbWl4ZXIgY29udHJvbCAnTGluZScsMQogIENhcGFiaWxpdGllczogcHZvbHVtZSBwc3dp
dGNoIHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBSaWdo
dAogIExpbWl0czogUGxheWJhY2sgMCAtIDMxCiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5
YmFjayAwIFswJV0gWy0zNC41MGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDAg
WzAlXSBbLTM0LjUwZEJdIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ0NEJywwCiAgQ2Fw
YWJpbGl0aWVzOiBwdm9sdW1lIHBzd2l0Y2ggcGVudW0KICBQbGF5YmFjayBjaGFubmVsczog
RnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMzEKICBN
b25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDAgWzAlXSBbLTM0LjUwZEJdIFtvZmZdCiAg
RnJvbnQgUmlnaHQ6IFBsYXliYWNrIDAgWzAlXSBbLTM0LjUwZEJdIFtvZmZdClNpbXBsZSBt
aXhlciBjb250cm9sICdNaWMnLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUgcHN3aXRjaCBw
ZW51bQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBM
aW1pdHM6IFBsYXliYWNrIDAgLSAzMQogIE1vbm86CiAgRnJvbnQgTGVmdDogUGxheWJhY2sg
MzEgWzEwMCVdIFsxMi4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDMxIFsx
MDAlXSBbMTIuMDBkQl0gW29uXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnTWljIEJvb3N0Jyww
CiAgQ2FwYWJpbGl0aWVzOiB2b2x1bWUgcGVudW0KICBQbGF5YmFjayBjaGFubmVsczogRnJv
bnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgQ2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAt
IEZyb250IFJpZ2h0CiAgTGltaXRzOiAwIC0gMwogIEZyb250IExlZnQ6IDAgWzAlXSBbMC4w
MGRCXQogIEZyb250IFJpZ2h0OiAwIFswJV0gWzAuMDBkQl0KU2ltcGxlIG1peGVyIGNvbnRy
b2wgJ0lFQzk1OCcsMAogIENhcGFiaWxpdGllczogcHZvbHVtZSBwc3dpdGNoIHBzd2l0Y2gt
am9pbmVkIHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBS
aWdodAogIExpbWl0czogUGxheWJhY2sgMCAtIDM5CiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQ
bGF5YmFjayAzOSBbMTAwJV0gWzAuMDBkQl0gW29uXQogIEZyb250IFJpZ2h0OiBQbGF5YmFj
ayAzOSBbMTAwJV0gWzAuMDBkQl0gW29uXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnSUVDOTU4
IERlZmF1bHQgUENNJywwCiAgQ2FwYWJpbGl0aWVzOiBwc3dpdGNoIHBzd2l0Y2gtam9pbmVk
IHBlbnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBNb25vOiBQbGF5YmFjayBbb2Zm
XQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnSUVDOTU4IFBsYXliYWNrIFNvdXJjZScsMAogIENh
cGFiaWxpdGllczogZW51bQogIEl0ZW1zOiAnUENNJyAnQURDMScgJ0FEQzInICdBREMzJwog
IEl0ZW0wOiAnUENNJwpTaW1wbGUgbWl4ZXIgY29udHJvbCAnQmVlcCcsMAogIENhcGFiaWxp
dGllczogcHZvbHVtZSBwdm9sdW1lLWpvaW5lZCBwc3dpdGNoIHBzd2l0Y2gtam9pbmVkIHBl
bnVtCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBMaW1pdHM6IFBsYXliYWNrIDAgLSAx
NQogIE1vbm86IFBsYXliYWNrIDE1IFsxMDAlXSBbMC4wMGRCXSBbb2ZmXQpTaW1wbGUgbWl4
ZXIgY29udHJvbCAnQ2FwdHVyZScsMAogIENhcGFiaWxpdGllczogY3ZvbHVtZSBjc3dpdGNo
IHBlbnVtCiAgQ2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAg
TGltaXRzOiBDYXB0dXJlIDAgLSA1NAogIEZyb250IExlZnQ6IENhcHR1cmUgMzEgWzU3JV0g
Wy0xMi4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IENhcHR1cmUgMzEgWzU3JV0gWy0xMi4w
MGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdDYXB0dXJlJywxCiAgQ2FwYWJpbGl0
aWVzOiBjdm9sdW1lIGNzd2l0Y2ggcGVudW0KICBDYXB0dXJlIGNoYW5uZWxzOiBGcm9udCBM
ZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IENhcHR1cmUgMCAtIDU0CiAgRnJvbnQgTGVm
dDogQ2FwdHVyZSA1NCBbMTAwJV0gWzIyLjUwZEJdIFtvZmZdCiAgRnJvbnQgUmlnaHQ6IENh
cHR1cmUgNTQgWzEwMCVdIFsyMi41MGRCXSBbb2ZmXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAn
Q2FwdHVyZScsMgogIENhcGFiaWxpdGllczogY3ZvbHVtZSBjc3dpdGNoIHBlbnVtCiAgQ2Fw
dHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBDYXB0
dXJlIDAgLSA1NAogIEZyb250IExlZnQ6IENhcHR1cmUgNTQgWzEwMCVdIFsyMi41MGRCXSBb
b2ZmXQogIEZyb250IFJpZ2h0OiBDYXB0dXJlIDU0IFsxMDAlXSBbMjIuNTBkQl0gW29mZl0K
U2ltcGxlIG1peGVyIGNvbnRyb2wgJ0FuYWxvZyBNaXgnLDAKICBDYXBhYmlsaXRpZXM6IHB2
b2x1bWUgcHN3aXRjaCBwZW51bQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0g
RnJvbnQgUmlnaHQKICBMaW1pdHM6IFBsYXliYWNrIDAgLSAzMQogIE1vbm86CiAgRnJvbnQg
TGVmdDogUGxheWJhY2sgMzEgWzEwMCVdIFswLjAwZEJdIFtvbl0KICBGcm9udCBSaWdodDog
UGxheWJhY2sgMzEgWzEwMCVdIFswLjAwZEJdIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wg
J0RpZ2l0YWwnLDAKICBDYXBhYmlsaXRpZXM6IGN2b2x1bWUgcGVudW0KICBDYXB0dXJlIGNo
YW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IENhcHR1cmUgMCAt
IDEyMAogIEZyb250IExlZnQ6IENhcHR1cmUgNjAgWzUwJV0gWzAuMDBkQl0KICBGcm9udCBS
aWdodDogQ2FwdHVyZSA2MCBbNTAlXSBbMC4wMGRCXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAn
SW5wdXQgU291cmNlJywwCiAgQ2FwYWJpbGl0aWVzOiBjZW51bQogIEl0ZW1zOiAnTWljJyAn
TGluZScgJ0xpbmUgMScgJ0NEJyAnTWl4JwogIEl0ZW0wOiAnTWljJwpTaW1wbGUgbWl4ZXIg
Y29udHJvbCAnSW5wdXQgU291cmNlJywxCiAgQ2FwYWJpbGl0aWVzOiBjZW51bQogIEl0ZW1z
OiAnTWljJyAnTGluZScgJ0xpbmUgMScgJ0NEJyAnTWl4JwogIEl0ZW0wOiAnTWljJwpTaW1w
bGUgbWl4ZXIgY29udHJvbCAnSW5wdXQgU291cmNlJywyCiAgQ2FwYWJpbGl0aWVzOiBjZW51
bQogIEl0ZW1zOiAnTWljJyAnTGluZScgJ0xpbmUgMScgJ0NEJyAnTWl4JwogIEl0ZW0wOiAn
TWljJwo=
--------------010004010603020100040800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010004010603020100040800--
