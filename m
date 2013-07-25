From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 2/3] ALSA: hda - WAKEEN feature enabling
	for runtime pm
Date: Thu, 25 Jul 2013 12:54:54 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011851EFB@SHSMSX104.ccr.corp.intel.com>
References: <1374477558-14074-1-git-send-email-xingchao.wang@linux.intel.com>
 <1374477558-14074-2-git-send-email-xingchao.wang@linux.intel.com>
 <51EE327E.1070407@canonical.com>
 <46B810F6945F7C4788E11DCE57EC489011850663@SHSMSX104.ccr.corp.intel.com>
 <s5h4nbkp71n.wl%tiwai@suse.de>	<51EFBC40.5040403@canonical.com>
 <s5hvc40no2d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_46B810F6945F7C4788E11DCE57EC489011851EFBSHSMSX104ccrcor_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 14D9B26087A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 14:54:58 +0200 (CEST)
In-Reply-To: <s5hvc40no2d.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Girdwood, Liam
 R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

--_002_46B810F6945F7C4788E11DCE57EC489011851EFBSHSMSX104ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, July 24, 2013 8:24 PM
> To: David Henningsson
> Cc: Wang, Xingchao; Wang Xingchao; alsa-devel@alsa-project.org; Girdwood,
> Liam R
> Subject: Re: [PATCH 2/3] ALSA: hda - WAKEEN feature enabling for runtime =
pm
>=20
> At Wed, 24 Jul 2013 13:36:32 +0200,
> David Henningsson wrote:
> >
> > On 07/24/2013 12:48 PM, Takashi Iwai wrote:
> > > At Tue, 23 Jul 2013 08:09:02 +0000,
> > > Wang, Xingchao wrote:
> > >>
> > >>>>
> > >>>> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > >>>> ---
> > >>>>    sound/pci/hda/hda_intel.c | 25 +++++++++++++++++++++++++
> > >>>>    1 file changed, 25 insertions(+)
> > >>>>
> > >>>> diff --git a/sound/pci/hda/hda_intel.c
> > >>>> b/sound/pci/hda/hda_intel.c index 8860dd5..a7ac7fd 100644
> > >>>> --- a/sound/pci/hda/hda_intel.c
> > >>>> +++ b/sound/pci/hda/hda_intel.c
> > >>>> @@ -2970,6 +2970,11 @@ static int azx_runtime_suspend(struct
> > >>>> device
> > >>> *dev)
> > >>>>    {
> > >>>>    	struct snd_card *card =3D dev_get_drvdata(dev);
> > >>>>    	struct azx *chip =3D card->private_data;
> > >>>> +	int status;
> > >>>> +
> > >>>> +	/* enable controller wake up event */
> > >>>> +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
> > >>>> +		  STATESTS_INT_MASK);
> > >>>>
> > >>>>    	azx_stop_chip(chip);
> > >>>>    	azx_enter_link_reset(chip);
> > >>>> @@ -2983,11 +2988,31 @@ static int azx_runtime_resume(struct
> > >>>> device
> > >>> *dev)
> > >>>>    {
> > >>>>    	struct snd_card *card =3D dev_get_drvdata(dev);
> > >>>>    	struct azx *chip =3D card->private_data;
> > >>>> +	struct hda_bus *bus;
> > >>>> +	struct hda_codec *codec;
> > >>>> +	int status;
> > >>>>
> > >>>>    	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
> > >>>>    		hda_display_power(true);
> > >>>> +
> > >>>> +	/* Read STATESTS before controller reset */
> > >>>> +	status =3D azx_readw(chip, STATESTS);
> > >>>> +
> > >>>>    	azx_init_pci(chip);
> > >>>>    	azx_init_chip(chip, 1);
> > >>>> +
> > >>>> +	bus =3D chip->bus;
> > >>>> +	if (status && bus) {
> > >>>> +		list_for_each_entry(codec, &bus->codec_list, list)
> > >>>> +			if (status & (1 << codec->addr))
> > >>>> +				queue_delayed_work(codec->bus->workq,
> > >>>> +						   &codec->jackpoll_work,
> > >>> codec->jackpoll_interval);
> > >>>
> > >>> Is there a reason you want to move the jack detection to a delayed
> > >>> work, i e, why can't we just call:
> > >>>
> > >>>    	snd_hda_jack_set_dirty_all(codec);
> > >>>    	snd_hda_jack_poll_all(codec);
> > >>>
> > >>> ...from here?
> > >>
> > >> In fact it doesnot work for me, It will again call runtime_resume() =
and
> caused dead loop.
> > >
> > > It means that the power refcount is messed up by this way.
> > >
> > > When a verb is executed, the codec goes to a full resume mode, which
> > > turns up the controller, eventually calling azx_power_notify().
> > > In azx_power_notify(), pm_runtime_{get|put}_sync() is called
> > > accordingly, which again goes to runtime resume.  A quick fix would
> > > be to add a flag or something to avoid reentrace.
> > >
> > > But, calling the jackpoll in the resume is basically superfluous.
> > > As already mentioned, issuing a verb itself triggers the full
> > > resume, and this already includes the update of the whole jack status=
.
> > > Thus, executing jackpoll at that place means to perform the jack
> > > polling twice.
> > >
> > > In other words, what's we need to achieve is just to call
> > > snd_hda_resume() appropriately in the runtime resume case.
> > > Of course, this will need more fixes for avoiding reentrance, etc.
> > >
> > > But, it leads to another question: do we need a full resume just for
> > > jack detection and user-space notification?  Just reading the pin
> > > detect state should be able to run even in D3 (for chips that are
> > > capable of it), and the notification itself doesn't need any audio
> > > hardware action.

Takashi, I donot find description about reading pin state in D3 in HD-Audio=
 spec.
Am I missing something?

> >
> > The STATESTS register only indicates which codec requested wakeup, not
> > which pin. So you need to issue the get_pin_sense verb for all pins on
> > the codec, which means that the codec - controller link must be powered=
 up.
> >

Yes, as Takashi mentioned above, if each pin's jack state could be read in =
D3, it's not a problem anymore.
I work out a new patch to remember old pin_sense and report to user-space w=
hen receive wake-up event.
This could avoid polling jack state and send command, I thought it could av=
oid waking up audio controller/codec, but not...
(for detail changes please find in attached patch file)

> > So that's half of the resume procedure already.
>=20
> The rest half is rather a longer run; it executes many verbs to restore t=
he whole
> codec widget states.  And, it's done just to run a few GET_PIN_SENSE verb=
s.
> For reading GET_PIN_SENSE, we even don't have to power up the codec.
>=20
> > Are you proposing we
> > introduce some kind of "half-resumed" mode that we would be in when we
> > wait for the response from get_pin_sense? It sounds like additional
> > complexity for very little gain in power.
>=20
> Yeah, the complexity question is still valid.
>=20
> However, in this runtime PM suspend case, the system doesn't react to cha=
nge
> the configuration for auto-mute, etc, at this point.  It just needs to se=
nd a
> notification to the user-space.  So, it sends a few GET_PIN_SENSE verbs, =
then
> updates the kctl / input-jack stuff -- that's all it needs.
>=20
> For example, suppose that we have a function to execute the verb without =
the
> power up/down sequence, e.g. snd_hda_codec_read_no_pm().
> Then change snd_hda_codec_read() call with this one if codec->epss is tru=
e.
>=20
> Of course, it won't suffice to assure that it's executed in the proper po=
wer
> state, so the end result might become too complex.  Needs more
> investigations.
>=20
>=20
> Takashi

--_002_46B810F6945F7C4788E11DCE57EC489011851EFBSHSMSX104ccrcor_
Content-Type: application/octet-stream;
	name="0001-ALSA-hda-Jack-hotplug-support-in-D3.patch"
Content-Description: 0001-ALSA-hda-Jack-hotplug-support-in-D3.patch
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Jack-hotplug-support-in-D3.patch"; size=5837;
	creation-date="Thu, 25 Jul 2013 01:28:13 GMT";
	modification-date="Thu, 25 Jul 2013 01:28:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0ZGEzYTk3ZTA0NzczZTdkMjZlYzU5NWI4MzI2YzQzN2EzOTA4M2Q3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYW5nIFhpbmdjaGFvIDx4aW5nY2hhby53YW5nQGxpbnV4Lmlu
dGVsLmNvbT4KRGF0ZTogVGh1LCAyNSBKdWwgMjAxMyAwOToyNDo0OSAtMDQwMApTdWJqZWN0OiBb
UEFUQ0hdIEFMU0E6IGhkYSAtIEphY2sgaG90cGx1ZyBzdXBwb3J0IGluIEQzCgpUaGlzIHBhdGNo
IGludGVuZGVkIHRvIGF2b2lkIHdha2luZyB1cCB0aGUgY29udHJvbGxlci9jb2RlYywgYnV0IEZB
SUxFRC4KRXZlbiBubyB0b3VjaCBoYXJkd2FyZSByZWdpc3RlciBpbiBydW50aW1lX3Jlc3VtL3N1
c3BlbmQgY2FsbGJhY2sgd2hlbgpkZXRlY3RlZCBqYWNrIGhvdHBsdWcobGVhdmUgY29kZWMvY29u
dHJvbGxlciBpbiBEMyksIGkgc3RpbGwgc2VlIHRoZQpjb250cm9sbGVyIHdhcyB3YWtlbiB1cCwg
cG1fbm90aWZ5KCkgd2FzIGNhbGxlZC4KClNpZ25lZC1vZmYtYnk6IFdhbmcgWGluZ2NoYW8gPHhp
bmdjaGFvLndhbmdAbGludXguaW50ZWwuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvaGRhX2ludGVs
LmMgfCAxNiArKysrKysrKysrLS0tLQogc291bmQvcGNpL2hkYS9oZGFfamFjay5jICB8IDU1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCiBzb3VuZC9wY2kv
aGRhL2hkYV9qYWNrLmggIHwgIDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5j
IGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwppbmRleCA3MDhlOTg4Li4zOGVhYzNhIDEwMDY0
NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRh
X2ludGVsLmMKQEAgLTYzLDYgKzYzLDcgQEAKICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPgog
I2luY2x1ZGUgImhkYV9jb2RlYy5oIgogI2luY2x1ZGUgImhkYV9pOTE1LmgiCisjaW5jbHVkZSAi
aGRhX2phY2suaCIKIAogCiBzdGF0aWMgaW50IGluZGV4W1NORFJWX0NBUkRTXSA9IFNORFJWX0RF
RkFVTFRfSURYOwpAQCAtNTI5LDYgKzUzMCw3IEBAIHN0cnVjdCBhenggewogCXVuc2lnbmVkIGlu
dCBzbm9vcDoxOwogCXVuc2lnbmVkIGludCBhbGlnbl9idWZmZXJfc2l6ZToxOwogCXVuc2lnbmVk
IGludCByZWdpb25fcmVxdWVzdGVkOjE7CisJdW5zaWduZWQgaW50IGphY2tfcmVzdW1lOjE7CiAK
IAkvKiBWR0Etc3dpdGNoZXJvbyBzZXR1cCAqLwogCXVuc2lnbmVkIGludCB1c2VfdmdhX3N3aXRj
aGVyb286MTsKQEAgLTEzNzgsNiArMTM4MCw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBhenhfaW50
ZXJydXB0KGludCBpcnEsIHZvaWQgKmRldl9pZCkKIAl1OCBzZF9zdGF0dXM7CiAJaW50IGksIG9r
OwogCisKICNpZmRlZiBDT05GSUdfUE1fUlVOVElNRQogCWlmIChjaGlwLT5wY2ktPmRldi5wb3dl
ci5ydW50aW1lX3N0YXR1cyAhPSBSUE1fQUNUSVZFKQogCQlyZXR1cm4gSVJRX05PTkU7CkBAIC0y
ODIzLDYgKzI4MjYsNyBAQCBzdGF0aWMgdm9pZCBhenhfbG9hZF9kc3BfY2xlYW51cChzdHJ1Y3Qg
aGRhX2J1cyAqYnVzLAogc3RhdGljIHZvaWQgYXp4X3Bvd2VyX25vdGlmeShzdHJ1Y3QgaGRhX2J1
cyAqYnVzLCBib29sIHBvd2VyX3VwKQogewogCXN0cnVjdCBhenggKmNoaXAgPSBidXMtPnByaXZh
dGVfZGF0YTsKKwlzbmRfcHJpbnRrKCJqYWNrOiBjaGVjayBjYWxsaW5nIGhlcmVcbiIpOwogCiAJ
aWYgKCEoY2hpcC0+ZHJpdmVyX2NhcHMgJiBBWlhfRENBUFNfUE1fUlVOVElNRSkpCiAJCXJldHVy
bjsKQEAgLTI5NTYsMTIgKzI5NjAsMTMgQEAgc3RhdGljIGludCBhenhfcnVudGltZV9zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldikKIAlpbnQgZXZlbnQsIHN0YXR1czsKIAl1bnNpZ25lZCBsb25n
IHRpbWVvdXQ7CiAKLQlzbmRfcHJpbnRrKCJQb3dlci13ZWxsOiBBenggcnVudGltZSBzdXNwZW5k
IGNhbGxlZFxuIik7Ci0KIAkvKiBlbmFibGUgY29udHJvbGxlciB3YWtlIHVwIGV2ZW50ICovCiAJ
YXp4X3dyaXRldyhjaGlwLCBXQUtFRU4sIGF6eF9yZWFkYihjaGlwLCBXQUtFRU4pIHwKIAkJICBT
VEFURVNUU19JTlRfTUFTSyk7CiAKKwlpZiAoY2hpcC0+amFja19yZXN1bWUpCisJCWdvdG8gb3V0
OworCiAJYXp4X3N0b3BfY2hpcChjaGlwKTsKIAlhenhfY2xlYXJfaXJxX3BlbmRpbmcoY2hpcCk7
CiAKQEAgLTI5NzQsNiArMjk3OSw3IEBAIHN0YXRpYyBpbnQgYXp4X3J1bnRpbWVfc3VzcGVuZChz
dHJ1Y3QgZGV2aWNlICpkZXYpCiAJCQl0aW1lX2JlZm9yZShqaWZmaWVzLCB0aW1lb3V0KSkKIAkJ
dXNsZWVwX3JhbmdlKDUwMCwgMTAwMCk7CiAKK291dDoKIAlpZiAoY2hpcC0+ZHJpdmVyX2NhcHMg
JiBBWlhfRENBUFNfSTkxNV9QT1dFUldFTEwpCiAJCWhkYV9kaXNwbGF5X3Bvd2VyKGZhbHNlKTsK
IAlyZXR1cm4gMDsKQEAgLTI5OTgsMTEgKzMwMDQsMTMgQEAgc3RhdGljIGludCBhenhfcnVudGlt
ZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQogCWF6eF9pbml0X3BjaShjaGlwKTsKIAlhenhf
aW5pdF9jaGlwKGNoaXAsIDEpOwogCisJY2hpcC0+amFja19yZXN1bWUgPSAhIXN0YXR1czsKIAlp
ZiAoc3RhdHVzICYmIGJ1cykgewogCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNvZGVjLCAmYnVzLT5j
b2RlY19saXN0LCBsaXN0KQogCQkJaWYgKHN0YXR1cyAmICgxIDw8IGNvZGVjLT5hZGRyKSkKLQkJ
CQlxdWV1ZV9kZWxheWVkX3dvcmsoY29kZWMtPmJ1cy0+d29ya3EsCi0JCQkJCQkgICAmY29kZWMt
PmphY2twb2xsX3dvcmssIGNvZGVjLT5qYWNrcG9sbF9pbnRlcnZhbCk7CisJCQkJc25kX2hkYV9q
YWNrX3JlcG9ydF9ub193YWtldXAoY29kZWMpOworCQorCQlyZXR1cm4gMDsKIAl9CiAKIAkvKiBk
aXNhYmxlIGNvbnRyb2xsZXIgV2FrZSBVcCBldmVudCovCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kv
aGRhL2hkYV9qYWNrLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9qYWNrLmMKaW5kZXggOWUwYTk1Mi4u
OGIwZjYxOSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9oZGFfamFjay5jCisrKyBiL3NvdW5k
L3BjaS9oZGEvaGRhX2phY2suYwpAQCAtMjYwLDIzICsyNjAsMjMgQEAgaW50IHNuZF9oZGFfamFj
a19zZXRfZ2F0aW5nX2phY2soc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIGhkYV9uaWRfdCBnYXRl
ZF9uaWQsCiB9CiBFWFBPUlRfU1lNQk9MX0hEQShzbmRfaGRhX2phY2tfc2V0X2dhdGluZ19qYWNr
KTsKIAotLyoqCi0gKiBzbmRfaGRhX2phY2tfcmVwb3J0X3N5bmMgLSBzeW5jIHRoZSBzdGF0ZXMg
b2YgYWxsIGphY2tzIGFuZCByZXBvcnQgaWYgY2hhbmdlZAotICovCi12b2lkIHNuZF9oZGFfamFj
a19yZXBvcnRfc3luYyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKK3N0YXRpYyB2b2lkIHVwZGF0
ZV9qYWNrcyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIHsKIAlzdHJ1Y3QgaGRhX2phY2tfdGJs
ICpqYWNrOwotCWludCBpLCBzdGF0ZTsKKwlpbnQgaTsKIAogCS8qIHVwZGF0ZSBhbGwgamFja3Mg
YXQgZmlyc3QgKi8KIAlqYWNrID0gY29kZWMtPmphY2t0YmwubGlzdDsKIAlmb3IgKGkgPSAwOyBp
IDwgY29kZWMtPmphY2t0YmwudXNlZDsgaSsrLCBqYWNrKyspCiAJCWlmIChqYWNrLT5uaWQpCiAJ
CQlqYWNrX2RldGVjdF91cGRhdGUoY29kZWMsIGphY2spOworfQorCitzdGF0aWMgdm9pZCByZXBv
cnRfamFja3Moc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCit7CisJc3RydWN0IGhkYV9qYWNrX3Ri
bCAqamFjazsKKwlpbnQgaSwgc3RhdGU7CiAKLQkvKiByZXBvcnQgdGhlIHVwZGF0ZWQgamFja3M7
IGl0J3MgZG9uZSBhZnRlciB1cGRhdGluZyBhbGwgamFja3MKLQkgKiB0byBtYWtlIHN1cmUgdGhh
dCBhbGwgZ2F0aW5nIGphY2tzIHByb3Blcmx5IGhhdmUgYmVlbiBzZXQKLQkgKi8KIAlqYWNrID0g
Y29kZWMtPmphY2t0YmwubGlzdDsKIAlmb3IgKGkgPSAwOyBpIDwgY29kZWMtPmphY2t0YmwudXNl
ZDsgaSsrLCBqYWNrKyspCiAJCWlmIChqYWNrLT5uaWQpIHsKQEAgLTI5MCw5ICsyOTAsNDggQEAg
dm9pZCBzbmRfaGRhX2phY2tfcmVwb3J0X3N5bmMoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJ
CQkJCQlzdGF0ZSA/IGphY2stPnR5cGUgOiAwKTsKICNlbmRpZgogCQl9CisKK30KKworLyoqCisg
KiBzbmRfaGRhX2phY2tfcmVwb3J0X3N5bmMgLSBzeW5jIHRoZSBzdGF0ZXMgb2YgYWxsIGphY2tz
IGFuZCByZXBvcnQgaWYgY2hhbmdlZAorICovCit2b2lkIHNuZF9oZGFfamFja19yZXBvcnRfc3lu
YyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKK3sKKwlzdHJ1Y3QgaGRhX2phY2tfdGJsICpqYWNr
OworCWludCBpLCBzdGF0ZTsKKworCXVwZGF0ZV9qYWNrcyhjb2RlYyk7CisJLyogcmVwb3J0IHRo
ZSB1cGRhdGVkIGphY2tzOyBpdCdzIGRvbmUgYWZ0ZXIgdXBkYXRpbmcgYWxsIGphY2tzCisJICog
dG8gbWFrZSBzdXJlIHRoYXQgYWxsIGdhdGluZyBqYWNrcyBwcm9wZXJseSBoYXZlIGJlZW4gc2V0
CisJICovCisJcmVwb3J0X2phY2tzKGNvZGVjKTsKIH0KIEVYUE9SVF9TWU1CT0xfSERBKHNuZF9o
ZGFfamFja19yZXBvcnRfc3luYyk7CiAKK3ZvaWQgc25kX2hkYV9qYWNrX3JlcG9ydF9ub193YWtl
dXAoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCit7CisJc3RydWN0IGhkYV9qYWNrX3RibCAqamFj
azsKKwlpbnQgaSwgc3RhdGU7CisKKwkvKiByZXZlcnQgYWxsIGphY2sgc3RhdGUgKi8KKwlqYWNr
ID0gY29kZWMtPmphY2t0YmwubGlzdDsKKwlmb3IgKGkgPSAwOyBpIDwgY29kZWMtPmphY2t0Ymwu
dXNlZDsgaSsrLCBqYWNrKyspCisJCWlmIChqYWNrLT5uaWQpIHsKKwkJCXN0YXRlID0gZ2V0X2ph
Y2tfcGx1Z19zdGF0ZShqYWNrLT5waW5fc2Vuc2UpOworCQkJaWYgKCFqYWNrLT5waW5fc2Vuc2Up
CisJCQkJamFjay0+cGluX3NlbnNlID0gQUNfUElOU0VOU0VfUFJFU0VOQ0U7CisJCQllbHNlCisJ
CQkJamFjay0+cGluX3NlbnNlID0gMDsKKwkJfQorCisJLyogcmVwb3J0IHRoZSB1cGRhdGVkIGph
Y2tzOyBpdCdzIGRvbmUgYWZ0ZXIgdXBkYXRpbmcgYWxsIGphY2tzCisJICogdG8gbWFrZSBzdXJl
IHRoYXQgYWxsIGdhdGluZyBqYWNrcyBwcm9wZXJseSBoYXZlIGJlZW4gc2V0CisJICovCisJcmVw
b3J0X2phY2tzKGNvZGVjKTsKK30KK0VYUE9SVF9TWU1CT0xfSERBKHNuZF9oZGFfamFja19yZXBv
cnRfbm9fd2FrZXVwKTsKKwogI2lmZGVmIENPTkZJR19TTkRfSERBX0lOUFVUX0pBQ0sKIC8qIGd1
ZXNzIHRoZSBqYWNrIHR5cGUgZnJvbSB0aGUgcGluLWNvbmZpZyAqLwogc3RhdGljIGludCBnZXRf
aW5wdXRfamFja190eXBlKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLCBoZGFfbmlkX3QgbmlkKQpk
aWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9oZGFfamFjay5oIGIvc291bmQvcGNpL2hkYS9oZGFf
amFjay5oCmluZGV4IGVjMTJhYmQuLmIxNGNmMjQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEv
aGRhX2phY2suaAorKysgYi9zb3VuZC9wY2kvaGRhL2hkYV9qYWNrLmgKQEAgLTg1LDYgKzg1LDcg
QEAgaW50IHNuZF9oZGFfamFja19hZGRfa2N0bHMoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsCiAJ
CQkgICBjb25zdCBzdHJ1Y3QgYXV0b19waW5fY2ZnICpjZmcpOwogCiB2b2lkIHNuZF9oZGFfamFj
a19yZXBvcnRfc3luYyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYyk7Cit2b2lkIHNuZF9oZGFfamFj
a19yZXBvcnRfbm9fd2FrZXVwKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKTsKIAogdm9pZCBzbmRf
aGRhX2phY2tfdW5zb2xfZXZlbnQoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIHVuc2lnbmVkIGlu
dCByZXMpOwogCi0tIAoxLjguMy4yCgo=

--_002_46B810F6945F7C4788E11DCE57EC489011851EFBSHSMSX104ccrcor_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_46B810F6945F7C4788E11DCE57EC489011851EFBSHSMSX104ccrcor_--
