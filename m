From: Cefn Hoile <alsa-project.org@cefn.com>
Subject: Re: Dell N5110 HDA External Speaker is mute
Date: Thu, 12 Jan 2012 20:07:42 +0000
Message-ID: <CA+P0tC_um-Bohtyc74qAeHv1rHkD11UMn=M5_teFxE+y3ZTvBw@mail.gmail.com>
References: <CA+P0tC_jvOyEsbmZoF5oJZ9k6DA3FRaHCbq+xP3axw+jgLaQ8w@mail.gmail.com>
	<s5h4nw1fbxj.wl%tiwai@suse.de>
	<CA+P0tC_Pnx_JTE7dfiH+PY+hCf-wVsY+vp9H_KVdHpOz5uxgEw@mail.gmail.com>
	<CA+P0tC--i4BDbHrDZRgKuO=sGRw9+q8j_1q2WS1YmUmfpuc91Q@mail.gmail.com>
	<s5h1ur5f9ii.wl%tiwai@suse.de>
	<CA+P0tC_y6QOdgmqSRmMtMvHM+OsMW2mq2325_m8ER4z7Mi6gKQ@mail.gmail.com>
	<s5hwr8xdtcd.wl%tiwai@suse.de>
	<CA+P0tC-O4iffZ-eE_n=Oh4Eweuxs_QGstw9815ZZTitfwyAcGA@mail.gmail.com>
	<s5hvcohc5la.wl%tiwai@suse.de>
	<CA+P0tC8_Ugou+k_anRD6WcsxFqJ4hMHFm5=cvQ2_rJST73ot3A@mail.gmail.com>
	<s5hpqeodhy1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f83a53f08e85c04b65a4d20
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E0F52437F
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 21:07:44 +0100 (CET)
Received: by ghrr11 with SMTP id r11so537494ghr.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 12:07:43 -0800 (PST)
In-Reply-To: <s5hpqeodhy1.wl%tiwai@suse.de>
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

