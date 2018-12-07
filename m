From: Kailang <kailang@realtek.com>
Subject: Re: HDA headset button support
Date: Fri, 7 Dec 2018 07:32:43 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1842027F@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1841FAEF@RTITMBSV02.realtek.com.tw>
 <s5ho9a9uwkr.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1841FB60@RTITMBSV02.realtek.com.tw>
 <s5hftvk49ag.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1841FB90@RTITMBSV02.realtek.com.tw>
 <s5hd0qo47ax.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1841FC1F@RTITMBSV02.realtek.com.tw>
 <s5hr2eywovh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_003_6FAB7C47BCF00940BB0999A99BE3547A1842027FRTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 715F1267CED
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 08:32:45 +0100 (CET)
In-Reply-To: <s5hr2eywovh.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_003_6FAB7C47BCF00940BB0999A99BE3547A1842027FRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Intel Chrome team agree the patch and test passed.
I told them, it didn't need to show the headphone and MIC present event in =
BTN key function.
Patch for patch_realtek.c that I change the COEF index 0x48's value to 0xd0=
11. Please use attach 0003-* to apply. Thanks.
So, it could apply it to upstream now.

+	case HDA_FIXUP_ACT_INIT:
+		switch (codec->core.vendor_id) {
+		case 0x10ec0225:
+		case 0x10ec0295:
+		case 0x10ec0299:
+			alc_write_coef_idx(codec, 0x48, 0xd011);
+			alc_update_coef_idx(codec, 0x49, 0x007f, 0x0045);
+			alc_update_coef_idx(codec, 0x44, 0x007f << 8, 0x0045 << 8);
+			break;
+		case 0x10ec0236:
+		case 0x10ec0256:
+			alc_write_coef_idx(codec, 0x48, 0xd011);
+			alc_update_coef_idx(codec, 0x49, 0x007f, 0x0045);
+			break;
+		}
+		break;
+	}

BR,
Kailang

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Tuesday, December 4, 2018 12:34 AM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: HDA headset button support

On Fri, 30 Nov 2018 07:45:04 +0100,
Kailang wrote:
>=20
> Hi Takashi,
>=20
> Intel say .... it was not show headset plug and unplug.
> Is that necessary to show headphone and MIC plug and unplug {Event type 5=
 (EV_SW)}?

If so, it means that the unsol events aren't set up for the proper pins.


Takashi


> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 114 (KEY_VOLUMEDOWN)
>     Event code 115 (KEY_VOLUMEUP)
>     Event code 164 (KEY_PLAYPAUSE)
>     Event code 582 (?)
>   Event type 5 (EV_SW)
>     Event code 2 (SW_HEADPHONE_INSERT)
>     Event code 4 (SW_MICROPHONE_INSERT)
> Properties:
> Testing ... (interrupt to exit)
> ***Following block of events is for one single event: pressing one of=20
> the buttons on headset***
> Event: time 1543528786.148227, type 1 (EV_KEY), code 115=20
> (KEY_VOLUMEUP), value 1
> Event: time 1543528786.148227, -------------- SYN_REPORT ------------
> Event: time 1543528786.148249, type 1 (EV_KEY), code 115=20
> (KEY_VOLUMEUP), value 0
> Event: time 1543528786.148249, -------------- SYN_REPORT ------------=20
> ***No events show on evtest when plug or unplug jack***
>=20
> BR,
> Kailang
>=20
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Thursday, November 29, 2018 4:28 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: HDA headset button support
>=20
> On Thu, 29 Nov 2018 09:21:51 +0100,
> Kailang wrote:
> >=20
> > Hi Takashi,
> >=20
> > It looks no issue now.
> > Could I need to generate new patch for you?
>=20
> You can fold into mine.  I'll need to resubmit to ML in anyway before mer=
ging.
>=20
> > I will send this patch to Intel to do the test.
>=20
> OK, let me know the results (and preferably tested-by tag or such).
>=20
>=20
> thanks,
>=20
> Takashi
>=20
>=20
> >=20
> > BR,
> > Kailang
> >=20
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Thursday, November 29, 2018 3:45 PM
> > To: Kailang <kailang@realtek.com>
> > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > Subject: Re: HDA headset button support
> >=20
> > On Thu, 29 Nov 2018 08:22:39 +0100,
> > Kailang wrote:
> > >=20
> > > Hi Takashi,
> > >=20
> > > I test the patch.
> > > It will go to Max or Min volume when I press HS button up or down.
> > >=20
> > > +			state =3D jack->button_state;
> > > +			if (get_jack_plug_state(jack->pin_sense))
> > > +				state |=3D jack->type;
> > > +			snd_jack_report(jack->jack, state);
> > > 			If (jack->nid =3D=3D 0x55)
> > > 				snd_jack_report(jack->jack, 0); =3D=3D> Add this will solve keep =
volume up and down.
> > >=20
> > > If the pin sense active, it will update Mic and Headphone state.=20
> > > (Upper code) But it still had chance to update 0x55 during unplug and=
 plug state.
