From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH RFC 06/13] ASoC: kirkwood: combine kirkwood-i2s and
 kirkwood-dma drivers
Date: Mon, 5 Aug 2013 12:13:07 +0200
Message-ID: <20130805121307.555cb419@armhf>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCAwNCBBdWcgMjAxMyAyMDoyNzowMyArMDEwMApSdXNzZWxsIEtpbmcgPHJtaytrZXJu
ZWxAYXJtLmxpbnV4Lm9yZy51az4gd3JvdGU6Cgo+IFRoZXNlIHJlYWxseSBzaG91bGQgYmUgYSBz
aW5nbGUgZHJpdmVyIGJlY2F1c2UgdGhleSdyZSBmdWxseSBpbnRlZ3JhdGVkCj4gaW4gaGFyZHdh
cmUuICBNYWtlIHRoZW0gc28uCj4gCj4gU2lnbmVkLW9mZi1ieTogUnVzc2VsbCBLaW5nIDxybWsr
a2VybmVsQGFybS5saW51eC5vcmcudWs+Cj4gLS0tCj4gIGFyY2gvYXJtL21hY2gtZG92ZS9jb21t
b24uYyAgICAgICAgICB8ICAgIDQgKystLQo+ICBhcmNoL2FybS9tYWNoLWtpcmt3b29kL2NvbW1v
bi5jICAgICAgfCAgIDI0ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+ICBzb3VuZC9zb2Mva2ly
a3dvb2QvS2NvbmZpZyAgICAgICAgICAgfCAgICA1IC0tLS0tCj4gIHNvdW5kL3NvYy9raXJrd29v
ZC9NYWtlZmlsZSAgICAgICAgICB8ICAgIDQgKy0tLQo+ICBzb3VuZC9zb2Mva2lya3dvb2Qva2ly
a3dvb2QtZG1hLmMgICAgfCAgIDMwICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICBz
b3VuZC9zb2Mva2lya3dvb2Qva2lya3dvb2QtaTJzLmMgICAgfCAgIDIxICsrKysrKysrKysrKysr
KystLS0tLQo+ICBzb3VuZC9zb2Mva2lya3dvb2Qva2lya3dvb2Qtb3BlbnJkLmMgfCAgICA0ICsr
LS0KPiAgc291bmQvc29jL2tpcmt3b29kL2tpcmt3b29kLXQ1MzI1LmMgIHwgICAgNCArKy0tCj4g
IHNvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC5oICAgICAgICB8ICAgIDIgKysKPiAgOSBmaWxl
cyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA2MyBkZWxldGlvbnMoLSkKCVtzbmlwXQoKR2xh
ZCB0byBzZWUgeW91IGdvdCBteSBwYXRjaCwgYnV0IHdoeSBkaWQgeW91IGNoYW5nZWQgYWxsIHRo
ZSBuYW1lcz8KClJlcGxhY2luZyAia2lya3dvb2QtcGNtLWF1ZGlvIiBieSAia2lya3dvb2QtaTJz
IiBzaG91bGQgYmUgZW5vdWdoLgoKLS0gCktlbiBhciBjJ2hlbnRhw7EJfAkgICAgICAqKiBCcmVp
emggaGEgTGludXggYXRhdiEgKioKSmVmCQl8CQlodHRwOi8vbW9pbmVqZi5mcmVlLmZyLwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
