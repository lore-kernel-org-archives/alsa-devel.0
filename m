From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v10 2/9] ASoC: kirkwood: check the DAI type from the DAI name
Date: Mon, 19 Jan 2015 18:38:34 +0100
Message-ID: <c5ce41929ab14a3d200a6237181715539712ef07.1421782532.git.moinejf@free.fr>
References: <cover.1421782532.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1421782532.git.moinejf@free.fr>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Andrew Jackson <Andrew.Jackson@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

V2hlbiB0aGUgREFJcyBhcmUgY3JlYXRlZCBmcm9tIGEgZ3JhcGggb2YgcG9ydHMsIHRoZWlyIHR5
cGVzIGFyZSBub3QgdGllZAp0byB0aGVpciBJRC4KClNpZ25lZC1vZmYtYnk6IEplYW4tRnJhbmNv
aXMgTW9pbmUgPG1vaW5lamZAZnJlZS5mcj4KLS0tCiBzb3VuZC9zb2Mva2lya3dvb2Qva2lya3dv
b2QtaTJzLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5j
IGIvc291bmQvc29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5jCmluZGV4IDYyZDljMTIuLjM1N2Y5
NjMgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYworKysgYi9z
b3VuZC9zb2Mva2lya3dvb2Qva2lya3dvb2QtaTJzLmMKQEAgLTI2Myw3ICsyNjMsNyBAQCBzdGF0
aWMgaW50IGtpcmt3b29kX2kyc19wbGF5X3RyaWdnZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFt
ICpzdWJzdHJlYW0sCiAJY2FzZSBTTkRSVl9QQ01fVFJJR0dFUl9TVEFSVDoKIAkJLyogY29uZmln
dXJlICovCiAJCWN0bCA9IHByaXYtPmN0bF9wbGF5OwotCQlpZiAoZGFpLT5pZCA9PSAwKQorCQlp
ZiAoZGFpLT5uYW1lWzBdID09ICdpJykKIAkJCWN0bCAmPSB+S0lSS1dPT0RfUExBWUNUTF9TUERJ
Rl9FTjsJLyogaTJzICovCiAJCWVsc2UKIAkJCWN0bCAmPSB+S0lSS1dPT0RfUExBWUNUTF9JMlNf
RU47CS8qIHNwZGlmICovCkBAIC0zMzEsNyArMzMxLDcgQEAgc3RhdGljIGludCBraXJrd29vZF9p
MnNfcmVjX3RyaWdnZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAJY2Fz
ZSBTTkRSVl9QQ01fVFJJR0dFUl9TVEFSVDoKIAkJLyogY29uZmlndXJlICovCiAJCWN0bCA9IHBy
aXYtPmN0bF9yZWM7Ci0JCWlmIChkYWktPmlkID09IDApCisJCWlmIChkYWktPm5hbWVbMF0gPT0g
J2knKQogCQkJY3RsICY9IH5LSVJLV09PRF9SRUNDVExfU1BESUZfRU47CS8qIGkycyAqLwogCQll
bHNlCiAJCQljdGwgJj0gfktJUktXT09EX1JFQ0NUTF9JMlNfRU47CQkvKiBzcGRpZiAqLwotLSAK
Mi4xLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