> > > So, Maybe need to clear the Button state. I guess.
> >=20
> > As we don't receive button-release events, it makes sense to send the b=
utton clear at each time, yes.
> >=20
> > For the one-shot button event, you can handle like below.
> >=20
> > --- a/sound/pci/hda/hda_jack.c
> > +++ b/sound/pci/hda/hda_jack.c
> > @@ -343,6 +343,11 @@ void snd_hda_jack_report_sync(struct hda_codec *co=
dec)
> >  			if (get_jack_plug_state(jack->pin_sense))
> >  				state |=3D jack->type;
> >  			snd_jack_report(jack->jack, state);
> > +			if (jack->button_state) {
> > +				snd_jack_report(jack->jack,
> > +						state & ~jack->button_state);
> > +				jack->button_state =3D 0; /* button released */
> > +			}
> >  		}
> >  }
> >  EXPORT_SYMBOL_GPL(snd_hda_jack_report_sync);
> >=20
> >=20
> > thanks,
> >=20
> > Takashi
> >=20
> > >=20
> > > BR,
> > > Kailang
> > >=20
> > > -----Original Message-----
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Sent: Wednesday, November 28, 2018 10:05 PM
> > > To: Kailang <kailang@realtek.com>
> > > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > > Subject: Re: HDA headset button support
> > >=20
> > > On Wed, 28 Nov 2018 13:03:58 +0100, Kailang wrote:
> > > >=20
> > > > Hi Takashi,
> > > >=20
> > > > >I'd rather like to extend snd_hda_jack_add_kctl() with the key=20
> > > > >support (maybe adding a new function).  You can pass there the=20
> > > > >combination of SND_JACK_BTN_X with KEY_XXX in an array.
> > > >=20
> > > > Do you mean create new function like below?
> > > > snd_hda_jack_add_key_kctl()
> > > >=20
> > > > It couldn't use snd_hda_jack_add_kctl() directly.
> > > > Because it had report pin state and get type from NID.
> > > >=20
> > > > 	type =3D get_input_jack_type(codec, nid);
> > > >         .....
> > > >         .....
> > > >  	state =3D snd_hda_jack_detect(codec, nid);
> > > > 	snd_jack_report(jack->jack, state ? jack->type : 0);
> > > >=20
> > > > So, to create a new function in hda_jack.c was better.
> > >=20
> > > Well, this seems more deeper than I thought.
> > >=20
> > > Below is my quick attempt to add the infrastructure.  This adds more =
flexibility but still easiness for other possible button implementations, h=
opefully.
> > >=20
> > > Could you check the series below?
> > >=20
> > >=20
> > > thanks,
> > >=20
> > > Takashi
> > >=20
> > >=20
> > > ------Please consider the environment before printing this e-mail.
> > >=20
> >=20
>=20

--_003_6FAB7C47BCF00940BB0999A99BE3547A1842027FRTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0001-ALSA-hda-jack-button-support.patch"
Content-Description: 0001-ALSA-hda-jack-button-support.patch
Content-Disposition: attachment;
	filename="0001-ALSA-hda-jack-button-support.patch"; size=7240;
	creation-date="Thu, 29 Nov 2018 08:54:19 GMT";
	modification-date="Thu, 29 Nov 2018 09:00:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NGQyMTg5ODE1YTg4NjJkNGQxODRiY2FiYzIxNDEwMzkzNjU1M2M5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+CkRhdGU6IFRo
