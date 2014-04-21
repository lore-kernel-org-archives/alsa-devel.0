From: Santhosh N M <santo4ul@gmail.com>
Subject: Re: Disabling DAPM from ASoC framework
Date: Mon, 21 Apr 2014 14:51:53 +0530
Message-ID: <CAGziFADQpP-BGDgxN=doo2M=DOri1jVTCVB9eVoCSadvnkbEpw@mail.gmail.com>
References: <CAGziFAC5k3faFMGtWov5jWf14aRXn7K1-Y_f=WfZ0t6jzSGsOA@mail.gmail.com>
 <CAEN5SX-xRcHVbMpyV=RzyF5pnbBH4BfZijnQy51Zk3ecEeGpzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
 [209.85.216.176])
 by alsa0.perex.cz (Postfix) with ESMTP id C8BE2261631
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 11:22:34 +0200 (CEST)
Received: by mail-qc0-f176.google.com with SMTP id m20so3816310qcx.35
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 02:22:33 -0700 (PDT)
In-Reply-To: <CAEN5SX-xRcHVbMpyV=RzyF5pnbBH4BfZijnQy51Zk3ecEeGpzg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?6IOh5rSq5YW1?= <huhb04@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhhbmtzIGh1aGIwNCwgZm9yIHlvdXIgcXVpY2sgcmVzcG9uc2UuIEl0IHdvcmtzIQoKVGhpcyBh
cHByb2FjaCBsb29rcyBtdWNoIGNsZWFuZXIgdGhhbiB3aGF0IEkgd2FzIG9yaWdpbmFsbHkgdHJ5
aW5nLgoKQmVzdCBSZWdhcmRzLApTYW4KCk9uIE1vbiwgQXByIDIxLCAyMDE0IGF0IDE6NTIgUE0s
IOiDoea0quWFtSA8aHVoYjA0QGdtYWlsLmNvbT4gd3JvdGU6Cgo+Cj4gMTogIGRvbid0IGNhbGwg
IHNuZF9zb2NfZGFwbV9uZXdfY29udHJvbHMoKSAgIHNuZF9zb2NfZGFwbV9hZGRfcm91dGVzKCkg
aW4KPiB5b3VyIGNvZGVjIGRyaXZlcgo+IDI6IGRvbid0IHNldCAic3RhdGljIHN0cnVjdCBzbmRf
c29jX2NvZGVjX2RyaXZlcnt9IiAgIC5kYXBtX3dpZGdldHMKPiAuZGFwbV9yb3V0ZXMKPgo+Cj4K
PiAyMDE0LTA0LTIxIDE1OjQwIEdNVCswODowMCBTYW50aG9zaCBOIE0gPHNhbnRvNHVsQGdtYWls
LmNvbT46Cj4KPj4gIEhpLAo+Pgo+PiAgICBJJ20gYSBuZXdiaWUgdG8gQUxTQS9BU29DIGZyYW1l
d29yay4gTGV0cyBzYXkgdGhlcmUgaXMgYSByZXF1aXJlbWVudCwKPj4gd2hlcmUsIHRoZSBhcHBs
aWNhdGlvbiAodXNlciBzcGFjZSkgdGFrZXMgdGhlIHJlc3BvbnNpYmlsaXR5IHRvIHN3aXRjaAo+
PiBPTi9PRkYgdGhlIHBvd2VyIGNvbXBvbmVudHMgb2YgdGhlIGNvZGVjIGNvbXBvbmVudHMgKHVz
aW5nIEFMU0EgTWl4ZXIKPj4gSW50ZXJmYWNlKS4KPj4KPj4gICAgSW4gdGhpcyBjYXNlLCBpcyB0
aGVyZSBhIHN0YW5kYXJkIHdheSB0byBkaXNhYmxlIERBUE0gZnJvbSBBU29DPyBPbmUKPj4gd2F5
Cj4+IEkgc2VlIChhbmQgZm91bmQgdG8gYmUgd29ya2luZykgaXMgc2V0dGluZyBudW1fZGFwbV93
aWRnZXRzPTAKPj4gYW5kIG51bV9kYXBtX3JvdXRlcz0wIGJlZm9yZSBpbnZva2luZyBzbmRfc29j
X3JlZ2lzdGVyX2NvZGVjKCkKPj4KPj4gVGhhbmtzIGluIGFkdmFuY2UgZm9yIHlvdXIgaGVscC4K
Pj4KPj4gQmVzdCBSZWdhcmRzLAo+PiBTYW4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4gQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKPj4gQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCj4+IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCj4+Cj4KPgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
