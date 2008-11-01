From: "Michael Gruber" <lists.mg@googlemail.com>
Subject: hda-intel - Add digout to ALC880 F1734 model
Date: Sat, 1 Nov 2008 13:43:25 +0100
Message-ID: <74d457500811010543x42103855n5f68136fd564b1bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_43113_13748039.1225543405467"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id B541B2488E
	for <alsa-devel@alsa-project.org>; Sat,  1 Nov 2008 13:43:26 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so1754369wfg.23
	for <alsa-devel@alsa-project.org>; Sat, 01 Nov 2008 05:43:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_43113_13748039.1225543405467
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Backstory:
The patch "ALSA: hda - Add infrastructure for dynamic stream allocation"
http://git.alsa-project.org/?p=alsa-kmirror.git;a=commit;h=ae32c9fe811fed22715342494c08a11fabc87762
broke the detection of my card. With this patch applied the dmesg output is:

[ 3761.464838] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
low) -> IRQ 16
[ 3761.464863] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[ 3761.499927] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[ 3761.499945] HDA Intel: probe of 0000:00:1b.0 failed with error -22

When I loaded the module with model=... then it would work only for some
models, but not for others. I found out that the ones which worked were the
ones with a digout. I added the digout to the F1734 model and now it is
working again.

I can't test if the digout is really working because I lack the hardware, but
when I turn on the IEC958 control in the mixer then red light is emitted from
my headphone port.

I will attach a patch that adds digout to this model because this seems the
right thing to do, but I don't know whether there is something wrong with the
aforementioned patch that caused my problem in the first place.

------=_Part_43113_13748039.1225543405467
Content-Type: text/x-diff; name=F1734_digout.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fn08uid50
Content-Disposition: attachment; filename=F1734_digout.patch

aGRhLWludGVsIC0gQWRkIGRpZ291dCB0byBBTEM4ODAgRjE3MzQgbW9kZWwKCkFkZHMgZGlnb3V0
IHRvIEFMQzg4MCBGMTczNCBtb2RlbAoKU2lnbmVkLW9mZi1ieTogTWljaGFlbCBHcnViZXIgPGxp
c3RzLm1nQGdvb2dsZW1haWwuY29tPgoKCgpkaWZmIC0tZ2l0IGEvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMgYi9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCBmYjhmYWU5Li45NDRkOTQxIDEw
MDY0NAotLS0gYS9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYwpAQCAtMzI4NCw2ICszMjg0LDcgQEAgc3RhdGljIHN0cnVjdCBhbGNfY29uZmlnX3By
ZXNldCBhbGM4ODBfcHJlc2V0c1tdID0gewogCQkJCWFsYzg4MF9waW5fZjE3MzRfaW5pdF92ZXJi
cyB9LAogCQkubnVtX2RhY3MgPSBBUlJBWV9TSVpFKGFsYzg4MF9mMTczNF9kYWNfbmlkcyksCiAJ
CS5kYWNfbmlkcyA9IGFsYzg4MF9mMTczNF9kYWNfbmlkcywKKwkJLmRpZ19vdXRfbmlkID0gQUxD
ODgwX0RJR09VVF9OSUQsCiAJCS5ocF9uaWQgPSAweDAyLAogCQkubnVtX2NoYW5uZWxfbW9kZSA9
IEFSUkFZX1NJWkUoYWxjODgwXzJfamFja19tb2RlcyksCiAJCS5jaGFubmVsX21vZGUgPSBhbGM4
ODBfMl9qYWNrX21vZGVzLAo=
------=_Part_43113_13748039.1225543405467
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_43113_13748039.1225543405467--