dSwgMjkgTm92IDIwMTggMTY6NDQ6MzEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNBOiBoZGEg
LSBBZGQgamFjayBidXR0b24gc3VwcG9ydAoKRm9yIGFsbG93aW5nIHRoZSBjYWxsZWUgdG8gZXZh
bHVhdGUgdGhlIGFzc29jaWF0ZWQgamFjayBpbmZvcm1hdGlvbgphbmQgdGhlIHVuc29saWNpdGVk
IGV2ZW50IGRhdGEsIGFkZCB0aGUgbmV3IGZpZWxkcyB0bwpoZGFfamFja19jYWxsYmFjay4gIFRo
ZXkgY2FuIGJlIHVzZWQsIGZvciBleGFtcGxlLCB0byByZXRyaWV2ZSB0aGUKaGVhZHNldCBidXR0
b24gc3RhdGUgaW4gdGhlIGNhbGxiYWNrLgoKRXh0ZW5kIHNvbWUgc3RydWN0cyB0byBhZGQgdGhl
IHN1cHBvcnQgZm9yIGphY2sgYnV0dG9uIGNoYW5nZXMuCk5vdyBzbmRfaGRhX2phY2tfYWRkX2tj
dGwoKSByZWNlaXZlcyB0d28gbW9yZSBhcmd1bWVudHM6IHRoZSBqYWNrIHR5cGUKYW5kIHRoZSBq
YWNrIGtleW1hcHMuICBCb3RoIGFyZSBvcHRpb25hbCwgYW5kIHdoZW4gemVybyBhcmUgcGFzc2Vk
LAp0aGUgZnVuY3Rpb24gYmVoYXZlcyBqdXN0IGxpa2UgYmVmb3JlLgoKRm9yIHJlcG9ydGluZyBi
dXR0b24gc3RhdGUgY2hhbmdlcywgeW91J2QgbmVlZCB0byB1cGRhdGUKamFjay0+YnV0dG9uX3N0
YXRlIGJpdHMgYWNjb3JkaW5nbHksIHR5cGljYWxseSBpbiB0aGUgamFjayBjYWxsYmFjay4KVGhl
biB0aGUgdmFsdWUgT1InZWQgd2l0aCBidXR0b25fc3RhdGUgYW5kIHRoZSBqYWNrIHBsdWcgc3Rh
dGUgaXMKcGFzc2VkIHRvIHNuZF9qYWNrX3JlcG9ydCgpLgoKU2lnbmVkLW9mZi1ieTogVGFrYXNo
aSBJd2FpIDx0aXdhaUBzdXNlLmRlPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ph
Y2suYyBiL3NvdW5kL3BjaS9oZGEvaGRhX2phY2suYwppbmRleCBjNDk5NzI3Li43NGI0Njk1IDEw
MDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9qYWNrLmMKKysrIGIvc291bmQvcGNpL2hkYS9o
ZGFfamFjay5jCkBAIC0zMzksOSArMzM5LDE1IEBAIHZvaWQgc25kX2hkYV9qYWNrX3JlcG9ydF9z
eW5jKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCQlpZiAoamFjay0+bmlkKSB7CiAJCQlpZiAo
IWphY2stPmphY2sgfHwgamFjay0+YmxvY2tfcmVwb3J0KQogCQkJCWNvbnRpbnVlOwotCQkJc3Rh
dGUgPSBnZXRfamFja19wbHVnX3N0YXRlKGphY2stPnBpbl9zZW5zZSk7Ci0JCQlzbmRfamFja19y
ZXBvcnQoamFjay0+amFjaywKLQkJCQkJc3RhdGUgPyBqYWNrLT50eXBlIDogMCk7CisJCQlzdGF0
ZSA9IGphY2stPmJ1dHRvbl9zdGF0ZTsKKwkJCWlmIChnZXRfamFja19wbHVnX3N0YXRlKGphY2st
PnBpbl9zZW5zZSkpCisJCQkJc3RhdGUgfD0gamFjay0+dHlwZTsKKwkJCXNuZF9qYWNrX3JlcG9y
dChqYWNrLT5qYWNrLCBzdGF0ZSk7CisJCQlpZiAoamFjay0+YnV0dG9uX3N0YXRlKSB7CisJCQkJ
c25kX2phY2tfcmVwb3J0KGphY2stPmphY2ssCisJCQkJCQlzdGF0ZSAmIH5qYWNrLT5idXR0b25f
c3RhdGUpOworCQkJCWphY2stPmJ1dHRvbl9zdGF0ZSA9IDA7IC8qIGJ1dHRvbiByZWxlYXNlZCAq
LworCQkJfQogCQl9CiB9CiBFWFBPUlRfU1lNQk9MX0dQTChzbmRfaGRhX2phY2tfcmVwb3J0X3N5
bmMpOwpAQCAtMzc5LDE1ICszODUsMTkgQEAgc3RhdGljIHZvaWQgaGRhX2ZyZWVfamFja19wcml2
KHN0cnVjdCBzbmRfamFjayAqamFjaykKICAqIEBuaWQ6IHBpbiBOSUQgdG8gYXNzaWduCiAgKiBA
bmFtZTogc3RyaW5nIG5hbWUgZm9yIHRoZSBqYWNrCiAgKiBAcGhhbnRvbV9qYWNrOiBmbGFnIHRv
IGRlYWwgYXMgYSBwaGFudG9tIGphY2sKKyAqIEB0eXBlOiBqYWNrIHR5cGUgYml0cyB0byBiZSBy
ZXBvcnRlZCwgMCBmb3IgZ3Vlc3NpbmcgZnJvbSBwaW5jZmcKKyAqIEBrZXltYXA6IG9wdGlvbmFs
IGphY2sgLyBrZXkgbWFwcGluZwogICoKICAqIFRoaXMgYXNzaWducyBhIGphY2stZGV0ZWN0aW9u
IGtjdGwgdG8gdGhlIGdpdmVuIHBpbi4gIFRoZSBrY29udHJvbAogICogd2lsbCBoYXZlIHRoZSBn
aXZlbiBuYW1lIGFuZCBpbmRleC4KICAqLwogaW50IHNuZF9oZGFfamFja19hZGRfa2N0bChzdHJ1
Y3QgaGRhX2NvZGVjICpjb2RlYywgaGRhX25pZF90IG5pZCwKLQkJCSAgY29uc3QgY2hhciAqbmFt
ZSwgYm9vbCBwaGFudG9tX2phY2spCisJCQkgIGNvbnN0IGNoYXIgKm5hbWUsIGJvb2wgcGhhbnRv
bV9qYWNrLAorCQkJICBpbnQgdHlwZSwgY29uc3Qgc3RydWN0IGhkYV9qYWNrX2tleW1hcCAqa2V5
bWFwKQogewogCXN0cnVjdCBoZGFfamFja190YmwgKmphY2s7Ci0JaW50IGVyciwgc3RhdGUsIHR5
cGU7CisJY29uc3Qgc3RydWN0IGhkYV9qYWNrX2tleW1hcCAqbWFwOworCWludCBlcnIsIHN0YXRl
LCBidXR0b25zOwogCiAJamFjayA9IHNuZF9oZGFfamFja190YmxfbmV3KGNvZGVjLCBuaWQpOwog
CWlmICghamFjaykKQEAgLTM5NSwxNiArNDA1LDMwIEBAIGludCBzbmRfaGRhX2phY2tfYWRkX2tj
dGwoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIGhkYV9uaWRfdCBuaWQsCiAJaWYgKGphY2stPmph
Y2spCiAJCXJldHVybiAwOyAvKiBhbHJlYWR5IGNyZWF0ZWQgKi8KIAotCXR5cGUgPSBnZXRfaW5w
dXRfamFja190eXBlKGNvZGVjLCBuaWQpOwotCWVyciA9IHNuZF9qYWNrX25ldyhjb2RlYy0+Y2Fy
ZCwgbmFtZSwgdHlwZSwKKwlpZiAoIXR5cGUpCisJCXR5cGUgPSBnZXRfaW5wdXRfamFja190eXBl
KGNvZGVjLCBuaWQpOworCisJYnV0dG9ucyA9IDA7CisJaWYgKGtleW1hcCkgeworCQlmb3IgKG1h
cCA9IGtleW1hcDsgbWFwLT50eXBlOyBtYXArKykKKwkJCWJ1dHRvbnMgfD0gbWFwLT50eXBlOwor
CX0KKworCWVyciA9IHNuZF9qYWNrX25ldyhjb2RlYy0+Y2FyZCwgbmFtZSwgdHlwZSB8IGJ1dHRv
bnMsCiAJCQkgICAmamFjay0+amFjaywgdHJ1ZSwgcGhhbnRvbV9qYWNrKTsKIAlpZiAoZXJyIDwg
MCkKIAkJcmV0dXJuIGVycjsKIAogCWphY2stPnBoYW50b21famFjayA9ICEhcGhhbnRvbV9qYWNr
OwogCWphY2stPnR5cGUgPSB0eXBlOworCWphY2stPmJ1dHRvbl9zdGF0ZSA9IDA7CiAJamFjay0+
amFjay0+cHJpdmF0ZV9kYXRhID0gamFjazsKIAlqYWNrLT5qYWNrLT5wcml2YXRlX2ZyZWUgPSBo
ZGFfZnJlZV9qYWNrX3ByaXY7CisJaWYgKGtleW1hcCkgeworCQlmb3IgKG1hcCA9IGtleW1hcDsg
bWFwLT50eXBlOyBtYXArKykKKwkJCXNuZF9qYWNrX3NldF9rZXkoamFjay0+amFjaywgbWFwLT50
eXBlLCBtYXAtPmtleSk7CisJfQorCiAJc3RhdGUgPSBzbmRfaGRhX2phY2tfZGV0ZWN0KGNvZGVj
LCBuaWQpOwogCXNuZF9qYWNrX3JlcG9ydChqYWNrLT5qYWNrLCBzdGF0ZSA/IGphY2stPnR5cGUg
OiAwKTsKIApAQCAtNDM3LDcgKzQ2MSw3IEBAIHN0YXRpYyBpbnQgYWRkX2phY2tfa2N0bChzdHJ1
Y3QgaGRhX2NvZGVjICpjb2RlYywgaGRhX25pZF90IG5pZCwKIAlpZiAocGhhbnRvbV9qYWNrKQog
CQkvKiBFeGFtcGxlIGZpbmFsIG5hbWU6ICJJbnRlcm5hbCBNaWMgUGhhbnRvbSBKYWNrIiAqLwog
CQlzdHJuY2F0KG5hbWUsICIgUGhhbnRvbSIsIHNpemVvZihuYW1lKSAtIHN0cmxlbihuYW1lKSAt
IDEpOwotCWVyciA9IHNuZF9oZGFfamFja19hZGRfa2N0bChjb2RlYywgbmlkLCBuYW1lLCBwaGFu
dG9tX2phY2spOworCWVyciA9IHNuZF9oZGFfamFja19hZGRfa2N0bChjb2RlYywgbmlkLCBuYW1l
LCBwaGFudG9tX2phY2ssIDAsIE5VTEwpOwogCWlmIChlcnIgPCAwKQogCQlyZXR1cm4gZXJyOwog
CkBAIC01MDgsMTkgKzUzMiwyNSBAQCBpbnQgc25kX2hkYV9qYWNrX2FkZF9rY3RscyhzdHJ1Y3Qg
aGRhX2NvZGVjICpjb2RlYywKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKHNuZF9oZGFfamFja19hZGRf
a2N0bHMpOwogCi1zdGF0aWMgdm9pZCBjYWxsX2phY2tfY2FsbGJhY2soc3RydWN0IGhkYV9jb2Rl
YyAqY29kZWMsCitzdGF0aWMgdm9pZCBjYWxsX2phY2tfY2FsbGJhY2soc3RydWN0IGhkYV9jb2Rl
YyAqY29kZWMsIHVuc2lnbmVkIGludCByZXMsCiAJCQkgICAgICAgc3RydWN0IGhkYV9qYWNrX3Ri
bCAqamFjaykKIHsKIAlzdHJ1Y3QgaGRhX2phY2tfY2FsbGJhY2sgKmNiOwogCi0JZm9yIChjYiA9
IGphY2stPmNhbGxiYWNrOyBjYjsgY2IgPSBjYi0+bmV4dCkKKwlmb3IgKGNiID0gamFjay0+Y2Fs
bGJhY2s7IGNiOyBjYiA9IGNiLT5uZXh0KSB7CisJCWNiLT5qYWNrID0gamFjazsKKwkJY2ItPnVu
c29sX3JlcyA9IHJlczsKIAkJY2ItPmZ1bmMoY29kZWMsIGNiKTsKKwl9CiAJaWYgKGphY2stPmdh
dGVkX2phY2spIHsKIAkJc3RydWN0IGhkYV9qYWNrX3RibCAqZ2F0ZWQgPQogCQkJc25kX2hkYV9q
YWNrX3RibF9nZXQoY29kZWMsIGphY2stPmdhdGVkX2phY2spOwogCQlpZiAoZ2F0ZWQpIHsKLQkJ
CWZvciAoY2IgPSBnYXRlZC0+Y2FsbGJhY2s7IGNiOyBjYiA9IGNiLT5uZXh0KQorCQkJZm9yIChj
YiA9IGdhdGVkLT5jYWxsYmFjazsgY2I7IGNiID0gY2ItPm5leHQpIHsKKwkJCQljYi0+amFjayA9
IGdhdGVkOworCQkJCWNiLT51bnNvbF9yZXMgPSByZXM7CiAJCQkJY2ItPmZ1bmMoY29kZWMsIGNi
KTsKKwkJCX0KIAkJfQogCX0KIH0KQEAgLTU0MCw3ICs1NzAsNyBAQCB2b2lkIHNuZF9oZGFfamFj
a191bnNvbF9ldmVudChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywgdW5zaWduZWQgaW50IHJlcykK
IAkJcmV0dXJuOwogCWV2ZW50LT5qYWNrX2RpcnR5ID0gMTsKIAotCWNhbGxfamFja19jYWxsYmFj
ayhjb2RlYywgZXZlbnQpOworCWNhbGxfamFja19jYWxsYmFjayhjb2RlYywgcmVzLCBldmVudCk7
CiAJc25kX2hkYV9qYWNrX3JlcG9ydF9zeW5jKGNvZGVjKTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BM
KHNuZF9oZGFfamFja191bnNvbF9ldmVudCk7CkBAIC01NjYsNyArNTk2LDcgQEAgdm9pZCBzbmRf
aGRhX2phY2tfcG9sbF9hbGwoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJCWlmIChvbGRfc2Vu
c2UgPT0gZ2V0X2phY2tfcGx1Z19zdGF0ZShqYWNrLT5waW5fc2Vuc2UpKQogCQkJY29udGludWU7
CiAJCWNoYW5nZXMgPSAxOwotCQljYWxsX2phY2tfY2FsbGJhY2soY29kZWMsIGphY2spOworCQlj
YWxsX2phY2tfY2FsbGJhY2soY29kZWMsIDAsIGphY2spOwogCX0KIAlpZiAoY2hhbmdlcykKIAkJ
c25kX2hkYV9qYWNrX3JlcG9ydF9zeW5jKGNvZGVjKTsKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9o
ZGEvaGRhX2phY2suaCBiL3NvdW5kL3BjaS9oZGEvaGRhX2phY2suaAppbmRleCBlOTgxNGMwLi4x
ZDcxMzIwIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9qYWNrLmgKKysrIGIvc291bmQv
cGNpL2hkYS9oZGFfamFjay5oCkBAIC0xMyw2ICsxMyw3IEBACiAjZGVmaW5lIF9fU09VTkRfSERB
X0pBQ0tfSAogCiAjaW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5jbHVkZSA8c291bmQvamFjay5o
PgogCiBzdHJ1Y3QgYXV0b19waW5fY2ZnOwogc3RydWN0IGhkYV9qYWNrX3RibDsKQEAgLTI0LDYg
KzI1LDggQEAgc3RydWN0IGhkYV9qYWNrX2NhbGxiYWNrIHsKIAloZGFfbmlkX3QgbmlkOwogCWhk
YV9qYWNrX2NhbGxiYWNrX2ZuIGZ1bmM7CiAJdW5zaWduZWQgaW50IHByaXZhdGVfZGF0YTsJLyog
YXJiaXRyYXJ5IGRhdGEgKi8KKwl1bnNpZ25lZCBpbnQgdW5zb2xfcmVzOwkJLyogdW5zb2xpY2l0
ZWQgZXZlbnQgYml0cyAqLworCXN0cnVjdCBoZGFfamFja190YmwgKmphY2s7CS8qIGFzc29jaWF0
ZWQgamFjayBlbnRyeSAqLwogCXN0cnVjdCBoZGFfamFja19jYWxsYmFjayAqbmV4dDsKIH07CiAK
QEAgLTQwLDkgKzQzLDE1IEBAIHN0cnVjdCBoZGFfamFja190YmwgewogCWhkYV9uaWRfdCBnYXRp
bmdfamFjazsJCS8qIHZhbGlkIHdoZW4gZ2F0aW5nIGphY2sgcGx1Z2dlZCAqLwogCWhkYV9uaWRf
dCBnYXRlZF9qYWNrOwkJLyogZ2F0ZWQgaXMgZGVwZW5kZW50IG9uIHRoaXMgamFjayAqLwogCWlu
dCB0eXBlOworCWludCBidXR0b25fc3RhdGU7CiAJc3RydWN0IHNuZF9qYWNrICpqYWNrOwogfTsK
IAorc3RydWN0IGhkYV9qYWNrX2tleW1hcCB7CisJZW51bSBzbmRfamFja190eXBlcyB0eXBlOwor
CWludCBrZXk7Cit9OworCiBzdHJ1Y3QgaGRhX2phY2tfdGJsICoKIHNuZF9oZGFfamFja190Ymxf
Z2V0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLCBoZGFfbmlkX3QgbmlkKTsKIHN0cnVjdCBoZGFf
amFja190YmwgKgpAQCAtODIsNyArOTEsOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgc25kX2hkYV9q
YWNrX2RldGVjdChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywgaGRhX25pZF90IG5pZCkKIGJvb2wg
aXNfamFja19kZXRlY3RhYmxlKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLCBoZGFfbmlkX3Qgbmlk
KTsKIAogaW50IHNuZF9oZGFfamFja19hZGRfa2N0bChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywg
aGRhX25pZF90IG5pZCwKLQkJCSAgY29uc3QgY2hhciAqbmFtZSwgYm9vbCBwaGFudG9tX2phY2sp
OworCQkJICBjb25zdCBjaGFyICpuYW1lLCBib29sIHBoYW50b21famFjaywKKwkJCSAgaW50IHR5
cGUsIGNvbnN0IHN0cnVjdCBoZGFfamFja19rZXltYXAgKmtleW1hcCk7CiBpbnQgc25kX2hkYV9q
YWNrX2FkZF9rY3RscyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAkJCSAgIGNvbnN0IHN0cnVj
dCBhdXRvX3Bpbl9jZmcgKmNmZyk7CiAKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
aGRtaS5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMKaW5kZXggNjcwOTljYi4uYzI5OTBk
YSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMKKysrIGIvc291bmQvcGNp
L2hkYS9wYXRjaF9oZG1pLmMKQEAgLTIxNDIsNyArMjE0Miw3IEBAIHN0YXRpYyBpbnQgZ2VuZXJp
Y19oZG1pX2J1aWxkX2phY2soc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIGludCBwY21faWR4KQog
CQlzdHJuY2F0KGhkbWlfc3RyLCAiIFBoYW50b20iLAogCQkJc2l6ZW9mKGhkbWlfc3RyKSAtIHN0
cmxlbihoZG1pX3N0cikgLSAxKTsKIAlyZXQgPSBzbmRfaGRhX2phY2tfYWRkX2tjdGwoY29kZWMs
IHBlcl9waW4tPnBpbl9uaWQsIGhkbWlfc3RyLAotCQkJCSAgICBwaGFudG9tX2phY2spOworCQkJ
CSAgICBwaGFudG9tX2phY2ssIDAsIE5VTEwpOwogCWlmIChyZXQgPCAwKQogCQlyZXR1cm4gcmV0
OwogCWphY2sgPSBzbmRfaGRhX2phY2tfdGJsX2dldChjb2RlYywgcGVyX3Bpbi0+cGluX25pZCk7
Cg==

