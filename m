From: "Tatulea, Dragos" <dragos.tatulea@intel.com>
Subject: Re: hda-intel and runtime power-management
Date: Mon, 15 Aug 2011 18:27:18 +0300
Message-ID: <CAJ_JQ2UgBiw8W8iSWc8rWevDXhzN3aUGvLYAEau=qOnb8t6NoA@mail.gmail.com>
References: <CAJ_JQ2XYhyDasRfq_ksV4P6eOneDN3r8wOsm0NHweB9CnzcRNA@mail.gmail.com>
	<s5hipqm8opv.wl%tiwai@suse.de>
	<CAJ_JQ2XH09hXhkvhyomAP+OdvXsvZ1zf1f3zK_P=HL4J6GhJwA@mail.gmail.com>
	<s5hipq99mvp.wl%tiwai@suse.de>
	<CAJ_JQ2WVmCOwAonHLp2Hsn9dOm5YLpdg2aspr2kbUvBnzpJ4PQ@mail.gmail.com>
	<s5hei0wa0w8.wl%tiwai@suse.de>
	<CAJ_JQ2VWb2ANvz6HFvZBfdzchi6EM1MNuRMZ3K8HEppVAOVuVg@mail.gmail.com>
	<s5h8vr09sir.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e64136b80673c804aa8ce6da
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from orsmga101.jf.intel.com (mga06.intel.com [134.134.136.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B93424688
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 17:27:21 +0200 (CEST)
Received: by gxk10 with SMTP id 10so8114782gxk.25
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2011 08:27:18 -0700 (PDT)
In-Reply-To: <s5h8vr09sir.wl%tiwai@suse.de>
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

--0016e64136b80673c804aa8ce6da
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 11, 2011 at 1:01 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 10 Aug 2011 22:34:31 +0300,
> Tatulea, Dragos wrote:
> >
> > On Mon, Aug 8, 2011 at 9:11 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Sun, 7 Aug 2011 20:55:52 +0300,
> > > Tatulea, Dragos wrote:
> > >
> > > > >> >> I'm in the process of enabling pm runtime pm for the hda_intel
> > > driver,
> > > > >> >> not being sure if this is a sane task :). Noticed that
> > > > >> >> CONFIG_SND_HDA_POWER_SAVE disables codecs and chip when they
> are
> > > not
> > > > >> >> in use, but the power gain is not noticeable on my hw. On the
> other
> > > > >> >> hand, a full suspend (azx_suspend) does save a few hundred
> mW's.
> > > > >> >> I am aware that this is hw specific, but I would like to take
> > > > >> >> advantage of the full suspend. Suspend/resume latency is below
> > > jiffy
> > > > >> >> resolution.
> > > > >> >
> > > > >> > Hm, it's strange.  Basically the current power-save does almost
> > > > >> > equivalent with the normal suspend/resume, i.e. the codec is
> > > > >> > suspended and azx_stop_chip() is called.  Make sure that the
> > > > >> > power-saving is really kicked in during your test.
> > > > >> >
> > > > >> Indeed, I checked and a codec is stuck in a power transition for
> some
> > > reason.
> > > > >
> > > > > You should check who accessing the device files via fuser, etc.
> > > > >
> > >
> > Yes, there's a non-muted pcm around there that prevents the codec from
> > sleeping. I have a patch that checks for all substream states and puts
> the
> > chip to sleep when they are all paused/suspended. Is this a bad idea? It
> > could be that resuming the chip takes too long, depending on hw...
>
> The PCM state check would be good.
>
> I've been trying to do this for some time and it doesn't look nice or
right. See attached diff (grep from my git diff). Some feedback would be
appreciated.

My approach was to keep azx stream states and count the number of running
streams. On trigger, if all streams are not running then the codec will be
suspended via snd_hda_power_down and eventually azx_power_notify will be
called which is supposed to stop the chip. When a stream is [re]started and
the running stream count goes above 0, it will wake up the codec which will
wake up the chip as well. After some time debugging this code I am feeling
that I've taken the wrong route... I'm also not confident that it could work
on other codec configs.

Another approach would be to set the stream to mute when paused and let the
codec do the amp power check which will power it down if needed. What do you
think?

Thanks,
Dragos

--0016e64136b80673c804aa8ce6da
Content-Type: text/x-patch; charset=US-ASCII; name="snd_hda_pm_on_pcm_suspend.diff"
Content-Disposition: attachment; filename="snd_hda_pm_on_pcm_suspend.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grdlflxp0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NvbmZpZ3MvaTM4Nl9ncmVlbnJpZGdlX2FuZHJvaWRfZGVm
Y29uZmlnIGIvYXJjaC94ODYvY29uZmlncy9pMzg2X2dyZWVucmlkZ2VfYW5kcm9pZF9kZWZjb25m
aWcKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRh
L2hkYV9pbnRlbC5jCmluZGV4IDdhOTI2YzcuLjI3ODk2ZTUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Bj
aS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtMzk1
LDYgKzM5NiwxMiBAQCBzdHJ1Y3QgYXp4IHsKIAlpbnQgY2FwdHVyZV9pbmRleF9vZmZzZXQ7CiAJ
aW50IG51bV9zdHJlYW1zOwogCisjaWZkZWYgQ09ORklHX1NORF9IREFfUE9XRVJfU0FWRQorCXVu
c2lnbmVkIGNoYXIgKnJ1bm5pbmdfc3RyZWFtX21hcDsKKwkvKiBjb3VudCBydW5uaW5nIHN0cmVh
bXMgZm9yIHBvd2VyIGRvd24gd2hlbiBhbGwgcGF1c2VkICovCisJdW5zaWduZWQgaW50IHJ1bm5p
bmdfc3RyZWFtX2NvdW50OworI2VuZGlmCisKIAkvKiBwY2kgcmVzb3VyY2VzICovCiAJdW5zaWdu
ZWQgbG9uZyBhZGRyOwogCXZvaWQgX19pb21lbSAqcmVtYXBfYWRkcjsKQEAgLTg1NSw2ICs4NjIs
OSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGF6eF9nZXRfcmVzcG9uc2Uoc3RydWN0IGhkYV9idXMg
KmJ1cywKIAogI2lmZGVmIENPTkZJR19TTkRfSERBX1BPV0VSX1NBVkUKIHN0YXRpYyB2b2lkIGF6
eF9wb3dlcl9ub3RpZnkoc3RydWN0IGhkYV9idXMgKmJ1cyk7CitzdGF0aWMgaW50IGF6eF91cGRh
dGVfcnVubmluZ19zdHJlYW1zKHN0cnVjdCBhenggKmNoaXAsCisJCQkJICAgICAgaW50IGluZGV4
LAorCQkJCSAgICAgIHVuc2lnbmVkIGNoYXIgc3RhdGUpOwogI2VuZGlmCiAKIC8qIHJlc2V0IGNv
ZGVjIGxpbmsgKi8KCkBAIC0xNzAxLDYgKzE3MTYsMTAgQEAgc3RhdGljIGludCBhenhfcGNtX3Ry
aWdnZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sIGludCBjbWQpCiAJc3Ry
dWN0IHNuZF9wY21fc3Vic3RyZWFtICpzOwogCWludCByc3RhcnQgPSAwLCBzdGFydCwgbnN5bmMg
PSAwLCBzYml0cyA9IDA7CiAJaW50IG53YWl0LCB0aW1lb3V0OworI2lmZGVmIENPTkZJR19TTkRf
SERBX1BPV0VSX1NBVkUKKwlzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYyA9IGFwY20tPmNvZGVjOwor
I2VuZGlmCiAKIAlzd2l0Y2ggKGNtZCkgewogCWNhc2UgU05EUlZfUENNX1RSSUdHRVJfU1RBUlQ6
CkBAIC0xNzI3LDYgKzE3NDcsMTMgQEAgc3RhdGljIGludCBhenhfcGNtX3RyaWdnZXIoc3RydWN0
IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sIGludCBjbWQpCiAJCXNuZF9wY21fdHJpZ2dl
cl9kb25lKHMsIHN1YnN0cmVhbSk7CiAJfQogCisjaWZkZWYgQ09ORklHX1NORF9IREFfUE9XRVJf
U0FWRQorCWlmIChzdGFydCAmJiAhY29kZWMtPnBvd2VyX29uKSB7CisJCWF6eF9pbml0X2NoaXAo
Y2hpcCwgMSk7CisJCXNuZF9oZGFfcG93ZXJfdXAoY29kZWMpOworCX0KKyNlbmRpZgorCiAJc3Bp
bl9sb2NrKCZjaGlwLT5yZWdfbG9jayk7CiAJaWYgKG5zeW5jID4gMSkgewogCQkvKiBmaXJzdCwg
c2V0IFNZTkMgYml0cyBvZiBjb3JyZXNwb25kaW5nIHN0cmVhbXMgKi8KQEAgLTE3NDYsNyArMTc3
MywxNCBAQCBzdGF0aWMgaW50IGF6eF9wY21fdHJpZ2dlcihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJl
YW0gKnN1YnN0cmVhbSwgaW50IGNtZCkKIAkJCWF6eF9zdHJlYW1fc3RvcChjaGlwLCBhenhfZGV2
KTsKIAkJfQogCQlhenhfZGV2LT5ydW5uaW5nID0gc3RhcnQ7CisjaWZkZWYgQ09ORklHX1NORF9I
REFfUE9XRVJfU0FWRQorCQlhenhfdXBkYXRlX3J1bm5pbmdfc3RyZWFtcyhjaGlwLCBhenhfZGV2
LT5pbmRleCwgc3RhcnQpOworI2VuZGlmCiAJfQogCXNwaW5fdW5sb2NrKCZjaGlwLT5yZWdfbG9j
ayk7CiAJaWYgKHN0YXJ0KSB7CiAJCWlmIChuc3luYyA9PSAxKQpAQCAtMTc4OSw2ICsxODIzLDIz
IEBAIHN0YXRpYyBpbnQgYXp4X3BjbV90cmlnZ2VyKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAq
c3Vic3RyZWFtLCBpbnQgY21kKQogCQlhenhfd3JpdGVsKGNoaXAsIFNZTkMsIGF6eF9yZWFkbChj
aGlwLCBTWU5DKSAmIH5zYml0cyk7CiAJCXNwaW5fdW5sb2NrKCZjaGlwLT5yZWdfbG9jayk7CiAJ
fQorCisjaWZkZWYgQ09ORklHX1NORF9IREFfUE9XRVJfU0FWRQorCWlmICghc3RhcnQgJiYgIWNo
aXAtPnJ1bm5pbmdfc3RyZWFtX2NvdW50KQorCQlzbmRfaGRhX3Bvd2VyX2Rvd24oY29kZWMpOwor
I2VuZGlmCisKIAlyZXR1cm4gMDsKIH0KIApAQCAtMjExOSw2ICsyMTcyLDMxIEBAIHN0YXRpYyB2
b2lkIGF6eF9zdG9wX2NoaXAoc3RydWN0IGF6eCAqY2hpcCkKIH0KIAogI2lmZGVmIENPTkZJR19T
TkRfSERBX1BPV0VSX1NBVkUKKy8qKgorICogYXp4X3VwZGF0ZV9ydW5uaW5nX3N0cmVhbXMgLSB1
cGRhdGUgc3RhdGUgZm9yIHJ1bm5pbmcgc3RyZWFtcworICoKKyAqIFJldHVybnMgMSBpZiB0aGVy
ZSdzIGEgZGlmZiBpbiBzdGF0ZS4KKyAqLworc3RhdGljIGludCBhenhfdXBkYXRlX3J1bm5pbmdf
c3RyZWFtcyhzdHJ1Y3QgYXp4ICpjaGlwLAorCQkJCSAgICAgIGludCBpbmRleCwKKwkJCQkgICAg
ICB1bnNpZ25lZCBjaGFyIHN0YXRlKQoreworCXVuc2lnbmVkIGNoYXIgb2xkX3N0YXRlID0gY2hp
cC0+cnVubmluZ19zdHJlYW1fbWFwW2luZGV4XTsKKworCWlmIChzdGF0ZSA9PSBvbGRfc3RhdGUp
CisJCS8qIG5vdGhpbmcgY2hhbmdlZCAqLworCQlyZXR1cm4gMDsKKworCWNoaXAtPnJ1bm5pbmdf
c3RyZWFtX21hcFtpbmRleF0gPSBzdGF0ZTsKKworCWlmIChzdGF0ZSkKKwkJY2hpcC0+cnVubmlu
Z19zdHJlYW1fY291bnQrKzsKKwllbHNlCisJCWNoaXAtPnJ1bm5pbmdfc3RyZWFtX2NvdW50LS07
CisKKwlyZXR1cm4gMTsKK30KKwogLyogcG93ZXItdXAvZG93biB0aGUgY29udHJvbGxlciAqLwog
c3RhdGljIHZvaWQgYXp4X3Bvd2VyX25vdGlmeShzdHJ1Y3QgaGRhX2J1cyAqYnVzKQogewpAQCAt
MjEyNiwxNiArMjIwNCw0MSBAQCBzdGF0aWMgdm9pZCBhenhfcG93ZXJfbm90aWZ5KHN0cnVjdCBo
ZGFfYnVzICpidXMpCiAJc3RydWN0IGhkYV9jb2RlYyAqYzsKIAlpbnQgcG93ZXJfb24gPSAwOwor
CisJLyogQ29kZWNzIGNhbiBiZSBwb3dlcmVkIGRvd24gaWYgYWxsIHN0cmVhbXMgYXJlIHBhdXNl
ZC9zdXNwZW5kZWQgYW5kCisJICogY29kZWMgcmVmY291bnQgaXMgMSwgc2luY2UgcGNtcyBhcmUg
b3BlbmVkLgorCSAqLwogCWxpc3RfZm9yX2VhY2hfZW50cnkoYywgJmJ1cy0+Y29kZWNfbGlzdCwg
bGlzdCkgeworCQlpZiAoYy0+cG93ZXJfb24pIHsKKwkJCWlmICghY2hpcC0+cnVubmluZ19zdHJl
YW1fY291bnQgJiYgKGMtPnBvd2VyX2NvdW50IDw9IDEpKSB7CisJCQkJcHJpbnRrKCJcdHBvd2Vy
aW5nIGRvd24gY29kZWM6XG4iKTsKKwkJCQlzbmRfaGRhX3Bvd2VyX2Rvd24oYyk7CisJCQl9IGVs
c2UgeworCQkJCXBvd2VyX29uID0gMTsKKwkJCQlicmVhazsKKwkJCX0KKwkJfQotCQlpZiAoYy0+
cG93ZXJfb24pIHsKLQkJCXBvd2VyX29uID0gMTsKLQkJCWJyZWFrOwotCQl9CiAJfQogCWlmIChw
b3dlcl9vbikKIAkJYXp4X2luaXRfY2hpcChjaGlwLCAxKTsKIAllbHNlIGlmIChjaGlwLT5ydW5u
aW5nICYmIHBvd2VyX3NhdmVfY29udHJvbGxlciAmJgogCQkgIWJ1cy0+cG93ZXJfa2VlcF9saW5r
X29uKQogCQlhenhfc3RvcF9jaGlwKGNoaXApOwogfQogI2VuZGlmIC8qIENPTkZJR19TTkRfSERB
X1BPV0VSX1NBVkUgKi8KQEAgLTIyNjksNiArMjM3Miw5IEBAIHN0YXRpYyBpbnQgYXp4X2ZyZWUo
c3RydWN0IGF6eCAqY2hpcCkKIAkJc25kX2RtYV9mcmVlX3BhZ2VzKCZjaGlwLT5wb3NidWYpOwog
CXBjaV9yZWxlYXNlX3JlZ2lvbnMoY2hpcC0+cGNpKTsKIAlwY2lfZGlzYWJsZV9kZXZpY2UoY2hp
cC0+cGNpKTsKKyNpZmRlZiBDT05GSUdfU05EX0hEQV9QT1dFUl9TQVZFCisJa2ZyZWUoY2hpcC0+
cnVubmluZ19zdHJlYW1fbWFwKTsKKyNlbmRpZgogCWtmcmVlKGNoaXAtPmF6eF9kZXYpOwogCWtm
cmVlKGNoaXApOwogCkBAIC0yNTc4LDYgKzI2ODQsMTcgQEAgc3RhdGljIGludCBfX2RldmluaXQg
YXp4X2NyZWF0ZShzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQsIHN0cnVjdCBwY2lfZGV2ICpwY2ksCiAJ
CWdvdG8gZXJyb3V0OwogCX0KIAorI2lmZGVmIENPTkZJR19TTkRfSERBX1BPV0VSX1NBVkUKKwlj
aGlwLT5ydW5uaW5nX3N0cmVhbV9tYXAgPSBrY2FsbG9jKGNoaXAtPm51bV9zdHJlYW1zLAorCQkJ
CQkgICBzaXplb2YoKmNoaXAtPnJ1bm5pbmdfc3RyZWFtX21hcCksCisJCQkJCSAgIEdGUF9LRVJO
RUwpOworCWlmICghY2hpcC0+cnVubmluZ19zdHJlYW1fbWFwKSB7CisJCXNuZF9wcmludGsoS0VS
Tl9FUlIgU0ZYICJjYW4ndCBtYWxsb2MgcnVubmluZ19zdHJlYW1fbWFwXG4iKTsKKwkJa2ZyZWUo
Y2hpcC0+YXp4X2Rldik7CisJCWdvdG8gZXJyb3V0OworCX0KKyNlbmRpZgorCiAJZm9yIChpID0g
MDsgaSA8IGNoaXAtPm51bV9zdHJlYW1zOyBpKyspIHsKIAkJLyogYWxsb2NhdGUgbWVtb3J5IGZv
ciB0aGUgQkRMIGZvciBlYWNoIHN0cmVhbSAqLwogCQllcnIgPSBzbmRfZG1hX2FsbG9jX3BhZ2Vz
KFNORFJWX0RNQV9UWVBFX0RFViwK
--0016e64136b80673c804aa8ce6da
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0016e64136b80673c804aa8ce6da--
