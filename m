From: Xarteras <xarteras@nostalgicnetworxx.org>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 17 Oct 2008 09:50:27 +0000
Message-ID: <48F85FE3.4060704@nostalgicnetworxx.org>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<loom.20081016T120322-319@post.gmane.org>	<s5h8wso3ejg.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<48F74C91.7040708@gmail.com>
	<s5hprm01v3g.wl%tiwai@suse.de>	<48F75284.1040901@gmail.com>
	<s5hljwo1u01.wl%tiwai@suse.de>	<48F75700.5060102@gmail.com>
	<s5hfxmw1syu.wl%tiwai@suse.de>	<48F75892.8000209@gmail.com>
	<s5hbpxk1shh.wl%tiwai@suse.de>	<48F7855F.6060806@gmail.com>
	<s5hbpxj6902.wl%tiwai@suse.de>	<48F83013.4060203@gmail.com>
	<s5h7i8767zu.wl%tiwai@suse.de>	<48F8542E.30702@nostalgicnetworxx.org>
	<s5hwsg7zib3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nostalgicnetworxx.org (snowleopard.nostalgicnetworxx.org
	[87.106.211.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D3B110385F
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 11:52:42 +0200 (CEST)
In-Reply-To: <s5hwsg7zib3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org

VGFrYXNoaSBJd2FpIHdyb3RlOgo+IEF0IEZyaSwgMTcgT2N0IDIwMDggMDk6MDA6MzAgKzAwMDAs
Cj4gWGFydGVyYXMgd3JvdGU6Cj4+IFRha2FzaGkgSXdhaSB3cm90ZToKPj4+IEF0IEZyaSwgMTcg
T2N0IDIwMDggMTA6MjY6MjcgKzA0MDAsCj4+PiBUaGUgU291cmNlIHdyb3RlOgo+Pj4+IFRha2Fz
aGkgSXdhaSDQv9C40YjQtdGCOgo+Pj4+PiBBdCBUaHUsIDE2IE9jdCAyMDA4IDIyOjE4OjA3ICsw
NDAwLAo+Pj4+PiBUaGUgU291cmNlIHdyb3RlOgo+Pj4+PiAgIAo+Pj4+Pj4+PiBPay4gT3BlbkFM
IHdpdGggYWxzYSBhbHNvIHNlZW0gdG8gY2F1c2UgcHJvYmxlbXMuCj4+Pj4+Pj4+ICAgICAKPj4+
Pj4+Pj4gICAgICAgICAKPj4+Pj4+PiBJbiBib3RoIGNhc2VzLCBjaGVjayB0aGUgcGVyaW9kX3Np
emUgYW5kIGJ1ZmZlcl9zaXplIHZhbHVlcyAoc2hvd24gaW4KPj4+Pj4+PiB0aGUga2VybmVsIG1l
c3NhZ2UsIG9yIC9wcm9jL2Fzb3VuZC9jYXJkMC9wY20wcC9zdWIwL2h3X3BhcmFtcykuCj4+Pj4+
Pj4gQW5kLCB0cnkgdG8gYXBsYXkgd2l0aCB0aGVzZSBwYXJhbWV0ZXJzLCB3aGV0aGVyIHlvdSBn
ZXQgdGhlIHNpbWlsYXIKPj4+Pj4+PiBwcm9ibGVtLgo+Pj4+Pj4+Cj4+Pj4+Pj4gCSUgYXBsYXkg
LXYgLS1wZXJpb2Qtc2l6ZT14eHggLS1idWZmZXItc2l6ZT15eXkgZm9vLndhdgo+Pj4+Pj4+Cj4+
Pj4+Pj4KPj4+Pj4+PiBUYWthc2hpCj4+Pj4+Pj4KPj4+Pj4+PiAgIAo+Pj4+Pj4+ICAgICAgIAo+
Pj4+Pj4gSSdtIHNvcnJ5LCBidXQgYW55IGF0dGVtcCB0byBwbGF5IGZpbGUgd2l0aCBvc3NwbGF5
IHJlc3VsdHMgaW4gY29tcGxldGUgCj4+Pj4+PiBzeXN0ZW0gaGFuZyB3aXRoIGVycm9yOgo+Pj4+
Pj4gdW5hYmxlIHRvIGhhbmRsZSBOVUxMIHBvbnRlciBkZXJlZmVyZW5jZSBhdCBhZGRyZXNzIAo+
Pj4+Pj4gMDAwMDAwMDAwMDAwMDAwOC4uLi4uKGhhbmcsIG5vIG1vcmUgb3V0cHV0KS4KPj4+Pj4+
IEkgdHJpZWQgbWFueSB3YXYgZm9ybWF0cy4gU28gSSBjYW4ndCBnZXQgZXJyb3IgbG9nIG9yIHBl
cmlvZCBhbmQgYnVmZmVyIAo+Pj4+Pj4gc2l6ZXMsIHNvcnJ5Lgo+Pj4+Pj4gICAgIAo+Pj4+PiBD
YW4gYW55b25lIGNvbmZpcm0gdG8gcmVwcm9kdWNlIE9vcHMgd2l0aCBPU1MgYXBwcyAob3NzcGxh
eSk/Cj4+Pj4+Cj4+Pj4+IEknbSB3b25kZXJpbmcgd2hldGhlciB0aGlzIGhhcyBhbnl0aGluZyB0
byBkbyB3aXRoIHRoZSBjYXB0dXJlLgo+Pj4+PiBDYW4geW91IHJlY29yZCB0aGUgc291bmQsIGFu
ZCBjaGFuZ2UgdGhlIGNhcHR1cmUgbWl4ZXIgZWxlbWVudCBwcm9wZXJseT8KPj4+Pj4KPj4+Pj4K
Pj4+Pj4gdGhhbmtzLAo+Pj4+Pgo+Pj4+PiBUYWthc2hpCj4+Pj4+Cj4+Pj4+ICAgCj4+Pj4gRXJy
LCBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kLiBDb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gc3Rl
cC1ieS1zdGVwPwo+Pj4gSnVzdCBydW4gYXJlY29yZCB0byByZWNvcmQgc29tZXRoaW5nLiAgQW5k
LCBjaGFuZ2UgdGhlIHJlY29yZGluZwo+Pj4gc291cmNlIHZpYSBtaXhlci4KPj4+Cj4+PiBTbyBm
YXIsIEkgZ290IGxpdHRsZSByZXBvcnQgYWJvdXQgcmVjb3JkaW5nLCBhbmQgSSdtIG5vdCBzdXJl
IHdoZXRoZXIKPj4+IGl0IHdvcmtzIGF0IGFsbC4KPj4gSSBqdXN0IHRlc3RlZCBvc3NwbGF5IGFu
ZCBhcmVjb3JkLgo+PiBGb3IgbWUgYm90aCByZXN1bHQgaW4gYSBzcG9udGFub3VzIGNyYXNoIGJh
Y2sgdG8gQklPUyB3aXRob3V0IGxlYXZpbmcgCj4+IGFueSB0cmFjZXMgaW4gdGhlIGxvZyBmaWxl
cy4KPj4gRXZlcnl0aGluZyBlbHNlIHdvcmtzIGZpbmUgc28gZmFyLgo+IAo+IE9LLCB0aGVuIHRo
ZSBwcm9ibGVtIGlzIGNvbnNpc3RlbnQuCj4gSXQncyBhIGJpdCB0b3VnaCB0byBjaGVjayB3aXRo
b3V0IGEgcHJvcGVyIGxvZy4KPiBIb3cgYWJvdXQgcnVubmluZyB3aXRoIHN0cmFjZT8gIFdoYXQg
aXMgdGhlIGxhc3Qgc3lzY2FsbCBiZWZvcmUgdGhlCj4gZGVhZCBlbmQ/CgpJIGp1c3Qgbm90aWNl
ZCBJIHN0aWxsIGhhZCBhIGRzbm9vcC9kbWl4IHNldCB1cCBhbmQgcmVuYW1lZCBhc291bmQuY29u
ZiAKZm9yIHJldGVzdGluZy4KTm93IGF0IGxlYXN0IGFyZWNvcmQgZG9lc24ndCBjcmFzaCB0aGUg
c3lzdGVtIGFueW1vcmUsIGJ1dCBpdCBvbmx5IApyZXR1cm5zIHNpbGVuY2UgKERlc3BpdGUgYSBt
aWMgYmVpbmcgY29ubmVjdGVkKS4KCm9zc3BsYXkgc3RpbGwgY3Jhc2hlcyB0aG91Z2ggYW5kIHN0
cmFjZSBpc24ndCBvZiBtdWNoIHVzZS4KUnVubmluZyBvc3NwbGF5IGNhdXNlcyBhIHN5cyByZXNl
dCBzbyBmYXN0IHRoZSBzdHJhY2Ugb3V0cHV0IGNhbm5vdCBldmVuIApiZSBmbHVzaGVkIHRvIGRp
c2sgYW55bW9yZSwgbmV2ZXJsZXNzIGJlIHVwIGxvbmcgZW5vdWdoIHRvIHJlYWQgaXQgb24gCnRo
ZSBzY3JlZW4uCgpKYW4gV29sZgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