--_003_6FAB7C47BCF00940BB0999A99BE3547A1842027FRTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0003-ALSA-hda-realtek-Enable-headset-button-support-for-n.patch"
Content-Description: 0003-ALSA-hda-realtek-Enable-headset-button-support-for-n.patch
Content-Disposition: attachment;
	filename="0003-ALSA-hda-realtek-Enable-headset-button-support-for-n.patch";
	size=3519; creation-date="Thu, 29 Nov 2018 08:54:19 GMT";
	modification-date="Fri, 07 Dec 2018 07:21:45 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MDI4ZTk1YzBlZmQ2OWQxYTEzMDE4OTVjNzczMmE0YmI5ZjFmMDRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPg0K
RGF0ZTogV2VkLCAyOCBOb3YgMjAxOCAxNTozMjo0NSArMDgwMA0KU3ViamVjdDogW1BBVENIIDMv
M10gQUxTQTogaGRhL3JlYWx0ZWsgLSBFbmFibGUgaGVhZHNldCBidXR0b24gc3VwcG9ydCBmb3Ig
bmV3DQogY29kZWMNCg0KVGhpcyBwYXRjaCB3aWxsIGVuYWJsZSBoZWFkc2V0IGJ1dHRvbiBmb3Ig
bmV3IENocm9tZSBwbGF0Zm9ybS4NCg0KU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWls
YW5nQHJlYWx0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNl
LmRlPg0KLS0tDQogc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgfCA2NiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2NiBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jDQppbmRleCAwNmY5MzAzMmQwY2MuLmI0ZDE1NDEyODRk
YSAxMDA2NDQNCi0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jDQorKysgYi9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYw0KQEAgLTUzNzEsNiArNTM3MSw2NiBAQCBzdGF0aWMg
dm9pZCBhbGMyODVfZml4dXBfaW52YWxpZGF0ZV9kYWNzKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
LA0KIAlzbmRfaGRhX292ZXJyaWRlX3djYXBzKGNvZGVjLCAweDAzLCAwKTsNCiB9DQogDQorc3Rh
dGljIGNvbnN0IHN0cnVjdCBoZGFfamFja19rZXltYXAgYWxjX2hlYWRzZXRfYnRuX2tleW1hcFtd
ID0gew0KKwl7IFNORF9KQUNLX0JUTl8wLCBLRVlfUExBWVBBVVNFIH0sDQorCXsgU05EX0pBQ0tf
QlROXzEsIEtFWV9WT0lDRUNPTU1BTkQgfSwNCisJeyBTTkRfSkFDS19CVE5fMiwgS0VZX1ZPTFVN
RVVQIH0sDQorCXsgU05EX0pBQ0tfQlROXzMsIEtFWV9WT0xVTUVET1dOIH0sDQorCXt9DQorfTsN
CisNCitzdGF0aWMgdm9pZCBhbGNfaGVhZHNldF9idG5fY2FsbGJhY2soc3RydWN0IGhkYV9jb2Rl
YyAqY29kZWMsDQorCQkJCSAgICAgc3RydWN0IGhkYV9qYWNrX2NhbGxiYWNrICpqYWNrKQ0KK3sN
CisJaW50IHJlcG9ydCA9IDA7DQorDQorCWlmIChqYWNrLT51bnNvbF9yZXMgJiAoNyA8PCAxMykp
DQorCQlyZXBvcnQgfD0gU05EX0pBQ0tfQlROXzA7DQorDQorCWlmIChqYWNrLT51bnNvbF9yZXMg
ICYgKDEgPDwgMTYgfCAzIDw8IDgpKQ0KKwkJcmVwb3J0IHw9IFNORF9KQUNLX0JUTl8xOw0KKw0K
KwkvKiBWb2x1bWUgdXAga2V5ICovDQorCWlmIChqYWNrLT51bnNvbF9yZXMgJiAoNyA8PCAyMykp
DQorCQlyZXBvcnQgfD0gU05EX0pBQ0tfQlROXzI7DQorDQorCS8qIFZvbHVtZSBkb3duIGtleSAq
Lw0KKwlpZiAoamFjay0+dW5zb2xfcmVzICYgKDcgPDwgMTApKQ0KKwkJcmVwb3J0IHw9IFNORF9K
QUNLX0JUTl8zOw0KKw0KKwlqYWNrLT5qYWNrLT5idXR0b25fc3RhdGUgPSByZXBvcnQ7DQorfQ0K
Kw0KK3N0YXRpYyB2b2lkIGFsY19maXh1cF9oZWFkc2V0X2phY2soc3RydWN0IGhkYV9jb2RlYyAq
Y29kZWMsDQorCQkJCSAgICBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwICpmaXgsIGludCBhY3Rpb24p
DQorew0KKw0KKwlzd2l0Y2ggKGFjdGlvbikgew0KKwljYXNlIEhEQV9GSVhVUF9BQ1RfUFJFX1BS
T0JFOg0KKwkJc25kX2hkYV9qYWNrX2RldGVjdF9lbmFibGVfY2FsbGJhY2soY29kZWMsIDB4NTUs
DQorCQkJCQkJICAgIGFsY19oZWFkc2V0X2J0bl9jYWxsYmFjayk7DQorCQlzbmRfaGRhX2phY2tf
YWRkX2tjdGwoY29kZWMsIDB4NTUsICJIZWFkc2V0IEphY2siLCBmYWxzZSwNCisJCQkJICAgICAg
U05EX0pBQ0tfSEVBRFNFVCwgYWxjX2hlYWRzZXRfYnRuX2tleW1hcCk7DQorCQlicmVhazsNCisJ
Y2FzZSBIREFfRklYVVBfQUNUX0lOSVQ6DQorCQlzd2l0Y2ggKGNvZGVjLT5jb3JlLnZlbmRvcl9p
ZCkgew0KKwkJY2FzZSAweDEwZWMwMjI1Og0KKwkJY2FzZSAweDEwZWMwMjk1Og0KKwkJY2FzZSAw
eDEwZWMwMjk5Og0KKwkJCWFsY193cml0ZV9jb2VmX2lkeChjb2RlYywgMHg0OCwgMHhkMDExKTsN
CisJCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDQ5LCAweDAwN2YsIDB4MDA0NSk7DQor
CQkJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg0NCwgMHgwMDdmIDw8IDgsIDB4MDA0NSA8
PCA4KTsNCisJCQlicmVhazsNCisJCWNhc2UgMHgxMGVjMDIzNjoNCisJCWNhc2UgMHgxMGVjMDI1
NjoNCisJCQlhbGNfd3JpdGVfY29lZl9pZHgoY29kZWMsIDB4NDgsIDB4ZDAxMSk7DQorCQkJYWxj
X3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg0OSwgMHgwMDdmLCAweDAwNDUpOw0KKwkJCWJyZWFr
Ow0KKwkJfQ0KKwkJYnJlYWs7DQorCX0NCit9DQorDQogLyogZm9yIGhkYV9maXh1cF90aGlua3Bh
ZF9hY3BpKCkgKi8NCiAjaW5jbHVkZSAidGhpbmtwYWRfaGVscGVyLmMiDQogDQpAQCAtNTUxMCw2
ICs1NTcwLDcgQEAgZW51bSB7DQogCUFMQzIyMV9GSVhVUF9IUF9IRUFEU0VUX01JQywNCiAJQUxD
Mjg1X0ZJWFVQX0xFTk9WT19IRUFEUEhPTkVfTk9JU0UsDQogCUFMQzI5NV9GSVhVUF9IUF9BVVRP
X01VVEUsDQorCUFMQzIyNV9GSVhVUF9IRUFEU0VUX0pBQ0ssDQogfTsNCiANCiBzdGF0aWMgY29u
c3Qgc3RydWN0IGhkYV9maXh1cCBhbGMyNjlfZml4dXBzW10gPSB7DQpAQCAtNjM4Nyw2ICs2NDQ4
LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX2ZpeHVwIGFsYzI2OV9maXh1cHNbXSA9IHsN
CiAJCS50eXBlID0gSERBX0ZJWFVQX0ZVTkMsDQogCQkudi5mdW5jID0gYWxjX2ZpeHVwX2F1dG9f
bXV0ZV92aWFfYW1wLA0KIAl9LA0KKwlbQUxDMjI1X0ZJWFVQX0hFQURTRVRfSkFDS10gPSB7DQor
CQkudHlwZSA9IEhEQV9GSVhVUF9GVU5DLA0KKwkJLnYuZnVuYyA9IGFsY19maXh1cF9oZWFkc2V0
X2phY2ssDQorCX0sDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9wY2lfcXVpcmsg
YWxjMjY5X2ZpeHVwX3RibFtdID0gew0KQEAgLTY3ODUsNiArNjg1MCw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgaGRhX21vZGVsX2ZpeHVwIGFsYzI2OV9maXh1cF9tb2RlbHNbXSA9IHsNCiAJey5p
ZCA9IEFMQzI1NV9GSVhVUF9EVU1NWV9MSU5FT1VUX1ZFUkIsIC5uYW1lID0gImFsYzI1NS1kdW1t
eS1saW5lb3V0In0sDQogCXsuaWQgPSBBTEMyNTVfRklYVVBfREVMTF9IRUFEU0VUX01JQywgLm5h
bWUgPSAiYWxjMjU1LWRlbGwtaGVhZHNldCJ9LA0KIAl7LmlkID0gQUxDMjk1X0ZJWFVQX0hQX1gz
NjAsIC5uYW1lID0gImFsYzI5NS1ocC14MzYwIn0sDQorCXsuaWQgPSBBTEMyMjVfRklYVVBfSEVB
RFNFVF9KQUNLLCAubmFtZSA9ICJhbGMtc2Vuc2UtY29tYm8ifSwNCiAJe30NCiB9Ow0KICNkZWZp
bmUgQUxDMjI1X1NUQU5EQVJEX1BJTlMgXA0KLS0gDQoyLjE5LjENCg0K

--_003_6FAB7C47BCF00940BB0999A99BE3547A1842027FRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_003_6FAB7C47BCF00940BB0999A99BE3547A1842027FRTITMBSV02realt_--
