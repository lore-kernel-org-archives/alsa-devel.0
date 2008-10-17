From: Xarteras <xarteras@nostalgicnetworxx.org>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 17 Oct 2008 09:00:30 +0000
Message-ID: <48F8542E.30702@nostalgicnetworxx.org>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<loom.20081016T120322-319@post.gmane.org>	<s5h8wso3ejg.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<48F74C91.7040708@gmail.com>
	<s5hprm01v3g.wl%tiwai@suse.de>	<48F75284.1040901@gmail.com>
	<s5hljwo1u01.wl%tiwai@suse.de>	<48F75700.5060102@gmail.com>
	<s5hfxmw1syu.wl%tiwai@suse.de>	<48F75892.8000209@gmail.com>
	<s5hbpxk1shh.wl%tiwai@suse.de>	<48F7855F.6060806@gmail.com>
	<s5hbpxj6902.wl%tiwai@suse.de>	<48F83013.4060203@gmail.com>
	<s5h7i8767zu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nostalgicnetworxx.org (snowleopard.nostalgicnetworxx.org
	[87.106.211.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 5777C24413
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 11:02:49 +0200 (CEST)
In-Reply-To: <s5h7i8767zu.wl%tiwai@suse.de>
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

VGFrYXNoaSBJd2FpIHdyb3RlOgo+IEF0IEZyaSwgMTcgT2N0IDIwMDggMTA6MjY6MjcgKzA0MDAs
Cj4gVGhlIFNvdXJjZSB3cm90ZToKPj4gVGFrYXNoaSBJd2FpINC/0LjRiNC10YI6Cj4+PiBBdCBU
aHUsIDE2IE9jdCAyMDA4IDIyOjE4OjA3ICswNDAwLAo+Pj4gVGhlIFNvdXJjZSB3cm90ZToKPj4+
ICAgCj4+Pj4+PiBPay4gT3BlbkFMIHdpdGggYWxzYSBhbHNvIHNlZW0gdG8gY2F1c2UgcHJvYmxl
bXMuCj4+Pj4+PiAgICAgCj4+Pj4+PiAgICAgICAgIAo+Pj4+PiBJbiBib3RoIGNhc2VzLCBjaGVj
ayB0aGUgcGVyaW9kX3NpemUgYW5kIGJ1ZmZlcl9zaXplIHZhbHVlcyAoc2hvd24gaW4KPj4+Pj4g
dGhlIGtlcm5lbCBtZXNzYWdlLCBvciAvcHJvYy9hc291bmQvY2FyZDAvcGNtMHAvc3ViMC9od19w
YXJhbXMpLgo+Pj4+PiBBbmQsIHRyeSB0byBhcGxheSB3aXRoIHRoZXNlIHBhcmFtZXRlcnMsIHdo
ZXRoZXIgeW91IGdldCB0aGUgc2ltaWxhcgo+Pj4+PiBwcm9ibGVtLgo+Pj4+Pgo+Pj4+PiAJJSBh
cGxheSAtdiAtLXBlcmlvZC1zaXplPXh4eCAtLWJ1ZmZlci1zaXplPXl5eSBmb28ud2F2Cj4+Pj4+
Cj4+Pj4+Cj4+Pj4+IFRha2FzaGkKPj4+Pj4KPj4+Pj4gICAKPj4+Pj4gICAgICAgCj4+Pj4gSSdt
IHNvcnJ5LCBidXQgYW55IGF0dGVtcCB0byBwbGF5IGZpbGUgd2l0aCBvc3NwbGF5IHJlc3VsdHMg
aW4gY29tcGxldGUgCj4+Pj4gc3lzdGVtIGhhbmcgd2l0aCBlcnJvcjoKPj4+PiB1bmFibGUgdG8g
aGFuZGxlIE5VTEwgcG9udGVyIGRlcmVmZXJlbmNlIGF0IGFkZHJlc3MgCj4+Pj4gMDAwMDAwMDAw
MDAwMDAwOC4uLi4uKGhhbmcsIG5vIG1vcmUgb3V0cHV0KS4KPj4+PiBJIHRyaWVkIG1hbnkgd2F2
IGZvcm1hdHMuIFNvIEkgY2FuJ3QgZ2V0IGVycm9yIGxvZyBvciBwZXJpb2QgYW5kIGJ1ZmZlciAK
Pj4+PiBzaXplcywgc29ycnkuCj4+Pj4gICAgIAo+Pj4gQ2FuIGFueW9uZSBjb25maXJtIHRvIHJl
cHJvZHVjZSBPb3BzIHdpdGggT1NTIGFwcHMgKG9zc3BsYXkpPwo+Pj4KPj4+IEknbSB3b25kZXJp
bmcgd2hldGhlciB0aGlzIGhhcyBhbnl0aGluZyB0byBkbyB3aXRoIHRoZSBjYXB0dXJlLgo+Pj4g
Q2FuIHlvdSByZWNvcmQgdGhlIHNvdW5kLCBhbmQgY2hhbmdlIHRoZSBjYXB0dXJlIG1peGVyIGVs
ZW1lbnQgcHJvcGVybHk/Cj4+Pgo+Pj4KPj4+IHRoYW5rcywKPj4+Cj4+PiBUYWthc2hpCj4+Pgo+
Pj4gICAKPj4gRXJyLCBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kLiBDb3VsZCB5b3UgcGxlYXNl
IGV4cGxhaW4gc3RlcC1ieS1zdGVwPwo+IAo+IEp1c3QgcnVuIGFyZWNvcmQgdG8gcmVjb3JkIHNv
bWV0aGluZy4gIEFuZCwgY2hhbmdlIHRoZSByZWNvcmRpbmcKPiBzb3VyY2UgdmlhIG1peGVyLgo+
IAo+IFNvIGZhciwgSSBnb3QgbGl0dGxlIHJlcG9ydCBhYm91dCByZWNvcmRpbmcsIGFuZCBJJ20g
bm90IHN1cmUgd2hldGhlcgo+IGl0IHdvcmtzIGF0IGFsbC4KCkkganVzdCB0ZXN0ZWQgb3NzcGxh
eSBhbmQgYXJlY29yZC4KRm9yIG1lIGJvdGggcmVzdWx0IGluIGEgc3BvbnRhbm91cyBjcmFzaCBi
YWNrIHRvIEJJT1Mgd2l0aG91dCBsZWF2aW5nIAphbnkgdHJhY2VzIGluIHRoZSBsb2cgZmlsZXMu
CkV2ZXJ5dGhpbmcgZWxzZSB3b3JrcyBmaW5lIHNvIGZhci4KCkphbiBXb2xmCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
