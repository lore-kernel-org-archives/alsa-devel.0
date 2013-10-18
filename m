From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH RESEND] ASoC: kirkwood: prefer external clock over internal
 clock
Date: Fri, 18 Oct 2013 20:34:52 +0200
Message-ID: <20131018203452.177f8693@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

V2hlbiB0aGVyZSBpcyBhbiBleHRlcm5hbCBjbG9jaywgYWx3YXlzIHVzZSB0aGlzIG9uZS4KVGhp
cyBwcmV2ZW50cyB0aGUgdHdvIERvdmUgYXVkaW8gZGV2aWNlcyB0byB1c2UgdGhlIHNhbWUgRENP
IGNsb2NrCmF0IGRpZmZlcmVudCByYXRlcy4KClNpZ25lZC1vZmYtYnk6IEplYW4tRnJhbmNvaXMg
TW9pbmUgPG1vaW5lamZAZnJlZS5mcj4KLS0tClRoaXMgcGF0Y2ggd2FzIGluaXRpYWx5IHByb3Bv
c2VkIGJ5IFJ1c3NlbGwsIGJ1dCB3aXRoIGFuIGVycm9uZW91cwonZWxzZSBpZicuCi0tLQogc291
bmQvc29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2tpcmt3
b29kL2tpcmt3b29kLWkycy5jIGIvc291bmQvc29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5jCmlu
ZGV4IDBmM2Q3M2QuLjhhYzg5ZjUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9raXJrd29vZC9raXJr
d29vZC1pMnMuYworKysgYi9zb3VuZC9zb2Mva2lya3dvb2Qva2lya3dvb2QtaTJzLmMKQEAgLTEw
Myw3ICsxMDMsNyBAQCBzdGF0aWMgdm9pZCBraXJrd29vZF9zZXRfcmF0ZShzdHJ1Y3Qgc25kX3Nv
Y19kYWkgKmRhaSwKIHsKIAl1aW50MzJfdCBjbGtzX2N0cmw7CiAKLQlpZiAocmF0ZSA9PSA0NDEw
MCB8fCByYXRlID09IDQ4MDAwIHx8IHJhdGUgPT0gOTYwMDApIHsKKwlpZiAoSVNfRVJSKHByaXYt
PmV4dGNsaykpIHsKIAkJLyogdXNlIGludGVybmFsIGRjbyBmb3IgdGhlIHN1cHBvcnRlZCByYXRl
cwogCQkgKiBkZWZpbmVkIGluIGtpcmt3b29kX2kyc19kYWkgKi8KIAkJZGV2X2RiZyhkYWktPmRl
diwgIiVzOiBkY28gc2V0IHJhdGUgPSAlbHVcbiIsCgoKLS0gCktlbiBhciBjJ2hlbnRhw7EJfAkg
ICAgICAqKiBCcmVpemggaGEgTGludXggYXRhdiEgKioKSmVmCQl8CQlodHRwOi8vbW9pbmVqZi5m
cmVlLmZyLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
