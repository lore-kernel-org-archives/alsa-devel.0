From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH] ASoC: kirkwood: cleanup the external clock
	probe
Date: Mon, 21 Oct 2013 12:09:16 +0200
Message-ID: <20131021120916.3a3ffcf8@armhf>
References: <20131021094613.2a07bd79@armhf>
 <20131021080657.GU25034@n2100.arm.linux.org.uk>
 <20131021102834.768c0887@armhf>
 <20131021085200.GW25034@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by alsa0.perex.cz (Postfix) with ESMTP id AA1F5265071
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 12:09:01 +0200 (CEST)
In-Reply-To: <20131021085200.GW25034@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMSBPY3QgMjAxMyAwOTo1MjowMCArMDEwMApSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggPGxpbnV4QGFybS5saW51eC5vcmcudWs+IHdyb3RlOgoKPiA+ID4gTkFLLiAgSXQgY2FuIG9j
Y3VyLiAgCj4gPiAKPiA+IEluIHdoaWNoIGNhc2U/IEFuZCwgd2hhdCB3b3VsZCBiZSB0aGUgcmln
aHQgdHJlYXRtZW50PyAgCj4gCj4gICAgICAgICBwcml2LT5jbGsgPSBkZXZtX2Nsa19nZXQoJnBk
ZXYtPmRldiwgTlVMTCk7Cj4gICAgICAgICBwcml2LT5leHRjbGsgPSBkZXZtX2Nsa19nZXQoJnBk
ZXYtPmRldiwgImV4dGNsayIpOwo+IAo+IFN1cHBseWluZyB0aGUgZmlyc3QgY2xvY2sgdG8gdGhp
cyBkcml2ZXIgd2l0aG91dCBhIHNlcGFyYXRlICJleHRjbGsiCj4gdmlhIGNsa2RldiB3aWxsIHJl
dHVybiBpdCBhcyB0aGUgc2Vjb25kIGNsb2NrLgo+IAo+IEFnYWluLCBOQUsuICBZb3VyIGNoYW5n
ZSBpcyBhZ2FpbnN0IHRoZSBwcmluY2lwbGVzIG9mIHRoZSBjbGsgQVBJLgoKWW91IGFyZSByaWdo
dC4KCk1hcmssIHBsZWFzZSBmb3JnZXQgYWJvdXQgdGhpcyBwYXRjaC4KClRoYW5rcy4KCi0tIApL
ZW4gYXIgYydoZW50YcOxCXwJICAgICAgKiogQnJlaXpoIGhhIExpbnV4IGF0YXYhICoqCkplZgkJ
fAkJaHR0cDovL21vaW5lamYuZnJlZS5mci8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