--e89a8f83a53f08e85c04b65a4d20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12 January 2012 16:05, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 12 Jan 2012 16:00:53 +0000,
> Cefn Hoile wrote:
>>
>> On 12 January 2012 15:18, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Thu, 12 Jan 2012 15:11:16 +0000,
>> > Cefn Hoile wrote:
>> >>
>> >> On 12 January 2012 11:59, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > At Thu, 12 Jan 2012 11:51:12 +0000,
>> >> > Cefn Hoile wrote:
>> >> >>
>> >> >> Thanks, Takashi.
>> >> >>
>> >> >> I don't know what tools and invocations to use test out the GPIO
>> >> >> values you describe. I think you're saying I shouldn't bother togg=
ling
>> >> >> things through HDA Analyzer as there's nothing obviously wrong in =
that
>> >> >> part of the configuration (as reported by alsa-info.sh which is
>> >> >> attached as requested).
>> >> >>
>> >> >> I noticed in HD-Audio.txt a section which mentions a similar probl=
em
>> >> >> and IDT codecs specifically (below). Is there an IRC or mailing li=
st
>> >> >> where people could talk me through the basics of trying different
>> >> >> GPIO/EAPD, Power Enable or Pin Sense manipulations. I wouldn't kno=
w
>> >> >> how, yet. If I succeed I'll report back.
>> >> >>
>> >> >> Hopefully this will be worth it, as I think the N5110 is a pretty
>> >> >> popular model with a common card, and probably a bunch of Dell
>> >> >> hardware could get fixed if it could be figured out.
>> >> >
>> >> > You can change the GPIO setup via hda-verb on the fly.
>> >> > For example, to set GPIO bit 0, try
>> >> > =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x01
>> >> > =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x01
>> >> > =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01
>> >> > where the output direction is assumed, and only GPIO 0 is set.
>> >> > For GPIO bit 1,
>> >> > =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x02
>> >> > =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x02
>> >> > =A0 =A0 =A0 =A0hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x02
>> >> > and 0x04 for GPIO bit 2. =A0Your device have up to three GPIO bits.
>> >> >
>> >> > If none of above doesn't any change, try to set DATA 0 instead of 1=
,
>> >> > and/or DIR 0 instead of 1.
>> >> >
>> >> >
>> >> >
>> >> > Takashi
>> >> >
>> >> >> QUOTING FROM HD-Audio.txt >>>>>>>
>> >> >>
>> >> >> If you are masochistic enough to debug the driver problem, note th=
e
>> >> >> following:
>> >> >>
>> >> >> - The speaker (and the headphone, too) output often requires the
>> >> >> =A0 external amplifier. This can be set usually via EAPD verb or a
>> >> >> =A0 certain GPIO. If the codec pin supports EAPD, you have a bette=
r
>> >> >> =A0 chance via SET_EAPD_BTL verb (0x70c). On others, GPIO pin (mos=
tly
>> >> >> =A0 it's either GPIO0 or GPIO1) may turn on/off EAPD.
>> >> >> - Some Realtek codecs require special vendor-specific coefficients=
 to
>> >> >> =A0 turn on the amplifier. See patch_realtek.c.
>> >> >> - IDT codecs may have extra power-enable/disable controls on each
>> >> >> =A0 analog pin. See patch_sigmatel.c.
>> >> >> - Very rare but some devices don't accept the pin-detection verb u=
ntil
>> >> >> =A0 triggered. Issuing GET_PIN_SENSE verb (0xf09) may result in th=
e
>> >> >> =A0 codec-communication stall. Some examples are found in
>> >> >> =A0 patch_realtek.c.
>> >> >>
>> >> >> <<<<<<<<
>> >> >>
>> >> >> On 12 January 2012 11:25, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> > At Thu, 12 Jan 2012 10:56:24 +0000,
>> >> >> > Cefn Hoile wrote:
>> >> >> >>
>> >> >> >> In case anything has changed in my config since the original in=
fo run,
>> >> >> >> here is the same script run right now...
>> >> >> >>
>> >> >> >> http://www.alsa-project.org/db/?f=3Dd0a1fd23339878916b611c88e64=
e4868b45445ce
>> >> >> >
>> >> >> > Could you rather attach? =A0Then it'll be archived and searchabl=
e.
>> >> >> >
>> >> >> > Anyway, I don't see any obvious problem in the output.
>> >> >> > If the pin assignment is correct, the routing and amp setups sho=
uld be
>> >> >> > OK with the current status.
>> >> >> >
>> >> >> > Maybe it's a missing GPIO setup. =A0Try to adjust GPIO mask, dir=
ection
>> >> >> > and value bits.
>> >> >> >
>> >> >> >
>> >> >> > Takashi
>> >>
>> >> I have tried the attached script, which hopefully corresponds with th=
e
>> >> GPIO exploration regime you wanted me to try. Please take a look at
>> >> the sequence in case there could be some combination I missed based o=
n
>> >> trying to interpret your description, or if there's some kind of
>> >> reload step I need to do.
>> >
>> > Yeah, there are some bugs :)
>> > The combination should be (mask/dir/data)
>> > 1/1/0 1/1/1 1/0/0 1/0/1
>> > 2/2/0 2/2/2 2/0/0 2/0/2
>> > 4/4/0 4/4/4 4/0/0 4/0/4
>> >
>> > Also, as a test, use aplay with -Dplughw option.
>> > This skips PA and others.
>> >
>> >
>> > Takashi
>> >
>> >> When running this GPIO script as...
>> >> sudo ./setgpio.sh
>> >> ...with headphones on my N5110 it plays the sample every time, and
>> >> with speakers it is always silent.
>> >>
>> >> Here's an example log of execution...
>> >>
>> >> cefn@cefn-oneiric-dell:~$ sudo ./setgpio.sh
>> >> [sudo] password for cefn:
>> >> SETTING GPIO 0x01 MASK, DIRECTION AND DATA TO [0x01 0x00 0x00]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x1
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x717, param =3D 0x1
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x715, param =3D 0x1
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x02 MASK, DIRECTION AND DATA TO [0x01 0x00 0x00]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x2
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x717, param =3D 0x2
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x715, param =3D 0x2
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x04 MASK, DIRECTION AND DATA TO [0x01 0x00 0x00]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x4
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x717, param =3D 0x4
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x715, param =3D 0x4
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x01 MASK, DIRECTION AND DATA TO [0x01 0x00 0x01]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x1
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x717, param =3D 0x1
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x715, param =3D 0x1
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x02 MASK, DIRECTION AND DATA TO [0x01 0x00 0x01]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x2
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x717, param =3D 0x2
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x715, param =3D 0x2
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x04 MASK, DIRECTION AND DATA TO [0x01 0x00 0x01]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x4
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x717, param =3D 0x4
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x715, param =3D 0x4
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x01 MASK, DIRECTION AND DATA TO [0x01 0x01 0x00]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x1
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x717, param =3D 0x1
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x715, param =3D 0x1
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x02 MASK, DIRECTION AND DATA TO [0x01 0x01 0x00]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x2
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x717, param =3D 0x2
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x715, param =3D 0x2
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x04 MASK, DIRECTION AND DATA TO [0x01 0x01 0x00]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x4
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x717, param =3D 0x4
>> >> value =3D 0x0
>> >> nid =3D 0x0, verb =3D 0x715, param =3D 0x4
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x01 MASK, DIRECTION AND DATA TO [0x01 0x01 0x01]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x1
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x717, param =3D 0x1
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x715, param =3D 0x1
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x02 MASK, DIRECTION AND DATA TO [0x01 0x01 0x01]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x2
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x717, param =3D 0x2
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x715, param =3D 0x2
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >> SETTING GPIO 0x04 MASK, DIRECTION AND DATA TO [0x01 0x01 0x01]
>> >> nid =3D 0x1, verb =3D 0x716, param =3D 0x4
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x717, param =3D 0x4
>> >> value =3D 0x0
>> >> nid =3D 0x1, verb =3D 0x715, param =3D 0x4
>> >> value =3D 0x0
>> >> Home directory /home/cefn not ours.
>> >> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bi=
t
>> >> Little Endian, Rate 48000 Hz, Mono
>> >>
>> >>
>> >> Cefn
>>
>> Thanks again for your patience. It would be really useful if you could
>> suggest a specific change to the section of my script which details
>> the alternates, unless my script is more conceptually broken than
>> that. That way I can't misinterpret which of the flags you're trying
>> to describe with words. The problem I have looking at your "1/1/0"
>> list is which arguments of the actual hda-verb command to bind them
>> to: there are actually 4 values to vary in my mind. Three lines are
>> executed as a block for every possible combination of values in my
>> script (in the center of the nested loops)...
>>
>> hda-verb /dev/snd/hwC0D0 "$GPIOMASK" SET_GPIO_MASK "$TARGETBIT"
>> hda-verb /dev/snd/hwC0D0 "$GPIODIR" SET_GPIO_DIR "$TARGETBIT"
>> hda-verb /dev/snd/hwC0D0 "$GPIODATA" SET_GPIO_DATA "$TARGETBIT"
>>
>> .... that is, GPIOMASK, GPIODIR, GPIODATA AND TARGETBIT. Your response
>> details only 3 values, so what do I do with TARGETBIT, or is it
>> identical to something else?.
>
> No, the the first argument after /dev/snd/hwC0D0 is always 0x01.
> It's the AFG node id which the GPIO is always bound to. =A0Only the last
> value, i.e. the parameter to the exected verb, is changed.
>
>
> Takashi

