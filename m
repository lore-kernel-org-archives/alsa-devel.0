From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] ALSA - au88x0 - Add buffer bytes constraints
Date: Mon, 25 Apr 2011 20:01:46 +0800
Message-ID: <BANLkTimwtSsSnwjN5E6aQeqbGSkLV9fUzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151747347cc4d8e604a1bcf845
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EF7F81037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Apr 2011 14:01:47 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1572693fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2011 05:01:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--00151747347cc4d8e604a1bcf845
Content-Type: text/plain; charset=ISO-8859-1

Add buffer bytes constraints so that
snd_pcm_hw_params_set_buffer_time_near() can return the buffer time for
au88x0

This allow application such as gstreamer and wine which use
snd_pcm_hw_params_set_buffer_time_near()  since au88x0 require special
contraint period bytes of power 2

playback

https://bugs.launchpad.net/ubuntu/+source/alsa-lib/+bug/52396

capture

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=575013

--00151747347cc4d8e604a1bcf845
Content-Type: application/octet-stream;
	name="0001-Add-buffer-bytes-constraint-for-au88x0.patch"
Content-Disposition: attachment;
	filename="0001-Add-buffer-bytes-constraint-for-au88x0.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmxam0kw0

RnJvbSAwNGMzN2U2NDBjMDMxNTNmYzYwNTgxMGE1ZjJkNTY4ODk3ODkyODgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBNb24sIDI1IEFwciAyMDExIDEyOjA1OjQ1ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gQUxTQSAtIGF1ODh4MCAtIEFkZCBidWZmZXIgYnl0ZXMgY29uc3RyYWludHMKClRoaXMgYWxs
b3cgYXBwbGljYXRpb24gc3VjaCBhcyBnc3RyZWFtZXIgYW5kIHdpbmUgd2hpY2ggdXNlIHNuZF9w
Y21faHdfcGFyYW1zX3NldF9idWZmZXJfdGltZV9uZWFyKCkgd29uJ3QgZmFpbCBhbnkgbW9yZSAK
c2luY2Ugc291bmQgY2hpcHMgcmVxdWlyZSBzcGVjaWFsIGNvbnRhaW50IHBvd2VyIDIgcGVyaW9k
IGJ5dGVzCgoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVhZC52b3J0ZXgyQGdt
YWlsLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvYXU4OHgwL2F1ODh4MF9wY20uYyBiL3Nv
dW5kL3BjaS9hdTg4eDAvYXU4OHgwX3BjbS5jCmluZGV4IDU0MzlkNjYuLmFkMWI5YzQgMTAwNjQ0
Ci0tLSBhL3NvdW5kL3BjaS9hdTg4eDAvYXU4OHgwX3BjbS5jCisrKyBiL3NvdW5kL3BjaS9hdTg4
eDAvYXU4OHgwX3BjbS5jCkBAIC00NCwxMCArNDQsMTAgQEAgc3RhdGljIHN0cnVjdCBzbmRfcGNt
X2hhcmR3YXJlIHNuZF92b3J0ZXhfcGxheWJhY2tfaHdfYWRiID0gewogCS5jaGFubmVsc19taW4g
PSAxLAogCS5jaGFubmVsc19tYXggPSAyLAogCS5idWZmZXJfYnl0ZXNfbWF4ID0gMHgxMDAwMCwK
LQkucGVyaW9kX2J5dGVzX21pbiA9IDB4MSwKKwkucGVyaW9kX2J5dGVzX21pbiA9IDB4MjAsCiAJ
LnBlcmlvZF9ieXRlc19tYXggPSAweDEwMDAsCiAJLnBlcmlvZHNfbWluID0gMiwKLQkucGVyaW9k
c19tYXggPSAzMiwKKwkucGVyaW9kc19tYXggPSAxMDI0LAogfTsKIAogI2lmbmRlZiBDSElQX0FV
ODgyMApAQCAtMTQwLDYgKzE0MCw5IEBAIHN0YXRpYyBpbnQgc25kX3ZvcnRleF9wY21fb3Blbihz
dHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKIAkJCQkJU05EUlZfUENNX0hXX1BB
UkFNX1BFUklPRF9CWVRFUykpIDwgMCkKIAkJcmV0dXJuIGVycjsKIAorICAgICAJc25kX3BjbV9o
d19jb25zdHJhaW50X3N0ZXAocnVudGltZSwgMCwKKwkJCQkJU05EUlZfUENNX0hXX1BBUkFNX0JV
RkZFUl9CWVRFUywgNjQpOworCiAJaWYgKFZPUlRFWF9QQ01fVFlQRShzdWJzdHJlYW0tPnBjbSkg
IT0gVk9SVEVYX1BDTV9XVCkgewogI2lmbmRlZiBDSElQX0FVODgyMAogCQlpZiAoVk9SVEVYX1BD
TV9UWVBFKHN1YnN0cmVhbS0+cGNtKSA9PSBWT1JURVhfUENNX0EzRCkgewotLSAKMS42LjAuNgoK
--00151747347cc4d8e604a1bcf845
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00151747347cc4d8e604a1bcf845--
