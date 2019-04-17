From: thet <parenthetical@halfshavedyaks.xyz>
Subject: RME Fireface alsa driver - improved but still not
	working
Date: Wed, 17 Apr 2019 21:59:23 +0100
Message-ID: <663f96f0-8652-ce5e-7572-ade544ff3cd3@halfshavedyaks.xyz>
References: <53dc5ff5-bee5-5998-dcd4-1dd1f926c857@halfshavedyaks.xyz>
 <20181211204344.GA16818@workstation>
 <a61bd3e8-0ace-3ef1-ffa4-f56c3c67fd31@halfshavedyaks.xyz>
 <alpine.DEB.2.21.1812172247580.1336@laptop>
 <c4a1e138-64b8-7926-2927-8af99134e817@halfshavedyaks.xyz>
 <20181219042203.GA8794@workstation>
 <e3b5b326-e418-eea2-fe77-a1c828d5cb09@halfshavedyaks.xyz>
 <20190105085024.GA29901@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-02.1984.is (mail-02.1984.is [185.112.145.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82452F8071F
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2019 22:59:31 +0200 (CEST)
Received: from localhost
 by mail-02.1984.is with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <parenthetical@halfshavedyaks.xyz>)
 id 1hGreP-00052C-9y
 for alsa-devel@alsa-project.org; Wed, 17 Apr 2019 20:59:25 +0000
In-Reply-To: <20190105085024.GA29901@workstation>
Content-Language: en-GB
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SSBub3RpY2UgdGhhdCB0aGUgUk1FIGZpcmVmYWNlIGFsc2EgZHJpdmVyIHNuZC1maXJlZmFjZSBu
b3cgd29ya3MgYQpsaXR0bGUgc2luY2UgNC4xOSBJIHRoaW5rCgpJbiBlYXJsaWVyIGtlcm5lbHMg
NC4xOCBhbmQgYmVsb3cgdGhlIG1pZGkgd29ya2VkIG9uIHRoZSBGRjQwMCBidXQgbm8KYXVkaW8g
YW5kIHRoZSBGRjgwMCB3YXMgbm90IHN1cHBvcnRlZCBhdCBhbGwuCgpub3cgdGhlIG1pZGkgd29y
a3Mgb24gYm90aCBGRjQwMCBhbmQgRkY4MDAgYW5kIHRoZSBhdWRpbyB3b3JrcyBhIGxpdHRsZS4K
CnRoZSBrZXJuZWwgSSBhbSB1c2luZyBpcyA1LjAuMC03LjEtbGlxdW9yaXgtYW1kNjQgIzEgWkVO
IFNNUCBQUkVFTVBUCmxpcXVvcml4IDUuMC02dWJ1bnR1MX5iaW9uaWMgKDIwMTktMDQtMDYpIHg4
Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAoKKEkgYW0gYWxzbyBoYXBweSB0byB0ZXN0IHdp
dGggYSBkaWZmZXJlbnQga2VybmVsIGJ1dCBJIGFtIG5vdCBhYmxlIHRvCmNvbXBpbGUgaXQgbXlz
ZWxmIHNvIGl0IHdvdWxkIG5lZWQgdG8gYmUgYXZhaWxhYmxlIGluIGEgcmVwby4pCgpUaGUgYXVk
aW8gaG93ZXZlciBkb2VzIG5vdCB3b3JrIGNvcnJlY3RseS4gSXQgaXMgdW5zdGFibGUsIHNvbWV0
aW1lcyBpdAp3b3JrcyBmb3IgYSB3aGlsZSBidXQgb3RoZXIgdGltZXMgaXQgZ2xpdGNoZXMgb3Ig
ZXZlbiBiZWNvbWVzIHdpbGRseQpkaXN0b3J0ZWQuCgpJIGFtIG5vdCBhIGtlcm5lbCBkZXZlbG9w
ZXIgYXQgYWxsIC0gYnV0IEkgYW0gd2lsbGluZyB0byB0ZXN0IGFuZCBwb3N0CmxvZ3MgaWYgaXQg
aGVscHMgLSBpZiBhbnlvbmUgaGVyZSBjYW4gZ2l2ZSBtZSBjbGVhciBpbnN0cnVjdGlvbnMgYWJv
dXQKaG93IHRvIHRlc3QuCgpBbHNvIC0gaXMgaXQgcG9zc2libGUgZm9yIGEgdXNlciB0byBkaXNh
YmxlIHRoZSBhdWRpbyBwYXJ0IG9mIHRoZSBkcml2ZXIKYnV0IHN0aWxsIHVzZSB0aGUgbWlkaSBw
YXJ0PwoKVGhpcyB3b3VsZCBhbGxvdyBtZSB0byB1c2UgdGhlIGF1ZGlvIHdpdGggRkZBRE8gYW5k
IHRoZSBtaWRpIHdpdGggYWxzYS4KRkZBRE8gZG9lc24ndCBzdXBwb3J0IG1pZGkgb24gdGhlc2Ug
ZGV2aWNlcyBzbyBpdCBpcyBncmVhdCB0aGF0IGFsc2EKZG9lcyAtwqAgYnV0IHJ1bm5pbmcgYm90
aCBhdCBvbmNlIGNhbiBiZSB0cmlja3kgYXMgdGhlIGFsc2EgZHJpdmVyIGRvZXMKbm90IGxldCBG
RkFETyB0YWtlIG92ZXIgdGhlIGRldmljZSBvbmNlIGl0IGhhcyBpdC4KCkNhbiBJIHN1Z2dlc3Qg
dGhhdCBtYXliZSB0aGUgYXVkaW8gYW5kIG1pZGkgZHJpdmVycyBmb3IgdGhlc2UgZGV2aWNlcwpj
b3VsZCBiZSBtYWRlIGFzIHNlcGFyYXRlIGtlcm5lbCBtb2R1bGVzPyBUaGVuIGlmIG9uZSBwYXJ0
IGhhcyBwcm9ibGVtcwppdCBuZWVkIG5vdCBiZSBsb2FkZWQuIEknbSBub3Qgc3VyZSBpZiB0aGlz
IGlzIGZlYXNpYmxlIGJ1dCBpZiBpdCBpcyBpdAp3b3VsZCBhbGxvdyBtb3JlIGZsZXhpYmlsaXR5
IGluIGhvdyB0aGV5IGFyZSB1c2VkLgoKdGhhbmtzCgpUaGV0CgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
