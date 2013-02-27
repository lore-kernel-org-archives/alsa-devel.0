From: Arkadiusz =?utf-8?q?Mi=C5=9Bkiewicz?= <arekm@maven.pl>
Subject: Thinkpad T400 - internal mic doesn't work,
	can't set CAPTURE - schematics included
Date: Wed, 27 Feb 2013 18:58:06 +0100
Message-ID: <201302271858.07005.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f176.google.com (mail-ea0-f176.google.com
 [209.85.215.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FE7A265B97
 for <alsa-devel@alsa-project.org.>; Wed, 27 Feb 2013 18:58:09 +0100 (CET)
Received: by mail-ea0-f176.google.com with SMTP id a13so67395eaa.7
 for <alsa-devel@alsa-project.org.>; Wed, 27 Feb 2013 09:58:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CkhpLAoKTXkgVGhpbmtwYWQgVDQwMCAoMjc2NENUTyBtb2RlbCkgZG9lc24ndCBoYXZlIGFiaWxp
dHkgdG8gc2V0IENBUFRVUkUgb24gCm1pY3JvcGhvbmUgaW5wdXRzIHdpdGggYWxzYS4gTW9zdCBs
aWtlbHkgc29tZSBxdWlyayBpcyBtaXNzaW5nLgoKVGhlIGxhcHRvcCBoYXMgaW50ZXJuYWwgbWlj
cm9waG9uZSwgbWljcm9waG9uZSBpbiBpbnB1dCwgaGVhZHBob25lcyBvdXQgb3V0cHV0IAphbmQg
MiBpbnRlcm5hbCBzcGVha2Vycy4gVGhhdCdzIGFsbC4KCklzIHVzZXMgQ29uZXhhbnQgQ1gyMDU2
MV8xNVogaW50ZXJuYWxseSBhbmQgdGhlcmUgaXMgZGV0YWlsZWQgVDQwMCBzY2hlbWF0aWMgCmF2
YWlsYWJsZToKaHR0cDovL2t5dGh1YXRwaGFuY3VuZy5jb20vZG93bmxvYWQvbGVub3ZvLXRoaW5r
cGFkLXQ0MDAtc2NoZW1hdGljLQpkaWFncmFtLmh0bWw/ZGwKKGZvciBhdWRpbyBsb29rIGFyb3Vu
ZCBwYWdlIDQzKS4KCktlcm5lbHMgMy43LngsIGZyZXNoIDMuOCAtIG5vIGx1Y2suIFRyaWVkIGV2
ZW4gbGludXgtbmV4dCBmcm9tIHRvZGF5IGJ1dCBpdCAKZGllcyBlYXJseSBvbiBhbHNhIHVucmVs
YXRlZCBpc3N1ZXMuCgpJJ3ZlIHRyaWVkIG1vZGVsIG9wdGlvbnMgbGFwdG9wLCBocCwgaHAtZHY2
NzM2LCBocC03MDAsIHRvc2hpYmEsIGlkZWFwYWQsIAphdXRvLiBOb25lIG9mIHRoZXNlIHdvcmsg
ZmluZS4gV2l0aCBtb2RlbD1ocC03MDAgSSBjYW4gc2V0IENBUFRVUkUgYnV0IGl0IApkb2Vzbid0
IHdvcmsgKHNpbGVudCBhdWRpbyBpcyBjYXB0dXJlZCB1c2luZyBhcmVjb3JkIG9yIGluIGdvb2ds
ZSBoYW5nb3V0KS4gCkV4dGVybmFsIG1pYyBjb25uZWN0ZWQgYWxzbyBkb2Vzbid0IHdvcmsgd2l0
aCB0aGVzZSBzZXR1cHMuCgpodHRwOi8vd3d3LmFsc2EtcHJvamVjdC5vcmcvZGIvP2Y9Mzk0ZmY0
Y2RjYTMzZTc1YzhhNDcyMDNkNDJiODlkOGRlMzZkZWNhNyAKWzMuOCBrZXJuZWxdCgpodHRwOi8v
d3d3LmFsc2EtcHJvamVjdC5vcmcvZGIvP2Y9MzAyODc3ZTUwZjk5ODM1MDc1ZDAzODIwN2Y2ZGIw
ZGZkODk4NzNiMCAKWzMuNyBrZXJuZWxdCgpUaGlua3BhZCBpcyAyNzY0Q1RPIG1vZGVsIGV4YWN0
bHkuIAoKSSBjYW4gdGVzdCB2YXJpb3VzIGhhY2tzLCBwYXRjaGVzIGV0YyBlYXNpbHkuIENvdWxk
IHNvbWVvbmUgbG9vayBhdCBzY2hlbWF0aWMgCmFuZCBwcm92aWRlIHF1aXJrcyB0byB0ZXN0PwoK
VGhhbmtzIQotLSAKQXJrYWRpdXN6IE1pxZtraWV3aWN6LCBhcmVrbSAvIG1hdmVuLnBsCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
