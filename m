From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 09/11] sound/core: add IEC958 channel status helper
Date: Wed, 1 Apr 2015 08:58:24 +0100
Message-ID: <20150401075824.GX24899@n2100.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
 <551A5B2F.50203@rock-chips.com>
 <20150331091329.GP24899@n2100.arm.linux.org.uk>
 <551B5213.8070902@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <551B5213.8070902@rock-chips.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Yakir <ykk@rock-chips.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBBcHIgMDEsIDIwMTUgYXQgMTA6MDQ6MDNBTSArMDgwMCwgWWFraXIgd3JvdGU6Cj4g
SGkgUnVzc2VsbCwKPiAKPiDlnKggMjAxNS8zLzMxIDE3OjEzLCBSdXNzZWxsIEtpbmcgLSBBUk0g
TGludXgg5YaZ6YGTOgo+ID5BcyBmb3IgdGhlIGNoYW5uZWwgbnVtYmVyLCB0aGlzIGlzIGludGVu
dGlvbmFsbHkgbGVmdCB0byB0aGUgZHJpdmVyIC0KPiA+bW9zdCBjYXNlcyBJJ3ZlIGZvdW5kIGVp
dGhlciB0aGUgZHJpdmVyIGlzbid0IGludGVyZXN0ZWQsIG9yIHdoZXJlCj4gPnRoZXkgYXJlIGlu
dGVyZXN0ZWQgKHRoZSBvbmx5IGNhc2UgSSBrbm93IG9mIGlzIG15IGR3X2hkbWkgYWhiIGF1ZGlv
Cj4gPmRyaXZlciksIGl0J3MgbW9yZSBhcHByb3ByaWF0ZSB0byBnZW5lcmF0ZSBhIGJhc2VsaW5l
IGNoYW5uZWwgc3RhdHVzLAo+ID5hbmQgbGV0IHRoZSBkcml2ZXIgaXRlcmF0ZSBvdmVyIHRoZSBj
aGFubmVscyBhZGRpbmcgdGhlIGFwcHJvcHJpYXRlCj4gPmNoYW5uZWwgbnVtYmVyIGluLgo+IE9r
YXksIGFncmVlIHdpdGggeW91IHRvIGtlZXAgYmFzZWxpbmUgY2hhbm5lbCBzdGF0dXMsIGJ1dCBz
ZWVtcyBkd19oZG1pCj4gaTJzIGF1ZGlvIGFyZSBpbnRlcmVzdGVkIGluIGNoYW5ubGUgbnVtYmVy
ICh0byBmaWxsIGluIHNjaG5sIHJlc2lnZXRlcnMpLgoKQ29ycmVjdCAtIGJ1dCBpdCdzIHBvaW50
bGVzcyBoYXZpbmcgaXQgaW4gdGhpcyBoZWxwZXIgYXMgSSBleHBsYWluZWQuClBsZWFzZSByZWFk
IG15IGR3X2hkbWktYWhiLWF1ZGlvIGNvZGUgdG8gc2VlIHdoeS4KCkl0IHdvdWxkIGJlIHdhc3Rl
ZnVsIHRvIG1lbXNldCB0aGUgc3RydWN0dXJlIGJhY2sgdG8gemVybywgb25seSB0bwpyZS1maWxs
IGl0IHdpdGggZXhhY3RseSB0aGUgc2FtZSBkYXRhIGV4Y2VwdCBmb3IgdGhlIGNoYW5uZWwgbnVt
YmVyLgoKLS0gCkZUVEMgYnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmU6IGN1cnJlbnRseSBhdCAx
MC41TWJwcyBkb3duIDQwMGticHMgdXAKYWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5uZXQuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
