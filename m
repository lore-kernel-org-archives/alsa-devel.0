From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: [PATCH] opti931: additional check for OPL3 device
Date: Fri, 14 Sep 2007 16:35:01 +0200
Message-ID: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1497_17590335.1189780501974"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E79E244E4
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 16:35:05 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so672082nzf
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 07:35:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_Part_1497_17590335.1189780501974
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds additional check for OPL3 device. I found that PNP
region returned
by the card is 0x380 - 0x38f but the OPL3 device is located at 0x388
(standard FM
device address). The driver checks start of the range (0x380) which is
incorrect.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The same problem appears on two cards I have with Opti chipset:
opti931 and opti933.
If someone can test if the opti92x PnP has the same problem I would be grateful.

Regards,
Krzysztof

------=_Part_1497_17590335.1189780501974
Content-Type: text/x-patch; name="opti-fm.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="opti-fm.diff"
X-Attachment-Id: f_f6ksp8d5

ZGlmZiAtdXJwIGxpbnV4LTIuNi4yMi5vbGQvc291bmQvaXNhL29wdGk5eHgvb3B0aTkyeC1hZDE4
NDguYyBsaW51eC0yLjYuMjIvc291bmQvaXNhL29wdGk5eHgvb3B0aTkyeC1hZDE4NDguYwotLS0g
bGludXgtMi42LjIyLm9sZC9zb3VuZC9pc2Evb3B0aTl4eC9vcHRpOTJ4LWFkMTg0OC5jCTIwMDct
MDktMDggMTM6Mzc6NTkuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjIvc291bmQvaXNh
L29wdGk5eHgvb3B0aTkyeC1hZDE4NDguYwkyMDA3LTA5LTEzIDIzOjU0OjAyLjAwMDAwMDAwMCAr
MDIwMApAQCAtMTg5MCwxMiArMTg5MCwyNiBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzbmRfb3B0
aTl4eF9wcm9iZShzCiAJCQl9CiAJCX0KICNlbmRpZgkvKiAhT1BUaTkzWCAqLwotCQlpZiAoIW9w
bDMgJiYgc25kX29wbDNfY3JlYXRlKGNhcmQsCi0JCQkJCSAgICAgY2hpcC0+Zm1fcG9ydCwKLQkJ
CQkJICAgICBjaGlwLT5mbV9wb3J0ICsgMiwKLQkJCQkJICAgICBPUEwzX0hXX0FVVE8sIDAsICZv
cGwzKSA8IDApIHsKLQkJCXNuZF9wcmludGsoS0VSTl9XQVJOSU5HICJubyBPUEwgZGV2aWNlIGF0
IDB4JWx4LTB4JWx4XG4iLAotCQkJCSAgIGNoaXAtPmZtX3BvcnQsIGNoaXAtPmZtX3BvcnQgKyA0
IC0gMSk7CisJCWlmICghb3BsMykgeworCQkJZXJyb3IgPSBzbmRfb3BsM19jcmVhdGUoY2FyZCwK
KwkJCQkJCWNoaXAtPmZtX3BvcnQsCisJCQkJCQljaGlwLT5mbV9wb3J0ICsgMiwKKwkJCQkJCU9Q
TDNfSFdfQVVUTywgMCwgJm9wbDMpOworCQkJaWYgKGVycm9yIDwgMCAmJiBjaGlwLT5mbV9wb3J0
ID09IDB4MzgwKSB7CisJCQkJZXJyb3IgPSBzbmRfb3BsM19jcmVhdGUoY2FyZCwKKwkJCQkJCQlj
aGlwLT5mbV9wb3J0ICsgOCwKKwkJCQkJCQljaGlwLT5mbV9wb3J0ICsgMTAsCisJCQkJCQkJT1BM
M19IV19BVVRPLCAwLCAmb3BsMyk7CisJCQl9CisJCQlpZiAoZXJyb3IgPCAwKSB7CisJCQkJc25k
X3ByaW50ayhLRVJOX1dBUk5JTkcKKwkJCQkJICAgIm5vIE9QTCBkZXZpY2UgYXQgMHglbHgtMHgl
bHggIgorCQkJCQkgICAib3IgMHglbHgtMHglbHhcbiIsCisJCQkJCSAgIGNoaXAtPmZtX3BvcnQs
CisJCQkJCSAgIGNoaXAtPmZtX3BvcnQgKyA0IC0gMSwKKwkJCQkJICAgY2hpcC0+Zm1fcG9ydCAr
IDgsCisJCQkJCSAgIGNoaXAtPmZtX3BvcnQgKyAxMiAtIDEpOworCQkJfQogCQl9CiAJCWlmIChv
cGwzKSB7CiAjaWZkZWYgQ1M0MjMxCg==
------=_Part_1497_17590335.1189780501974
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_1497_17590335.1189780501974--
