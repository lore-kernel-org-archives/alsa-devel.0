From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 2/3] ALSA: hda - WAKEEN feature enabling
	for runtime pm
Date: Tue, 23 Jul 2013 08:06:21 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011850635@SHSMSX104.ccr.corp.intel.com>
References: <1374477558-14074-1-git-send-email-xingchao.wang@linux.intel.com>
 <1374477558-14074-2-git-send-email-xingchao.wang@linux.intel.com>
 <51EE327E.1070407@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_46B810F6945F7C4788E11DCE57EC489011850635SHSMSX104ccrcor_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C435261ADF
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 10:06:26 +0200 (CEST)
In-Reply-To: <51EE327E.1070407@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

--_002_46B810F6945F7C4788E11DCE57EC489011850635SHSMSX104ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Tuesday, July 23, 2013 3:37 PM
> To: Wang Xingchao
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de; Girdwood, Liam R; Wang,
> Xingchao
> Subject: Re: [PATCH 2/3] ALSA: hda - WAKEEN feature enabling for runtime =
pm
>=20
> On 07/22/2013 09:19 AM, Wang Xingchao wrote:
> > With runtime power save feature enabled, Headphone hotplug event will
> > not be detected while controller/codec in D3. HDA has feature WAKEEN
> > to let codec wake up system if controller is in D3 or system in
> > S3.(HDA Spec 4.5.9.2/3). Codec can send out INT or wake up controller
> > depending on whether CIE or GIE enabled.(Figure 4, Interupt
> > structure).
>=20
> Oh, so you actually got it working? Nice! :-)
>=20
> > The controller must be in RESET mode after enter runtime-suspend,
> > otherwise it will not be waken up even if codec send out wake-up
> > event. And STATESTS will be cleared after controller brought out of RES=
ET
> mode.
>=20
> There seems to be nothing in this patch that sets the controller in RESET=
 mode,
> is this something done in a later patch, or is that code already present =
today,
> or...?

Yeah, an interesting story on this. You can see the original patch in attac=
hed file, it did add
reset before runtime-suspend. But I find Mengdong did same thing for anothe=
r bug fix already.

commit 3af3f356e16041c3353210214da601782e2cd8b4
Author: Mengdong Lin <mengdong.lin@intel.com>
Date:   Mon Jun 24 10:18:54 2013 -0400

    ALSA: hda - reset hda link during system/runtime suspend

    If all the codecs report ClkStopOK (OK to stop bus clock) after being p=
ut to
    D3, this patch will reset the HDA link before the controller is put to =
D3.

    So the link will be in reset during system or runtime suspend, the bus =
clock
    stops and the codecs are in D3(ClkStop) state.

    This may help to reduce power consumption by dozens of mW on some perip=
heral
    hda codecs.

    Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks
--xingchao
>=20
> > This patch only enable WAKEEN for runtime-suspend(Controller D3) mode,
> > not for system S3 mode. with tool "evtest", Headphone hotplug events
> > could be cought and reported successfully.
>=20
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > ---
> >   sound/pci/hda/hda_intel.c | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 8860dd5..a7ac7fd 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2970,6 +2970,11 @@ static int azx_runtime_suspend(struct device
> *dev)
> >   {
> >   	struct snd_card *card =3D dev_get_drvdata(dev);
> >   	struct azx *chip =3D card->private_data;
> > +	int status;
> > +
> > +	/* enable controller wake up event */
> > +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
> > +		  STATESTS_INT_MASK);
> >
> >   	azx_stop_chip(chip);
> >   	azx_enter_link_reset(chip);
> > @@ -2983,11 +2988,31 @@ static int azx_runtime_resume(struct device
> *dev)
> >   {
> >   	struct snd_card *card =3D dev_get_drvdata(dev);
> >   	struct azx *chip =3D card->private_data;
> > +	struct hda_bus *bus;
> > +	struct hda_codec *codec;
> > +	int status;
> >
> >   	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
> >   		hda_display_power(true);
> > +
> > +	/* Read STATESTS before controller reset */
> > +	status =3D azx_readw(chip, STATESTS);
> > +
> >   	azx_init_pci(chip);
> >   	azx_init_chip(chip, 1);
> > +
> > +	bus =3D chip->bus;
> > +	if (status && bus) {
> > +		list_for_each_entry(codec, &bus->codec_list, list)
> > +			if (status & (1 << codec->addr))
> > +				queue_delayed_work(codec->bus->workq,
> > +						   &codec->jackpoll_work,
> codec->jackpoll_interval);
>=20
> Is there a reason you want to move the jack detection to a delayed work, =
i e,
> why can't we just call:
>=20
>   	snd_hda_jack_set_dirty_all(codec);
>   	snd_hda_jack_poll_all(codec);
>=20
> ...from here?
>=20
> > +	}
> > +
> > +	/* disable controller Wake Up event*/
> > +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
> > +			~STATESTS_INT_MASK);
> > +
> >   	return 0;
> >   }
> >
> >
>=20
>=20
>=20
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic

