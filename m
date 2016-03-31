From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Subject: [PATCH] ALSA: hda: add AMD Polaris-10/11 AZ PCI IDs
	with proper driver caps
Date: Thu, 31 Mar 2016 18:10:03 +0530
Message-ID: <1459428003-3931-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0070.outbound.protection.outlook.com [157.56.111.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 90174264EFA
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 14:37:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Alexander.Deucher@amd.com, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBjb21taXQgZml4ZXMgZ2FyYmxlZCBhdWRpbyBvbiBQb2xhcmlzLTEwLzExIHZhcmlhbnRz
CgpTaWduZWQtb2ZmLWJ5OiBNYXJ1dGhpIEJheXlhdmFyYXB1IDxtYXJ1dGhpLmJheXlhdmFyYXB1
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Ci0tLQogc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVs
LmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IDI2MjRjZmUuLmI2ODBiZTAgMTAw
NjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9o
ZGFfaW50ZWwuYwpAQCAtMjM2MSw2ICsyMzYxLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNp
X2RldmljZV9pZCBhenhfaWRzW10gPSB7CiAJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FU
SUhETUlfTlMgfCBBWlhfRENBUFNfUFJFU0VUX0FUSV9IRE1JX05TIH0sCiAJeyBQQ0lfREVWSUNF
KDB4MTAwMiwgMHhhYWU4KSwKIAkgIC5kcml2ZXJfZGF0YSA9IEFaWF9EUklWRVJfQVRJSERNSV9O
UyB8IEFaWF9EQ0FQU19QUkVTRVRfQVRJX0hETUlfTlMgfSwKKwl7IFBDSV9ERVZJQ0UoMHgxMDAy
LCAweGFhZTApLAorCSAgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9BVElIRE1JX05TIHwgQVpY
X0RDQVBTX1BSRVNFVF9BVElfSERNSV9OUyB9LAorCXsgUENJX0RFVklDRSgweDEwMDIsIDB4YWFm
MCksCisJICAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX0FUSUhETUlfTlMgfCBBWlhfRENBUFNf
UFJFU0VUX0FUSV9IRE1JX05TIH0sCiAJLyogVklBIFZUODI1MS9WVDgyMzdBICovCiAJeyBQQ0lf
REVWSUNFKDB4MTEwNiwgMHgzMjg4KSwgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZFUl9WSUEgfSwK
IAkvKiBWSUEgR0ZYIFZUNzEyMi9WWDkwMCAqLwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
