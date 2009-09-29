From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 0/3] Usage of AM_SILENT_RULES and small cleanup
Date: Tue, 29 Sep 2009 23:48:18 +0200
Message-ID: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 719EC103861
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 23:48:46 +0200 (CEST)
Received: from p5b034cd2.dip.t-dialin.net ([91.3.76.210] helo=excalibur)
	by sirius.lasnet.de with esmtpsa
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 #1)
	id 1MskYe-0000g9-4G by authid <stefan@sostec.de> with cram_md5
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2009 23:48:46 +0200
Received: from stefan by excalibur with local (Exim 4.69)
	(envelope-from <stefan@excalibur.local>) id 1MskYc-0000JR-VI
	for alsa-devel@alsa-project.org; Tue, 29 Sep 2009 23:48:26 +0200
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

SGVsbG8uCgpXaGlsZSB3b3JraW5nIHdpdGggYWxzYS1saWIgdG8gZ2V0IHNjZW5hcmlvcyBpbiBz
aGFwZSBhbmQgc3VibWl0dGVkIGxhdGVyIEkKYWRkZWQgc3VwcG9ydCBmb3IgdGhlIG5ldyBhdXRv
bWFrZSBmZWF0dXJlIEFNX1NJTEVOVF9SVUxFUyBhbmQgZGlkIHNvbWUgc21hbGwKY2xlYW51cHMu
CgpbUEFUQ0ggMS8zXSBjdnNjb21waWxlOiBSZW1vdmUgaW4gZmF2b3VyIG9mIGdpdGNvbXBpbGUu
Ckkgc2VlIG5vIHJlYXNvbiB0byBrZWVwIHRoaXMgYXJvdW5kIHdoZW4gQ1ZTIGlzIG5vIGxvbmdl
ciB1c2VkIGFuZCBnaXRjb21waWxlCmRvZXMgcmVwbGFjZSBpdC4gU29tZXRoaW5nIEkgbWlzcyBo
ZXJlPwoKW1BBVENIIDIvM10gY29uZmlndXJlLmluOiBBZGQgbTQgY2hlY2sgZm9yIG5ldyBBTV9T
SUxFTlRfUlVMRVMKVGhlIGtidWlsZCBsaWtlIG91dHB1dCBtYWtlcyBpdCBhIGxvdCBlYXNpZXIg
dG8gZm9sbG93IHRoZSBjb21waWxlIGFuZCBsaW5raW5nCnByb2Nlc3MsIGF0IGxlYXN0IGluIG15
IG9waW5pb24uIEl0IGlzIGF2YWlsYWJsZSB3aXRoIGF1dG9tYWtlIDEuMTEgYW5kIHdlIHVzZSBh
Cm00IG1hY3JvIGhlcmUgdG8gb25seSB1c2UgaXQgd2hlbiBpdCBpcyBhdmFpbGFibGUuCgpbUEFU
Q0ggMy8zXSBjb250cm9sOiBSZW1vdmUgdW51c2VkIHZhcmlhYmxlLgpGb3VuZCB3aGlsZSByZWFs
bHkgc2VlaW5nIHdoYXQgaXMgZ29pbmcgb24gdGhhbmtzIHRvIEFNX1NJTEVOVF9SVUxFUzogOykK
ClRoZXJlIGFyZSBhbHNvIHNvbWUgdW51c2VkIHBhcmFtdGVyIGFuZCBhIGZ1bmN0aW9uIGFyb3Vu
ZC4gSSBkb24ndCBrbm93IGhvdyB5b3UKZ3V5cyBwcmVmZXIgdG8gaGFuZGxlIHRoaXMgaW4gdGhl
IEFMU0EgcHJvamVjdCBzbyBJIGRpZCBub3QgcHJlcGFyZSBwYXRjaGVzIGZvcgp0aGlzIHlldC4g
TGV0IG1lIGtub3cgaWYgeW91IHdhbnQgc29tZSBmb3IgaXQuCgpwY21fcm91dGUuYzogSW4gZnVu
Y3Rpb24g4oCYc25kX3BjbV9yb3V0ZV9jb252ZXJ0MV9tYW554oCZOgpwY21fcm91dGUuYzozNTA6
IHdhcm5pbmc6IOKAmHNyY+KAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVu
Y3Rpb24KcGNtX3JhdGVfbGluZWFyLmM6IEluIGZ1bmN0aW9uIOKAmGdldF9zdXBwb3J0ZWRfcmF0
ZXPigJk6CnBjbV9yYXRlX2xpbmVhci5jOjQwODogd2FybmluZzogdW51c2VkIHBhcmFtZXRlciDi
gJhyYXRl4oCZCnBjbV9yYXRlX2xpbmVhci5jOiBJbiBmdW5jdGlvbiDigJhsaW5lYXJfZHVtcOKA
mToKcGNtX3JhdGVfbGluZWFyLmM6NDE2OiB3YXJuaW5nOiB1bnVzZWQgcGFyYW1ldGVyIOKAmHJh
dGXigJkKcGNtX3JhdGVfbGluZWFyLmM6IEluIGZ1bmN0aW9uIOKAmF9zbmRfcGNtX3JhdGVfbGlu
ZWFyX29wZW7igJk6CnBjbV9yYXRlX2xpbmVhci5jOjQzNTogd2FybmluZzogdW51c2VkIHBhcmFt
ZXRlciDigJh2ZXJzaW9u4oCZCmFsaXNwLmM6MjM3OiB3YXJuaW5nOiDigJhpbmNyZWZfdHJlZV9l
eHBsaWNpdOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZAoKcmVnYXJkcwpTdGVmYW4gU2NobWlkdApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
