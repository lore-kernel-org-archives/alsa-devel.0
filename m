From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH bisect 2/2] ASoC: fsl_sai: Separately enable interrupts
 for Tx and Rx streams
Date: Wed, 2 Apr 2014 10:18:49 +0800
Message-ID: <20140402021847.GC27586@MrMyself>
References: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
 <1396322227-482-3-git-send-email-Guangyu.Chen@freescale.com>
 <20140401120715.GR2269@sirena.org.uk>
 <20140401132156.GB27586@MrMyself>
 <20140401164254.GA2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20140401164254.GA2269@sirena.org.uk>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBcHIgMDEsIDIwMTQgYXQgMDU6NDI6NTRQTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBUdWUsIEFwciAwMSwgMjAxNCBhdCAwOToyMTo1N1BNICswODAwLCBOaWNvbGluIENo
ZW4gd3JvdGU6Cj4gCj4gPiBTaXIsIEkganVzdCByZWJhc2VkIG15IGZvci1uZXh0IGJyYW5jaCBh
Z2FpbiBhbmQgZm91bmQgdGhhdCBpdCdzIG1pc3NpbmcKPiA+IHR3byBhcHBsaWVkIHBhdGNoZXM6
ICJBU29DOiBmc2xfc2FpOiBBZGQgaXNyIHRvIGRlYWwgd2l0aCBlcnJvciBmbGFnIiBhbmQKPiA+
ICJBU29DOiBmc2xfc2FpOiBJbXByb3ZlIGZzbF9zYWlfaXNyKCkiLCBzbyB0aGF0J3Mgd2h5IHRo
aXMgUEFUQ0gtMiBjb3VsZAo+ID4gbm90IGJlIGFwcGxpZWQgYWdhaW5zdCBpdCBhcyBpdCBuZWVk
cyB0aGUgbWFjcm8gdGhhdCdzIGluY2x1ZGVkIGluIHRoZQo+ID4gcGF0Y2ggIkFTb0M6IGZzbF9z
YWk6IEFkZCBpc3IgdG8gZGVhbCB3aXRoIGVycm9yIGZsYWciLgo+IAo+IEFoLCB0aG9zZSBkcm9w
cGVkIG91dCBvZiAtbmV4dCBkdWUgdG8gdGhlIG1lcmdlIHdpbmRvdy4gIEkndmUgYXBwbGllZAo+
IHlvdXIgbmV3IHBhdGNoIG5vdy4KCkkgY2FuIGZpbmQgdGhlbSBvbiB0aGUgZnNsLXNhaSB0b3Bp
YyBub3cuIFRoYW5rIHlvdS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96
bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
