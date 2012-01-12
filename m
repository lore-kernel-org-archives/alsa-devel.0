From: Cefn Hoile <alsa-project.org@cefn.com>
Subject: Re: Dell N5110 HDA External Speaker is mute
Date: Thu, 12 Jan 2012 15:11:16 +0000
Message-ID: <CA+P0tC-O4iffZ-eE_n=Oh4Eweuxs_QGstw9815ZZTitfwyAcGA@mail.gmail.com>
References: <CA+P0tC_jvOyEsbmZoF5oJZ9k6DA3FRaHCbq+xP3axw+jgLaQ8w@mail.gmail.com>
	<s5h4nw1fbxj.wl%tiwai@suse.de>
	<CA+P0tC_Pnx_JTE7dfiH+PY+hCf-wVsY+vp9H_KVdHpOz5uxgEw@mail.gmail.com>
	<CA+P0tC--i4BDbHrDZRgKuO=sGRw9+q8j_1q2WS1YmUmfpuc91Q@mail.gmail.com>
	<s5h1ur5f9ii.wl%tiwai@suse.de>
	<CA+P0tC_y6QOdgmqSRmMtMvHM+OsMW2mq2325_m8ER4z7Mi6gKQ@mail.gmail.com>
	<s5hwr8xdtcd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae9399c89e6bf6304b65628a7
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 66C6E2447F
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 16:11:18 +0100 (CET)
Received: by obbuo13 with SMTP id uo13so857912obb.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 07:11:16 -0800 (PST)
In-Reply-To: <s5hwr8xdtcd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--14dae9399c89e6bf6304b65628a7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12 January 2012 11:59, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 12 Jan 2012 11:51:12 +0000,
> Cefn Hoile wrote:
>>
>> Thanks, Takashi.
>>
>> I don't know what tools and invocations to use test out the GPIO
>> values you describe. I think you're saying I shouldn't bother toggling
>> things through HDA Analyzer as there's nothing obviously wrong in that
>> part of the configuration (as reported by alsa-info.sh which is
>> attached as requested).
>>
>> I noticed in HD-Audio.txt a section which mentions a similar problem
>> and IDT codecs specifically (below). Is there an IRC or mailing list
>> where people could talk me through the basics of trying different
>> GPIO/EAPD, Power Enable or Pin Sense manipulations. I wouldn't know
>> how, yet. If I succeed I'll report back.
>>
>> Hopefully this will be worth it, as I think the N5110 is a pretty
>> popular model with a common card, and probably a bunch of Dell
>> hardware could get fixed if it could be figured out.
>
> You can change the GPIO setup via hda-verb on the fly.
> For example, to set GPIO bit 0, try
> =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x01
> =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x01
> =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01
> where the output direction is assumed, and only GPIO 0 is set.
> For GPIO bit 1,
> =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x02
> =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x02
> =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x02
> and 0x04 for GPIO bit 2. =A0Your device have up to three GPIO bits.
>
> If none of above doesn't any change, try to set DATA 0 instead of 1,
> and/or DIR 0 instead of 1.
>
>
>
> Takashi
>
>> QUOTING FROM HD-Audio.txt >>>>>>>
>>
>> If you are masochistic enough to debug the driver problem, note the
>> following:
>>
>> - The speaker (and the headphone, too) output often requires the
>> =A0 external amplifier. This can be set usually via EAPD verb or a
>> =A0 certain GPIO. If the codec pin supports EAPD, you have a better
>> =A0 chance via SET_EAPD_BTL verb (0x70c). On others, GPIO pin (mostly
>> =A0 it's either GPIO0 or GPIO1) may turn on/off EAPD.
>> - Some Realtek codecs require special vendor-specific coefficients to
>> =A0 turn on the amplifier. See patch_realtek.c.
>> - IDT codecs may have extra power-enable/disable controls on each
>> =A0 analog pin. See patch_sigmatel.c.
>> - Very rare but some devices don't accept the pin-detection verb until
>> =A0 triggered. Issuing GET_PIN_SENSE verb (0xf09) may result in the
>> =A0 codec-communication stall. Some examples are found in
>> =A0 patch_realtek.c.
>>
>> <<<<<<<<
>>
>> On 12 January 2012 11:25, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Thu, 12 Jan 2012 10:56:24 +0000,
>> > Cefn Hoile wrote:
>> >>
>> >> In case anything has changed in my config since the original info run=
,
>> >> here is the same script run right now...
>> >>
>> >> http://www.alsa-project.org/db/?f=3Dd0a1fd23339878916b611c88e64e4868b=
45445ce
>> >
>> > Could you rather attach? =A0Then it'll be archived and searchable.
>> >
>> > Anyway, I don't see any obvious problem in the output.
>> > If the pin assignment is correct, the routing and amp setups should be
>> > OK with the current status.
>> >
>> > Maybe it's a missing GPIO setup. =A0Try to adjust GPIO mask, direction
>> > and value bits.
>> >
>> >
>> > Takashi

I have tried the attached script, which hopefully corresponds with the
GPIO exploration regime you wanted me to try. Please take a look at
the sequence in case there could be some combination I missed based on
trying to interpret your description, or if there's some kind of
reload step I need to do.

When running this GPIO script as...
sudo ./setgpio.sh
...with headphones on my N5110 it plays the sample every time, and
with speakers it is always silent.

Here's an example log of execution...

cefn@cefn-oneiric-dell:~$ sudo ./setgpio.sh
[sudo] password for cefn:
SETTING GPIO 0x01 MASK, DIRECTION AND DATA TO [0x01 0x00 0x00]
nid =3D 0x1, verb =3D 0x716, param =3D 0x1
value =3D 0x0
nid =3D 0x0, verb =3D 0x717, param =3D 0x1
value =3D 0x0
nid =3D 0x0, verb =3D 0x715, param =3D 0x1
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x02 MASK, DIRECTION AND DATA TO [0x01 0x00 0x00]
nid =3D 0x1, verb =3D 0x716, param =3D 0x2
value =3D 0x0
nid =3D 0x0, verb =3D 0x717, param =3D 0x2
value =3D 0x0
nid =3D 0x0, verb =3D 0x715, param =3D 0x2
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x04 MASK, DIRECTION AND DATA TO [0x01 0x00 0x00]
nid =3D 0x1, verb =3D 0x716, param =3D 0x4
value =3D 0x0
nid =3D 0x0, verb =3D 0x717, param =3D 0x4
value =3D 0x0
nid =3D 0x0, verb =3D 0x715, param =3D 0x4
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x01 MASK, DIRECTION AND DATA TO [0x01 0x00 0x01]
nid =3D 0x1, verb =3D 0x716, param =3D 0x1
value =3D 0x0
nid =3D 0x0, verb =3D 0x717, param =3D 0x1
value =3D 0x0
nid =3D 0x1, verb =3D 0x715, param =3D 0x1
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x02 MASK, DIRECTION AND DATA TO [0x01 0x00 0x01]
nid =3D 0x1, verb =3D 0x716, param =3D 0x2
value =3D 0x0
nid =3D 0x0, verb =3D 0x717, param =3D 0x2
value =3D 0x0
nid =3D 0x1, verb =3D 0x715, param =3D 0x2
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x04 MASK, DIRECTION AND DATA TO [0x01 0x00 0x01]
nid =3D 0x1, verb =3D 0x716, param =3D 0x4
value =3D 0x0
nid =3D 0x0, verb =3D 0x717, param =3D 0x4
value =3D 0x0
nid =3D 0x1, verb =3D 0x715, param =3D 0x4
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x01 MASK, DIRECTION AND DATA TO [0x01 0x01 0x00]
nid =3D 0x1, verb =3D 0x716, param =3D 0x1
value =3D 0x0
nid =3D 0x1, verb =3D 0x717, param =3D 0x1
value =3D 0x0
nid =3D 0x0, verb =3D 0x715, param =3D 0x1
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x02 MASK, DIRECTION AND DATA TO [0x01 0x01 0x00]
nid =3D 0x1, verb =3D 0x716, param =3D 0x2
value =3D 0x0
nid =3D 0x1, verb =3D 0x717, param =3D 0x2
value =3D 0x0
nid =3D 0x0, verb =3D 0x715, param =3D 0x2
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x04 MASK, DIRECTION AND DATA TO [0x01 0x01 0x00]
nid =3D 0x1, verb =3D 0x716, param =3D 0x4
value =3D 0x0
nid =3D 0x1, verb =3D 0x717, param =3D 0x4
value =3D 0x0
nid =3D 0x0, verb =3D 0x715, param =3D 0x4
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x01 MASK, DIRECTION AND DATA TO [0x01 0x01 0x01]
nid =3D 0x1, verb =3D 0x716, param =3D 0x1
value =3D 0x0
nid =3D 0x1, verb =3D 0x717, param =3D 0x1
value =3D 0x0
nid =3D 0x1, verb =3D 0x715, param =3D 0x1
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x02 MASK, DIRECTION AND DATA TO [0x01 0x01 0x01]
nid =3D 0x1, verb =3D 0x716, param =3D 0x2
value =3D 0x0
nid =3D 0x1, verb =3D 0x717, param =3D 0x2
value =3D 0x0
nid =3D 0x1, verb =3D 0x715, param =3D 0x2
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
SETTING GPIO 0x04 MASK, DIRECTION AND DATA TO [0x01 0x01 0x01]
nid =3D 0x1, verb =3D 0x716, param =3D 0x4
value =3D 0x0
nid =3D 0x1, verb =3D 0x717, param =3D 0x4
value =3D 0x0
nid =3D 0x1, verb =3D 0x715, param =3D 0x4
value =3D 0x0
Home directory /home/cefn not ours.
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono


Cefn

--14dae9399c89e6bf6304b65628a7
Content-Type: application/x-sh; name="setgpio.sh"
Content-Disposition: attachment; filename="setgpio.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxbx17xa1

IyEvYmluL2Jhc2gKIyBCYXNlZCBvbiBtYWlsIHRvIGFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0Ogoj
IFRha2FzaGkgSXdhaSB0aXdhaUBzdXNlLmRlIHdyb3RlOgojWW91IGNhbiBjaGFuZ2UgdGhlIEdQ
SU8gc2V0dXAgdmlhIGhkYS12ZXJiIG9uIHRoZSBmbHkuCiNGb3IgZXhhbXBsZSwgdG8gc2V0IEdQ
SU8gYml0IDAsIHRyeQojICAgICAgIGhkYS12ZXJiIC9kZXYvc25kL2h3QzBEMCAweDAxIFNFVF9H
UElPX01BU0sgMHgwMQojICAgICAgIGhkYS12ZXJiIC9kZXYvc25kL2h3QzBEMCAweDAxIFNFVF9H
UElPX0RJUiAweDAxCiMgICAgICAgaGRhLXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4MDEgU0VUX0dQ
SU9fREFUQSAweDAxCiN3aGVyZSB0aGUgb3V0cHV0IGRpcmVjdGlvbiBpcyBhc3N1bWVkLCBhbmQg
b25seSBHUElPIDAgaXMgc2V0LgojRm9yIEdQSU8gYml0IDEsCiMgICAgICAgaGRhLXZlcmIgL2Rl
di9zbmQvaHdDMEQwIDB4MDEgU0VUX0dQSU9fTUFTSyAweDAyCiMgICAgICAgaGRhLXZlcmIgL2Rl
di9zbmQvaHdDMEQwIDB4MDEgU0VUX0dQSU9fRElSIDB4MDIKIyAgICAgICBoZGEtdmVyYiAvZGV2
L3NuZC9od0MwRDAgMHgwMSBTRVRfR1BJT19EQVRBIDB4MDIKI2FuZCAweDA0IGZvciBHUElPIGJp
dCAyLiAgWW91ciBkZXZpY2UgaGF2ZSB1cCB0byB0aHJlZSBHUElPIGJpdHMuCiMKI0lmIG5vbmUg
b2YgYWJvdmUgZG9lc24ndCBhbnkgY2hhbmdlLCB0cnkgdG8gc2V0IERBVEEgMCBpbnN0ZWFkIG9m
IDEsCiNhbmQvb3IgRElSIDAgaW5zdGVhZCBvZiAxLgoKaWYgWyAiJChpZCAtdSkiICE9ICIwIiBd
OyB0aGVuCiAgIGVjaG8gIlRoaXMgc2NyaXB0IG11c3QgYmUgcnVuIGFzIHJvb3QiIDE+JjIKICAg
ZXhpdCAxCmZpClRFU1RTQU1QTEU9ImFwbGF5IC91c3Ivc2hhcmUvc291bmRzL2Fsc2EvRnJvbnRf
Q2VudGVyLndhdiIKClRBUkdFVEJJVFM9KCAiMHgwMSIgIjB4MDIiICIweDA0IiApICMgVEhSRUUg
RElGRkVSRU5UIEJJVFMgSU4gTVkgQ0FSRAoKR1BJT01BU0tTPSggIjB4MDEiICkgIyBUSElTIFNU
QVlTIFRSVUUgVEhST1VHSE9VVApHUElPRElSUz0oICIweDAwIiAiMHgwMSIgKSAjIFRSWSBBTEwg
Q09NQklOQVRJT05TIE9GIFRISVMgQk9PTEVBTgpHUElPREFUQVM9KCAiMHgwMCIgIjB4MDEiICkg
IyBUUlkgQUxMIENPTUJJTkFUSU9OUyBPRiBUSElTIEJPT0xFQU4KCmZvciBHUElPTUFTSyBpbiAi
JHtHUElPTUFTS1NbQF19IgpkbwoJZm9yIEdQSU9ESVIgaW4gIiR7R1BJT0RJUlNbQF19IgoJZG8K
CQlmb3IgR1BJT0RBVEEgaW4gIiR7R1BJT0RBVEFTW0BdfSIKCQlkbwoJCQlmb3IgVEFSR0VUQklU
IGluICIke1RBUkdFVEJJVFNbQF19IgoJCQlkbwoJCQkJZWNobyAiU0VUVElORyBHUElPICRUQVJH
RVRCSVQgTUFTSywgRElSRUNUSU9OIEFORCBEQVRBIFRPIFskR1BJT01BU0sgJEdQSU9ESVIgJEdQ
SU9EQVRBXSIJCQkJCgkJCQloZGEtdmVyYiAvZGV2L3NuZC9od0MwRDAgIiRHUElPTUFTSyIgU0VU
X0dQSU9fTUFTSyAiJFRBUkdFVEJJVCIJCQkJCgkJCQloZGEtdmVyYiAvZGV2L3NuZC9od0MwRDAg
IiRHUElPRElSIiBTRVRfR1BJT19ESVIgIiRUQVJHRVRCSVQiCQkJCQoJCQkJaGRhLXZlcmIgL2Rl
di9zbmQvaHdDMEQwICIkR1BJT0RBVEEiIFNFVF9HUElPX0RBVEEgIiRUQVJHRVRCSVQiCgkJCQkk
VEVTVFNBTVBMRQkJCQkKCQkJZG9uZQkJCQoJCWRvbmUJCQoJZG9uZQpkb25lCg==
--14dae9399c89e6bf6304b65628a7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--14dae9399c89e6bf6304b65628a7--
