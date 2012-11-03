From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/9] ASoC: Only compile adav80x codec when a
	bus is defined
Date: Sat,  3 Nov 2012 23:02:26 +0100
Message-ID: <1351980150-24145-6-git-send-email-lee.jones@linaro.org>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F7442650ED
 for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2012 23:02:53 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so2352117eek.38
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 15:02:53 -0700 (PDT)
In-Reply-To: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

SWYgIUNPTkZJR19TUEkgYW5kICFDT05GSUdfSTJDKiB0aGVuIHRoZXJlIGlzIG5vIHBvaW50IGFk
ZGluZyBzdXBwb3J0CmZvciB0aGUgYWRhdjgweCBjb2RlYyBhcyBpdCByZWxpZXMgb24gYSBidXMg
dG8gb3BlcmF0ZS4gVGhpcyBwYXRjaApmaXhlcyB0aGUgYnVpbGQgd2FybmluZ3MgYmVsb3cgd2hl
biBTUEkgYW5kIEkyQyBhcmUgbm90IHNwZWNpZmllZCBpbgp0aGUgY29uZmlndXJhdGlvbi4KCnNv
dW5kL3NvYy9jb2RlY3MvYWRhdjgweC5jOjg0MjoyMjogd2FybmluZzog4oCYYWRhdjgweF9idXNf
cHJvYmXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQpzb3VuZC9z
b2MvY29kZWNzL2FkYXY4MHguYzo4NjM6MjI6IHdhcm5pbmc6IOKAmGFkYXY4MHhfYnVzX3JlbW92
ZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dCgpDYzogTWFyayBC
cm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+CkNjOiBhbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL0tjb25maWcgfCAgICAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2MvY29kZWNzL0tjb25maWcgYi9zb3VuZC9zb2MvY29kZWNzL0tjb25maWcKaW5kZXggYjky
NzU5YS4uMGQ4MTM1YSAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9LY29uZmlnCisrKyBi
L3NvdW5kL3NvYy9jb2RlY3MvS2NvbmZpZwpAQCAtMTksNyArMTksNyBAQCBjb25maWcgU05EX1NP
Q19BTExfQ09ERUNTCiAJc2VsZWN0IFNORF9TT0NfQUQxOTgwIGlmIFNORF9TT0NfQUM5N19CVVMK
IAlzZWxlY3QgU05EX1NPQ19BRDczMzExCiAJc2VsZWN0IFNORF9TT0NfQURBVTEzNzMgaWYgSTJD
Ci0Jc2VsZWN0IFNORF9TT0NfQURBVjgwWAorCXNlbGVjdCBTTkRfU09DX0FEQVY4MFggaWYgKEky
QyB8fCBJMkNfTU9EVUxFIHx8IFNQSV9NQVNURVIpCiAJc2VsZWN0IFNORF9TT0NfQURTMTE3WAog
CXNlbGVjdCBTTkRfU09DX0FLNDEwNCBpZiBTUElfTUFTVEVSCiAJc2VsZWN0IFNORF9TT0NfQUs0
NTM1IGlmIEkyQwotLSAKMS43LjkuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
