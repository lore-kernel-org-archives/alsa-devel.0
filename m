From: Christian Hergert <christian.hergert@gmail.com>
Subject: PATCH: ALSA - hda - Add support for Dell E6400 docking
	station
Date: Mon, 16 Nov 2009 15:20:32 -0800
Message-ID: <6d4a25b10911161520i50a677d6m78d057d900676469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502cc018ade170478854135
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 72E0010381F
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 00:20:33 +0100 (CET)
Received: by pwj11 with SMTP id 11so8052078pwj.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 15:20:32 -0800 (PST)
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

--00504502cc018ade170478854135
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I made a patch to fix bug 4657[1] on the tracker.  I'm fairly certain that
it isn't the correct approach but would like some feedback on what that
would be.

The power-mappings in patch_sigmatel.c seem to allow you to flip multiple
bits.  In the case of the Dell docking station, you need to enable some bits
while disabling others.  Therefore, instead of using the power mappings I
just hacked in a quick check to work for the hardware I have on hand.  If
there is a proper way to fix this that I have missed, I'll be more than
happy to fix the patch appropriately.

[1] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4657

Regards,
--
Christian Hergert

--00504502cc018ade170478854135
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Add-support-for-Dell-E6400-docking-station.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Add-support-for-Dell-E6400-docking-station.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g23uycoo0

RnJvbSA1NjUwYjFlNzIyMTgyYzFkZGQ3ZGNhZWY2ODg1MDMzYTBlZjEwYjljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gSGVyZ2VydCA8Y2hyaXNAZHJvbmVsYWJzLmNv
bT4KRGF0ZTogTW9uLCAxNiBOb3YgMjAwOSAxNDoyNzoyMiAtMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IEFMU0E6IGhkYSAtIEFkZCBzdXBwb3J0IGZvciBEZWxsIEU2NDAwIGRvY2tpbmcgc3RhdGlvbgoK
QnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvYWxzYS1kcml2ZXIvK2J1Zy8zODM3
NTYKQnVnTGluazogaHR0cHM6Ly9idWd0cmFjay5hbHNhLXByb2plY3Qub3JnL2Fsc2EtYnVnL3Zp
ZXcucGhwP2lkPTQ2NTcKCk11dGUgdGhlIGludGVybmFsIHNwZWFrZXJzIHdoZW4gdGhlIG91dHB1
dCBqYWNrIG9uIHRoZQpkb2NraW5nIHN0YXRpb24gaXMgZW5hYmxlZC4KLS0tCiBzb3VuZC9wY2kv
aGRhL3BhdGNoX3NpZ21hdGVsLmMgfCAgIDExICsrKysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNp
L2hkYS9wYXRjaF9zaWdtYXRlbC5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCmlu
ZGV4IDBmNmMzM2QuLmVkNWQ5YjEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2ln
bWF0ZWwuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKQEAgLTQ1NjcsNiAr
NDU2NywxNyBAQCBzdGF0aWMgdm9pZCBzdGFjX3RvZ2dsZV9wb3dlcl9tYXAoc3RydWN0IGhkYV9j
b2RlYyAqY29kZWMsIGhkYV9uaWRfdCBuaWQsCiAJZWxzZQogCQl2YWwgfD0gaWR4OwogCisJaWYg
KGNvZGVjLT52ZW5kb3JfaWQgPT0gMHgxMTFkNzZiMiAmJgorCQkJc3BlYy0+Ym9hcmRfY29uZmln
ID09IFNUQUNfREVMTF9NNF8xICYmCisJCQlpZHggPT0gNCkgeworCQkvKiB0aGUgaW50ZXJuYWwg
c3BlYWtlcnMgbmVlZCB0byBiZSBtdXRlZCB3aGVuIHRoZQorCQkgKiBkb2NraW5nIHN0YXRpb24g
b3V0cHV0IGlzIGVuYWJsZWQuICovCisJCWlmIChlbmFibGUpCisJCQl2YWwgfD0gMjsKKwkJZWxz
ZQorCQkJdmFsICY9IH4yOworCX0KKwogCS8qIHBvd2VyIGRvd24gdW51c2VkIG91dHB1dCBwb3J0
cyAqLwogCXNuZF9oZGFfY29kZWNfd3JpdGUoY29kZWMsIGNvZGVjLT5hZmcsIDAsIDB4N2VjLCB2
YWwpOwogfQotLSAKMS42LjMuMwoK
--00504502cc018ade170478854135
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502cc018ade170478854135--