--_002_46B810F6945F7C4788E11DCE57EC489011850635SHSMSX104ccrcor_
Content-Type: application/octet-stream;
	name="0001-ALSA-hda-WAKEEN-feature-enabling-for-runtime-pm.patch"
Content-Description: 0001-ALSA-hda-WAKEEN-feature-enabling-for-runtime-pm.patch
Content-Disposition: attachment;
	filename="0001-ALSA-hda-WAKEEN-feature-enabling-for-runtime-pm.patch";
	size=2990; creation-date="Tue, 23 Jul 2013 08:01:32 GMT";
	modification-date="Tue, 23 Jul 2013 08:36:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNDgwZDZiYzhlOWU4NjcyMGI4YTk3NjcwMTFhOTQzOWU4Njg1MzczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYW5nIFhpbmdjaGFvIDx4aW5nY2hhby53YW5nQGxpbnV4Lmlu
dGVsLmNvbT4KRGF0ZTogTW9uLCAyMiBKdWwgMjAxMyAwMjo0ODo0NCAtMDQwMApTdWJqZWN0OiBb
UEFUQ0hdIEFMU0E6IGhkYSAtIFdBS0VFTiBmZWF0dXJlIGVuYWJsaW5nIGZvciBydW50aW1lIHBt
CgpXaXRoIHJ1bnRpbWUgcG93ZXIgc2F2ZSBmZWF0dXJlIGVuYWJsZWQsIEhlYWRwaG9uZSBob3Rw
bHVnCmV2ZW50IHdpbGwgbm90IGJlIGRldGVjdGVkIHdoaWxlIGNvbnRyb2xsZXIvY29kZWMgaW4g
RDMuIEhEQSBoYXMKZmVhdHVyZSBXQUtFRU4gdG8gbGV0IGNvZGVjIHdha2UgdXAgc3lzdGVtIGlm
IGNvbnRyb2xsZXIgaXMgaW4gRDMgb3IKc3lzdGVtIGluIFMzLihIREEgU3BlYyA0LjUuOS4yLzMp
LiBDb2RlYyBjYW4gc2VuZCBvdXQgSU5UIG9yIHdha2UgdXAKY29udHJvbGxlciBkZXBlbmRpbmcg
b24gd2hldGhlciBDSUUgb3IgR0lFIGVuYWJsZWQuKEZpZ3VyZSA0LCBJbnRlcnVwdApzdHJ1Y3R1
cmUpLgoKVGhlIGNvbnRyb2xsZXIgbXVzdCBiZSBpbiBSRVNFVCBtb2RlIGFmdGVyIGVudGVyIHJ1
bnRpbWUtc3VzcGVuZCwgb3RoZXJ3aXNlCml0IHdpbGwgbm90IGJlIHdha2VuIHVwIGV2ZW4gaWYg
Y29kZWMgc2VuZCBvdXQgd2FrZS11cCBldmVudC4gQW5kIFNUQVRFU1RTCndpbGwgYmUgY2xlYXJl
ZCBhZnRlciBjb250cm9sbGVyIGJyb3VnaHQgb3V0IG9mIFJFU0VUIG1vZGUuCgpUaGlzIHBhdGNo
IG9ubHkgZW5hYmxlIFdBS0VFTiBmb3IgcnVudGltZS1zdXNwZW5kKENvbnRyb2xsZXIgRDMpIG1v
ZGUsCm5vdCBmb3Igc3lzdGVtIFMzIG1vZGUuIHdpdGggdG9vbCAiZXZ0ZXN0IiwgSGVhZHBob25l
IGhvdHBsdWcgZXZlbnRzCmNvdWxkIGJlIGNvdWdodCBhbmQgcmVwb3J0ZWQgc3VjY2Vzc2Z1bGx5
LgoKU2lnbmVkLW9mZi1ieTogV2FuZyBYaW5nY2hhbyA8eGluZ2NoYW8ud2FuZ0BsaW51eC5pbnRl
bC5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyB8IDM3ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyBiL3NvdW5kL3BjaS9oZGEv
aGRhX2ludGVsLmMKaW5kZXggY2M1NDhlMDAuLmNiYjBhNWYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Bj
aS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtMjk1
MywxMCArMjk1MywyNyBAQCBzdGF0aWMgaW50IGF6eF9ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2KQogewogCXN0cnVjdCBzbmRfY2FyZCAqY2FyZCA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOwogCXN0cnVjdCBhenggKmNoaXAgPSBjYXJkLT5wcml2YXRlX2RhdGE7CisJaW50IGV2ZW50
LCBzdGF0dXM7CisJdW5zaWduZWQgbG9uZyB0aW1lb3V0OwogCiAJc25kX3ByaW50aygiUG93ZXIt
d2VsbDogQXp4IHJ1bnRpbWUgc3VzcGVuZCBjYWxsZWRcbiIpOworCisJLyogZW5hYmxlIGNvbnRy
b2xsZXIgd2FrZSB1cCBldmVudCAqLworCWF6eF93cml0ZXcoY2hpcCwgV0FLRUVOLCBhenhfcmVh
ZGIoY2hpcCwgV0FLRUVOKSB8CisJCSAgU1RBVEVTVFNfSU5UX01BU0spOworCiAJYXp4X3N0b3Bf
Y2hpcChjaGlwKTsKIAlhenhfY2xlYXJfaXJxX3BlbmRpbmcoY2hpcCk7CisKKworCS8qIHJlc2V0
IGNvbnRyb2xsZXIgKi8KKwlhenhfd3JpdGVsKGNoaXAsIEdDVEwsIGF6eF9yZWFkbChjaGlwLCBH
Q1RMKSAmIH5JQ0g2X0dDVExfUkVTRVQpOworCisJdGltZW91dCA9IGppZmZpZXMgKyBtc2Vjc190
b19qaWZmaWVzKDEwMCk7CisJd2hpbGUgKGF6eF9yZWFkYihjaGlwLCBHQ1RMKSAmJgorCQkJdGlt
ZV9iZWZvcmUoamlmZmllcywgdGltZW91dCkpCisJCXVzbGVlcF9yYW5nZSg1MDAsIDEwMDApOwor
CiAJaWYgKGNoaXAtPmRyaXZlcl9jYXBzICYgQVpYX0RDQVBTX0k5MTVfUE9XRVJXRUxMKQogCQlo
ZGFfZGlzcGxheV9wb3dlcihmYWxzZSk7CiAJcmV0dXJuIDA7CkBAIC0yOTY2LDEyICsyOTgzLDMy
IEBAIHN0YXRpYyBpbnQgYXp4X3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKIHsK
IAlzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKIAlzdHJ1Y3Qg
YXp4ICpjaGlwID0gY2FyZC0+cHJpdmF0ZV9kYXRhOworCXN0cnVjdCBoZGFfYnVzICpidXM7CisJ
c3RydWN0IGhkYV9jb2RlYyAqY29kZWM7CisJaW50IHN0YXR1czsKIAogCXNuZF9wcmludGsoIlBv
d2VyLXdlbGw6IEF6eCBydW50aW1lIHJlc3VtZSBjYWxsZWRcbiIpOwogCWlmIChjaGlwLT5kcml2
ZXJfY2FwcyAmIEFaWF9EQ0FQU19JOTE1X1BPV0VSV0VMTCkKIAkJaGRhX2Rpc3BsYXlfcG93ZXIo
dHJ1ZSk7CisJCisJLyogUmVhZCBTVEFURVNUUyBiZWZvcmUgY29udHJvbGxlciByZXNldCovCisJ
c3RhdHVzID0gYXp4X3JlYWR3KGNoaXAsIFNUQVRFU1RTKTsKKwlidXMgPSBjaGlwLT5idXM7CisK
IAlhenhfaW5pdF9wY2koY2hpcCk7CiAJYXp4X2luaXRfY2hpcChjaGlwLCAxKTsKKworCWlmIChz
dGF0dXMgJiYgYnVzKSB7CisJCWxpc3RfZm9yX2VhY2hfZW50cnkoY29kZWMsICZidXMtPmNvZGVj
X2xpc3QsIGxpc3QpCisJCQlpZiAoc3RhdHVzICYgKDEgPDwgY29kZWMtPmFkZHIpKQorCQkJCXF1
ZXVlX2RlbGF5ZWRfd29yayhjb2RlYy0+YnVzLT53b3JrcSwKKwkJCQkJCSAgICZjb2RlYy0+amFj
a3BvbGxfd29yaywgY29kZWMtPmphY2twb2xsX2ludGVydmFsKTsKKwl9CisKKwkvKiBkaXNhYmxl
IGNvbnRyb2xsZXIgV2FrZSBVcCBldmVudCovCisJYXp4X3dyaXRldyhjaGlwLCBXQUtFRU4sIGF6
eF9yZWFkYihjaGlwLCBXQUtFRU4pICYgCisJCSAgflNUQVRFU1RTX0lOVF9NQVNLKTsKKwogCXJl
dHVybiAwOwogfQogCi0tIAoxLjguMy4yCgo=

--_002_46B810F6945F7C4788E11DCE57EC489011850635SHSMSX104ccrcor_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_46B810F6945F7C4788E11DCE57EC489011850635SHSMSX104ccrcor_--
