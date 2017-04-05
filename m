From: Paul Stone <metabagel@icloud.com>
Subject: Re:
 =?utf-8?q?mono/stereo_translation_=26_number_of_fram?=
 =?utf-8?q?es_per_period?=
Date: Wed, 05 Apr 2017 00:05:42 +0000 (GMT)
Message-ID: <8916c403-549e-41d4-bff5-972ca502f6ce@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mr11p00im-asmtp002.me.com (mr11p00im-asmtp002.me.com
 [17.110.69.253])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F7C1266F05
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 02:05:39 +0200 (CEST)
Received: from process-dkim-sign-daemon.mr11p00im-asmtp002.me.com by
 mr11p00im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 id <0ONW00O00TFD4400@mr11p00im-asmtp002.me.com> for
 alsa-devel@alsa-project.org; Wed, 05 Apr 2017 00:05:38 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

ClRoZSBkcml2ZXIgc2hvdWxkIHJlcG9ydCBvbmx5IHRob3NlIHNhbXBsZSBmb3JtYXRzIHRoYXQg
dGhlIGhhcmR3YXJlCmFjdHVhbGx5IHN1cHBvcnRzLgoKVGhlIEFMU0EgbGlicmFyeSBjYW4gZG8g
YXV0b21hdGljIHNhbXBsZSByYXRlL2Zvcm1hdCBjb252ZXJzaW9ucyAod2l0aAp0aGUgImRlZmF1
bHQiIG9yICJwbHVnaHciIGRldmljZXMpLiBIb3dldmVyLCB0aGlzIGRvZXMgbm90IHdvcmsgaWYg
eW91CmJ5cGFzcyBpdCB3aXRoIHRoZSAiaHciIGRldmljZS4KClRoYW5rcyBDbGVtZW5zLgoKT25l
wqBwcm9ibGVtIEkgYW0gaGF2aW5nIGlzIHRoYXQgbXkgZHJpdmVyIGRvZXNuJ3QgYWx3YXlzwqB3
b3JrIHdpdGggdGhlIHBsdWdodyBpbnRlcmZhY2UuCgpGb3IgaW5zdGFuY2UsIHRoZSBmb2xsb3dp
bmcgc3RlcmVvIHBpcGVsaW5lwqB3b3JrcyBmb3IgJ2h3OjMsMCcgYnV0IG91dHB1dHMgc2lsZW5j
ZSBmb3IgJ3BsdWdodzozLDAnOgoKZ3N0LWxhdW5jaCBwbGF5YmluMiB1cmk9ZmlsZTovLy9ob21l
L3Jvb3QvSWd1YXp1Lm1wMyBhdWRpby1zaW5rPSJhbHNhc2luayBkZXZpY2U9cGx1Z2h3OjMsMCIK
CkkgYW0gdXNpbmcgb2xkZXIgQUxTQSBsaWJyYXJpZXMsIHNvIG1heWJlIHRoZXJlIGlzIGEgYnVn
IHRoZXJlPwoKYWxzYS1saWItMS4wLjI3LjItcjEKCk15IGh3IGRlZmluaXRpb24gbG9va3MgbGlr
ZSB0aGlzOgoKc3RhdGljIHN0cnVjdCBzbmRfcGNtX2hhcmR3YXJlIHNuZF9pbXhfYXVkaW9fcGxh
eWJhY2tfaHcgPSB7Ci5pbmZvID0gKFNORFJWX1BDTV9JTkZPX01NQVAgfApTTkRSVl9QQ01fSU5G
T19JTlRFUkxFQVZFRCB8ClNORFJWX1BDTV9JTkZPX0JMT0NLX1RSQU5TRkVSCiksCi5mb3JtYXRz
ID0gU05EUlZfUENNX0ZNVEJJVF9TMTZfTEUsCi5yYXRlcyA9IFNORFJWX1BDTV9SQVRFXzE2MDAw
LAoucmF0ZV9taW4gPSAxNjAwMCwKLnJhdGVfbWF4ID0gMTYwMDAsCi5jaGFubmVsc19taW4gPSAy
LAouY2hhbm5lbHNfbWF4ID0gMiwKLmJ1ZmZlcl9ieXRlc19tYXggPSBQTEFZQkFDS19UT1RBTF9C
VUZGRVJfU0laRSwgLy8gdG90YWwgbnVtIGJ1ZmZlcnMgKiBidWZmZXIgc2l6ZQoucGVyaW9kX2J5
dGVzX21pbiA9IFBMQVlCQUNLX1NURVJFT19CVUZGRVJfU0laRSwKLnBlcmlvZF9ieXRlc19tYXgg
PSBQTEFZQkFDS19TVEVSRU9fQlVGRkVSX1NJWkUsCi5wZXJpb2RzX21pbiA9IDEsCi5wZXJpb2Rz
X21heCA9IFBMQVlCQUNLX1RPVEFMX05VTV9CVUZGRVJTLAp9OwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
