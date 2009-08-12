From: =?utf-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: [PATCH] alsa-info: Use sysfs if available instead of
	dmidecode
Date: Wed, 12 Aug 2009 16:51:41 +0300
Message-ID: <1250085101-16113-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 327B32449E
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 15:48:36 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

VXNpbmcgc3lzZnMgZm9yIGFjcXVpcmluZyBETUkgZGF0YSByZXF1aXJlcyBubyByb290IHByaXZp
bGVnZXMuIFVzZQppdCBpZiBhdmFpbGFibGUgaW5zdGVhZCBvZiBkbWlkZWNvZGUuCgpTaWduZWQt
b2ZmLWJ5OiBPemFuIMOHYcSfbGF5YW4gPG96YW5AcGFyZHVzLm9yZy50cj4KLS0tCiB1dGlscy9h
bHNhLWluZm8uc2ggfCAgICA3ICsrKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0aWxzL2Fsc2EtaW5mby5zaCBiL3V0
aWxzL2Fsc2EtaW5mby5zaAppbmRleCAwYWIxZGRmLi44ZjQwMWMwIDEwMDc1NQotLS0gYS91dGls
cy9hbHNhLWluZm8uc2gKKysrIGIvdXRpbHMvYWxzYS1pbmZvLnNoCkBAIC00MTcsNyArNDE3LDEy
IEBAIEFSVFNJTlNUPSQod2hpY2ggYXJ0c2QgMj4vZGV2L251bGx8IHNlZCAnc3xeW14vXSp8fCcg
Mj4vZGV2L251bGwpCiBKQUNLSU5TVD0kKHdoaWNoIGphY2tkIDI+L2Rldi9udWxsfCBzZWQgJ3N8
XlteL10qfHwnIDI+L2Rldi9udWxsKQogRE1JREVDT0RFPSQod2hpY2ggZG1pZGVjb2RlIDI+L2Rl
di9udWxsfCBzZWQgJ3N8XlteL10qfHwnIDI+L2Rldi9udWxsKQogCi1pZiBbIC14ICRETUlERUNP
REUgXTsgdGhlbgorI0NoZWNrIGZvciBETUkgZGF0YQoraWYgWyAtZCAvc3lzL2NsYXNzL2RtaS9p
ZCBdOyB0aGVuCisgICAgIyBObyByb290IHByaXZpbGVnZXMgYXJlIHJlcXVpcmVkIHdoZW4gdXNp
bmcgc3lzZnMgbWV0aG9kCisgICAgRE1JX1NZU1RFTV9NQU5VRkFDVFVSRVI9JChjYXQgL3N5cy9j
bGFzcy9kbWkvaWQvc3lzX3ZlbmRvciAyPi9kZXYvbnVsbCkKKyAgICBETUlfU1lTVEVNX1BST0RV
Q1RfTkFNRT0kKGNhdCAvc3lzL2NsYXNzL2RtaS9pZC9wcm9kdWN0X25hbWUgMj4vZGV2L251bGwp
CitlbGlmIFsgLXggJERNSURFQ09ERSBdOyB0aGVuCiAgICAgRE1JX1NZU1RFTV9NQU5VRkFDVFVS
RVI9JCgkRE1JREVDT0RFIC1zIHN5c3RlbS1tYW51ZmFjdHVyZXIgMj4vZGV2L251bGwpCiAgICAg
RE1JX1NZU1RFTV9QUk9EVUNUX05BTUU9JCgkRE1JREVDT0RFIC1zIHN5c3RlbS1wcm9kdWN0LW5h
bWUgMj4vZGV2L251bGwpCiBmaQotLSAKMS42LjMuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
