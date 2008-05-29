From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - MIDI on ice1724 - real-time kernel problem
 SOLVED(?)
Date: Thu, 29 May 2008 18:14:10 +0200
Message-ID: <483ED652.6020805@insite.cz>
References: <20080520112539.81C9D2484D@alsa0.perex.cz>	<m2bq2xtixw.fsf@vador.mandriva.com>	<483847ED.8050208@gmx.de>	<483A6D6F.1050108@insite.cz>	<483A96E8.8090507@gmx.de>	<s5hbq2tunel.wl%tiwai@suse.de>	<483AE54C.3090807@gmx.de>	<483D48DE.1010105@gmx.de>
	<483E78E7.4020106@insite.cz> <20080529140349.115520@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EDF6248CD
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 18:14:19 +0200 (CEST)
In-Reply-To: <20080529140349.115520@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?TWFydGluIEtyw7xnZXI=?= <m_a_krueger@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CgpNYXJ0aW4gS3LDvGdlciB3cm90ZToKPiBQYXZlbCBIb2ZtYW4gc2NocmllYjoKPj4gSGkgTWFy
dGluLAo+PgouLi4uLi4uLi4uLi4uLi4KPiAKPiBIaSBQYXZlbCwKPiAKPiBub3cgaSdtIGNvbmZ1
c2VkLiBJIGp1c3QgY29tcGlsZWQgdGhlIGN1cnJlbnQgZGFpbHkgc25hcHNob3Qgd2l0aAo+ICIu
L2NvbmZpZ3VyZSAtLXdpdGgtaXNhcG5wPW5vIC0td2l0aC1zZXF1ZW5jZXI9eWVzIC0td2l0aC1v
c3M9bm8gCj4gLS13aXRoLWRlYnVnPXZlcmJvc2UgLS13aXRoLWNhcmRzPWljZTE3MjQiLgo+IAo+
IFRoYXQgc2hvdWxkIGdpdmUgYXMgbXVjaCBkZWJ1ZyBtZXNzYWdlcyBhcyBpIG5lZWQsIGFzIGkg
dW5kZXJzdG9vZC4gSSAKPiBnZXQgb25seSBvbmUgTWVzc2FnZSwgdGVsbGluZyBtZSB0aGF0IGlj
ZTE3MjQgaXMgdXNpbmcgdGhlIGRlZmluZWQgCj4gZWVwcm9tLiBBZnRlciB1c2luZyB0aGUgbWlk
aSBvdXRwdXQgcG9ydCwgdGhlcmUgaXMgbm8gbW9yZSBtZXNzYWdlIGluIAo+IGFueSBsb2cgYXQg
YWxsLgoKVGhhdCBpcyBPSywgaXQgbWVhbnMgdGhlIGxvb3AtZGV0ZWN0aW9uIGNvZGUgZG9lcyBu
b3Qga2ljayBpbiwgaS5lLiAKdGhlcmUgaXMgbm8gcHJvYmxlbSB3aXRoIGNsZWFyaW5nIGludGVy
cnVwdCBzdGF0dXMgYml0cy4KCj4gCj4gRHVlIHRvIHRoaXMsIGl0IGlzIHJlYWxseSBoYXJkIHRv
IHVuZGVyc3RhbmQgdGhlIHByb2JsZW0sIGZvciBtZSBpdCAKPiBsb29rcyBsaWtlIGEgY29tcGxl
dGUgZnJlZXplLiBJZiBpIHdvdWxkIGdldCAianVzdCIgYSBoZWF2eSBvdmVybG9hZCwgCj4gdGhl
IG51bWxvY2sgc2hvdWxkIHN0aWxsIHJlYWN0IHdpdGhpbiAxMCBtaW51dGVzLCBhbmQgdGhlIGNw
dSBjb29sZXIgCj4gc2hvdWxkIGJlIGxvdWRlci4gQm90aCBvZiB0aGlzIHNob3VsZCBhbHNvIGhh
cHBlbiBkdXJpbmcgYW4gaXJxIGZsb29kLCAKPiBpZiBpIHVuZGVyc3Rvb2QgdGhhdCByaWdodC4K
Ck15IElSUSBmbG9vZCBsb2FkZWQgdGhlIFBDIGhlYXZpbHksIGJ1dCBJIGNvdWxkIHN0aWxsIHN3
aXRjaCB3aW5kb3dzIGFuZCAKbW92ZSBtb3VzZSBhcm91bmQsIHdpdGggbG9uZyBkZWxheXMuIFlv
dXJzIGxvb2tzIGxpa2UgYSByZWFsIGZyZWV6ZS4KCj4gCj4gRG8geW91IGhhdmUgYW55IGlkZWEg
aG93IHRvIGZpbmQgb3V0IHdoYXRzIGhhcHBlbmluZyB0aGVyZT8gCgpJIGp1c3QgYWRkIGRlYnVn
IHByaW50aydzIHRvIG1ham9yIGNvZGUgcG9pbnRzIGFsbCB0aGUgd2F5IGRvd24gdG8gCmJvdHRv
bSBmdW5jdGlvbnMuIEl0IHRha2VzIG1hbnkgY29tcGlsaW5nIGFuZCByZWJvb3RpbmcgKGFmdGVy
IGZyZWV6ZXMpLiAKICBVbmZvcnR1bmF0ZWx5IEkgZG8gbm90IGtub3cgb2YgYW55IG90aGVyIHdh
eSB0byBodW50IHRoZSBidWcgZG93bi4KCkdvb2QgbHVjaywKClBhdmVsLgoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
