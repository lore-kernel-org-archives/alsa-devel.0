From: "Yang, Libin" <Libin.Yang@amd.com>
Subject: Re: HDA-Intel - Patch to support detecting HD Audio
	devices with PCI class code
Date: Mon, 17 Nov 2008 11:44:32 +0800
Message-ID: <6077B97E85E7374DAE87B42B5AA997970D04B5@sshaexmb1.amd.com>
References: <6077B97E85E7374DAE87B42B5AA9979707B88A@sshaexmb1.amd.com><s5hej1iznfu.wl%tiwai@suse.de><6077B97E85E7374DAE87B42B5AA9979707BA28@sshaexmb1.amd.com><s5h7i7azm8r.wl%tiwai@suse.de><6077B97E85E7374DAE87B42B5AA9979709C0C2@sshaexmb1.amd.com>
	<s5h63msq6mk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C94866.CDD819CE"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE006.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 1669C1037EE
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 04:45:01 +0100 (CET)
Content-Class: urn:content-classes:message
In-Reply-To: <s5h63msq6mk.wl%tiwai@suse.de>
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

------_=_NextPart_001_01C94866.CDD819CE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> >
> > The patch uses HD Audio PCI class code to detect AMD HD Audio cards.
> >
> > Signed-off-by: Libin Yang <libin.yang@amd.com>
>=20
> Thanks, applied now.
>=20
> (BTW, your embedded patch seems broken likely by MUA.  Please fix
>  the setting or use attachments if it's difficult.)

OK. Thank you for your suggestion. Use the attachment this time.

Thanks & Regards,
Libin



------_=_NextPart_001_01C94866.CDD819CE
Content-Type: application/octet-stream; name="HDA_class_AMD.patch"
Content-Transfer-Encoding: base64
Content-Description: HDA_class_AMD.patch
Content-Disposition: attachment; filename="HDA_class_AMD.patch"

VGhlIHBhdGNoIHVzZXMgSEQgQXVkaW8gUENJIGNsYXNzIGNvZGUgdG8gZGV0ZWN0IEFNRCBIRCBB
dWRpbyBjYXJkcy4KClNpZ25lZC1vZmYtYnk6IExpYmluIFlhbmcgPGxpYmluLnlhbmdAYW1kLmNv
bT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jIGIvc291bmQvcGNpL2hk
YS9oZGFfaW50ZWwuYwppbmRleCA4ZjZjMWRmLi44Y2E0NDFjIDEwMDY0NAotLS0gYS9zb3VuZC9w
Y2kvaGRhL2hkYV9pbnRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTI5
Miw2ICsyOTIsOCBAQCBlbnVtIHsKIC8qIERlZmluZSBWSUEgSEQgQXVkaW8gRGV2aWNlIElEKi8K
ICNkZWZpbmUgVklBX0hEQUNfREVWSUNFX0lECQkweDMyODgKIAorLyogSEQgQXVkaW8gY2xhc3Mg
Y29kZSAqLworI2RlZmluZSBQQ0lfQ0xBU1NfTVVMVElNRURJQV9IRF9BVURJTwkweDA0MDMKIAog
LyoKICAqLwpAQCAtNDE1LDYgKzQxNyw3IEBAIGVudW0gewogCUFaWF9EUklWRVJfVUxJLAogCUFa
WF9EUklWRVJfTlZJRElBLAogCUFaWF9EUklWRVJfVEVSQSwKKwlBWlhfRFJJVkVSX0dFTkVSSUMs
CiAJQVpYX05VTV9EUklWRVJTLCAvKiBrZWVwIHRoaXMgYXMgbGFzdCBlbnRyeSAqLwogfTsKIApA
QCAtNDI4LDYgKzQzMSw3IEBAIHN0YXRpYyBjaGFyICpkcml2ZXJfc2hvcnRfbmFtZXNbXSBfX2Rl
dmluaXRkYXRhID0gewogCVtBWlhfRFJJVkVSX1VMSV0gPSAiSERBIFVMSSBNNTQ2MSIsCiAJW0Fa
WF9EUklWRVJfTlZJRElBXSA9ICJIREEgTlZpZGlhIiwKIAlbQVpYX0RSSVZFUl9URVJBXSA9ICJI
REEgVGVyYWRpY2kiLCAKKwlbQVpYX0RSSVZFUl9HRU5FUklDXSA9ICJIRC1BdWRpbyBHZW5lcmlj
IiwKIH07CiAKIC8qCkBAIC0yMjAzLDYgKzIyMDcsNyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBh
enhfY3JlYXRlKHN0cnVjdCBzbmRfY2FyZCAqY2FyZCwgc3RydWN0IHBjaV9kZXYgKnBjaSwKIAkJ
CWNoaXAtPnBsYXliYWNrX3N0cmVhbXMgPSBBVElIRE1JX05VTV9QTEFZQkFDSzsKIAkJCWNoaXAt
PmNhcHR1cmVfc3RyZWFtcyA9IEFUSUhETUlfTlVNX0NBUFRVUkU7CiAJCQlicmVhazsKKwkJY2Fz
ZSBBWlhfRFJJVkVSX0dFTkVSSUM6CiAJCWRlZmF1bHQ6CiAJCQljaGlwLT5wbGF5YmFja19zdHJl
YW1zID0gSUNINl9OVU1fUExBWUJBQ0s7CiAJCQljaGlwLT5jYXB0dXJlX3N0cmVhbXMgPSBJQ0g2
X05VTV9DQVBUVVJFOwpAQCAtMjQyNyw2ICsyNDMyLDExIEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZCBhenhfaWRzW10gPSB7CiAJeyBQQ0lfREVWSUNFKDB4MTBkZSwgMHgwYmQ3KSwgLmRy
aXZlcl9kYXRhID0gQVpYX0RSSVZFUl9OVklESUEgfSwKIAkvKiBUZXJhZGljaSAqLwogCXsgUENJ
X0RFVklDRSgweDY1NDksIDB4MTIwMCksIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfVEVSQSB9
LAorCS8qIEFNRCBHZW5lcmljLCBQQ0kgY2xhc3MgY29kZSBhbmQgVmVuZG9yIElEIGZvciBIRCBB
dWRpbyAqLworCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0FUSSwgUENJX0FOWV9JRCksCisJ
ICAuY2xhc3MgPSBQQ0lfQ0xBU1NfTVVMVElNRURJQV9IRF9BVURJTyA8PCA4LAorCSAgLmNsYXNz
X21hc2sgPSAweGZmZmZmZiwKKwkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfR0VORVJJQyB9
LAogCXsgMCwgfQogfTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBhenhfaWRzKTsK

------_=_NextPart_001_01C94866.CDD819CE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------_=_NextPart_001_01C94866.CDD819CE--