OK. I'm now running the attached script which I think is exploring the
correct configuration space. Worth taking a look at the steps in there
to be sure I'm not doing something stupid, though.

I still have no speaker sound for any of the combinations of GPIO
flags. I'm not rebooting to try each combination, as I'm assuming
these are flags which can change at runtime and Alsa will pick them
up.

If I've properly explored all the GPIO combinations, what's next to
try? The HDA documentation suggests something to do with powering
pins, and something else to do with pin sensing. I'm not 100% on how I
could control these, although the HDA Analyzer exposes some checkboxes
and sliders which so far have achieved no sound as I wiggled them
randomly.

Cefn
http://cefn.com

--e89a8f83a53f08e85c04b65a4d20
Content-Type: application/x-sh; name="setgpio.sh"
Content-Disposition: attachment; filename="setgpio.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxc7e0wd0

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
ZXhpdCAxCmZpClRFU1RTQU1QTEU9ImFwbGF5IC1EcGx1Z2h3IC91c3Ivc2hhcmUvc291bmRzL2Fs
c2EvRnJvbnRfQ2VudGVyLndhdiIKCiMgVFJZIEFMTCBDT01CSU5BVElPTlMgT0YKQklUUz0oIjB4
MDEiICIweDAyIiAiMHgwNCIpCkdQSU9NQVNLUz0oIHRydWUgKQpHUElPRElSUz0oIGZhbHNlIHRy
dWUgKQpHUElPREFUQVM9KCBmYWxzZSB0cnVlICkKCmZvciBCSVQgaW4gIiR7QklUU1tAXX0iCmRv
Cglmb3IgR1BJT01BU0sgaW4gIiR7R1BJT01BU0tTW0BdfSIKCWRvCgkJZm9yIEdQSU9ESVIgaW4g
IiR7R1BJT0RJUlNbQF19IgoJCWRvCgkJCWZvciBHUElPREFUQSBpbiAiJHtHUElPREFUQVNbQF19
IgoJCQlkbwoJCQkJZWNobyAiU0VUR1BJTzogU0VUVElORyAkQklUIE1BU0ssIERJUkVDVElPTiBB
TkQgREFUQSBUTyBbJEdQSU9NQVNLICRHUElPRElSICRHUElPREFUQV0iCgkJCQlpZiAkR1BJT01B
U0sgOyB0aGVuCgkJCQkJaGRhLXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4MDEgU0VUX0dQSU9fTUFT
SyAiJEJJVCIKCQkJCWVsc2UKCQkJCQloZGEtdmVyYiAvZGV2L3NuZC9od0MwRDAgMHgwMSBTRVRf
R1BJT19NQVNLIDB4MDAKCQkJCWZpCgkJCQlpZiAkR1BJT0RJUiA7IHRoZW4KCQkJCQloZGEtdmVy
YiAvZGV2L3NuZC9od0MwRDAgMHgwMSBTRVRfR1BJT19ESVIgIiRCSVQiCgkJCQllbHNlCgkJCQkJ
aGRhLXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4MDEgU0VUX0dQSU9fRElSIDB4MDAKCQkJCWZpCgkJ
CQlpZiAkR1BJT0RBVEEgOyB0aGVuCgkJCQkJaGRhLXZlcmIgL2Rldi9zbmQvaHdDMEQwIDB4MDEg
U0VUX0dQSU9fREFUQSAiJEJJVCIKCQkJCWVsc2UKCQkJCQloZGEtdmVyYiAvZGV2L3NuZC9od0Mw
RDAgMHgwMSBTRVRfR1BJT19EQVRBIDB4MDAKCQkJCWZpCgkJCQkkVEVTVFNBTVBMRQkJCQkKCQkJ
ZG9uZQkJCgkJZG9uZQoJZG9uZQpkb25lCgoK
--e89a8f83a53f08e85c04b65a4d20
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--e89a8f83a53f08e85c04b65a4d20--
