From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v5 0/1] ASoc: kirkwood: extend the kirkwood
 audio subsystem for DT usage
Date: Wed, 14 Aug 2013 12:27:15 +0200
Message-ID: <20130814122715.45c2d9ad@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A5126546E
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 12:25:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBEVCBzdXBwb3J0IHRvIHRoZSBraXJrd29vZC9tdmVidSBh
dWRpbyBzdWJzeXN0ZW0uCgpIaXN0b3J5CnY1CgktIGNoYW5nZSB0aGUgRFQgbmFtZSB0byAibWFy
dmVsbCxtdmVidS1hdWRpbyIKdjQKCS0gY2hhbmdlIHRoZSBEVCBuYW1lIHRvICJtcnZsLG12ZWJ1
LWF1ZGlvIgoJLSByZW1vdmUgcHJldmlvdXMgcGF0Y2hlcyAxLi4zIHdoaWNoIGhhdmUgYmVlbiBh
cHBsaWVkIGJ5IFJ1c3NlbGwgS2luZwp2MwoJLSBjaGFuZ2UgdGhlIERUIG5hbWUgZnJvbSAia2ly
a3dvb2QtaTJzIiB0byAibXZlYnUtcGNtLWF1ZGlvIgoJLSBhcHBseSB0byBsaW51eC1uZXh0Cgkt
IGxldCBOVUxMIGFzIHRoZSBpbnRlcm5hbCBpMnMgY2xvY2sgZm9yIGNvbXBhdGliaWxpdHkKCS0g
Y2hhbmdlIGkycyBleHRlcm5hbCBjbG9jayBuYW1lIHRvICJleHRjbGsiIGluc3RlYWQgb2YgImV4
dGVybmFsIgoJLSBjYW5jZWwgcHJldmlvdXMgcGF0Y2ggMS80LiBSdXNzZWxsJ3MgcGF0Y2ggc2hv
dWxkIGJlIGFwcGxpZWQgaW5zdGVhZC4KdjIKCS0gZml4IGNvbXBpbGF0aW9uIGVycm9ycwoKLS0g
CktlbiBhciBjJ2hlbnRhw7EJfAkgICAgICAqKiBCcmVpemggaGEgTGludXggYXRhdiEgKioKSmVm
CQl8CQlodHRwOi8vbW9pbmVqZi5mcmVlLmZyLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
