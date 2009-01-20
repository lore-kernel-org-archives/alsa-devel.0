From: =?utf-8?q?Diego=20E=2E=20=27Flameeyes=27=20Petten=C3=B2?=
	<flameeyes@gmail.com>
Subject: [PATCH 2/2] Make the front:idx device work for ICE1712.
Date: Tue, 20 Jan 2009 13:37:55 +0100
Message-ID: <1232455075-27712-3-git-send-email-flameeyes@gmail.com>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<1232455075-27712-2-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D04E24348
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:36:38 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so1556650fgg.44
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 04:36:38 -0800 (PST)
In-Reply-To: <1232455075-27712-2-git-send-email-flameeyes@gmail.com>
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
Cc: "=?utf-8?q?Diego=20E.=20'Flameeyes'=20Petten=C3=B2?=" <flameeyes@gmail.com>
List-Id: alsa-devel@alsa-project.org

VGhlIGRlZmF1bHQgZGVmaW5pdGlvbiBvZiBmcm9udDppZHggZm9yIElDRTE3MTItYmFzZWQgY2Fy
ZHMgZGlkbid0IHdvcmsKcHJldmlvdXNseSBiZWNhdXNlIHRoZSByb3V0ZSBwbHVnaW4gY2Fubm90
IGNoYW5nZSB0aGUgbnVtYmVyIG9mIGNoYW5uZWxzCmJldHdlZW4gdGhlIGhhcmR3YXJlIGRldmlj
ZSAod2l0aCAxMCBvciAxMiBjaGFubmVscykgYW5kIHRoZSBzb2Z0LWRldmljZQood2l0aCAyIGNo
YW5uZWxzKS4KClNpZ25lZC1vZmYtYnk6IERpZWdvIEUuICdGbGFtZWV5ZXMnIFBldHRlbsOyIDxm
bGFtZWV5ZXNAZ21haWwuY29tPgotLS0KIHNyYy9jb25mL2NhcmRzL0lDRTE3MTIuY29uZiB8ICAg
MjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9jb25mL2NhcmRzL0lD
RTE3MTIuY29uZiBiL3NyYy9jb25mL2NhcmRzL0lDRTE3MTIuY29uZgppbmRleCA1NDQ1OTIwLi5i
YjkzYzFkIDEwMDY0NAotLS0gYS9zcmMvY29uZi9jYXJkcy9JQ0UxNzEyLmNvbmYKKysrIGIvc3Jj
L2NvbmYvY2FyZHMvSUNFMTcxMi5jb25mCkBAIC0zMiwxMiArMzIsMjggQEAgSUNFMTcxMi5wY20u
ZnJvbnQuMCB7CiAJQGFyZ3MuQ0FSRCB7CiAJCXR5cGUgc3RyaW5nCiAJfQotCXR5cGUgcm91dGUK
LQl0dGFibGUuMC4wIDEKLQl0dGFibGUuMS4xIDEKLQlzbGF2ZS5wY20gewotCQl0eXBlIGh3Ci0J
CWNhcmQgJENBUkQKKwl0eXBlIGFzeW0KKwlwbGF5YmFjay5wY20geworCQl0eXBlIHJvdXRlCisJ
CXR0YWJsZS4wLjAgMQorCQl0dGFibGUuMS4xIDEKKwkJc2xhdmUucGNtIHsKKwkJCXR5cGUgaHcK
KwkJCWNhcmQgJENBUkQKKwkJfQorCQlzbGF2ZS5mb3JtYXQgUzMyX0xFCisJCXNsYXZlLmNoYW5u
ZWxzIDEwCisJfQorCWNhcHR1cmUucGNtIHsKKwkJdHlwZSByb3V0ZQorCQl0dGFibGUuMC44IDEK
KwkJdHRhYmxlLjEuOSAxCisJCXNsYXZlLnBjbSB7CisJCQl0eXBlIGh3CisJCQljYXJkICRDQVJE
CisJCX0KKwkJc2xhdmUuZm9ybWF0IFMzMl9MRQorCQlzbGF2ZS5jaGFubmVscyAxMgogCX0KIH0K
IAotLSAKMS42LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
