From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] mfd: arizona: Update DT binding to
 support hpdet channel
Date: Thu, 30 Apr 2015 11:09:47 +0100
Message-ID: <20150430100947.GE1815@x1>
References: <1430357878-22859-1-git-send-email-ideal.song@samsung.com>
 <1430357878-22859-3-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FF64265B58
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 12:09:53 +0200 (CEST)
Received: by wizk4 with SMTP id k4so12914734wiz.1
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 03:09:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430357878-22859-3-git-send-email-ideal.song@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Inha Song <ideal.song@samsung.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, cw00.choi@samsung.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAzMCBBcHIgMjAxNSwgSW5oYSBTb25nIHdyb3RlOgoKPiBUaGlzIHBhdGNoIGFkZCBk
ZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgdGhlIHBkYXRhIG5lZWRlZCB0byBjb25maWd1cmUKPiB0
aGUgQWNjZXNzb3J5IERldGVjdCBNb2RlIHNlbGVjdCB3aGVuIEhlYWRwaG9uZSBkZXRlY3Rpb24u
Cj4gCj4gU2lnbmVkLW9mZi1ieTogSW5oYSBTb25nIDxpZGVhbC5zb25nQHNhbXN1bmcuY29tPgo+
IC0tLQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FyaXpvbmEudHh0
IHwgNiArKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKQWNrZWQtYnk6
IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+Cgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FyaXpvbmEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21mZC9hcml6b25hLnR4dAo+IGluZGV4IDdiZDEyNzMuLjdkZGVkYTgg
MTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hcml6
b25hLnR4dAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXJp
em9uYS50eHQKPiBAQCAtNDksNiArNDksMTIgQEAgT3B0aW9uYWwgcHJvcGVydGllczoKPiAgICAg
IGlucHV0IHNpbmdhbHMuIElmIHZhbHVlcyBsZXNzIHRoYW4gdGhlIG51bWJlciBvZiBpbnB1dCBz
aWduYWxzLCBlbGVtZW50cwo+ICAgICAgdGhhdCBoYXMgbm90IGJlZW4gc3BlY2lmZWQgYXJlIHNl
dCB0byAwIGJ5IGRlZmF1bHQuCj4gIAo+ICsgIC0gd2xmLGhwZGV0LWNoYW5uZWwgOiBIZWFkcGhv
bmUgZGV0ZWN0aW9uIGNoYW5uZWwuCj4gKyAgICBBUklaT05BX0FDQ0RFVF9NT0RFX0hQTCBvciAx
IC0gSGVhZHBob25lIGRldGVjdCBtb2RlIGlzIHNldCB0byBIUERFVEwKPiArICAgIEFSSVpPTkFf
QUNDREVUX01PREVfSFBSIG9yIDIgLSBIZWFkcGhvbmUgZGV0ZWN0IG1vZGUgaXMgc2V0IHRvIEhQ
REVUUgo+ICsgICAgSWYgdGhpcyBub2RlIGlzIG5vdCBtZW50aW9uZWQgb3IgaWYgdGhlIHZhbHVl
IGlzIHVua25vd24sIHRoZW4KPiArICAgIGhlYWRwaG9uZSBkZXRlY3Rpb24gbW9kZSBpcyBzZXQg
dG8gSFBERVRMLgo+ICsKPiAgICAtIERDVkRELXN1cHBseSwgTUlDVkRELXN1cHBseSA6IFBvd2Vy
IHN1cHBsaWVzLCBvbmx5IG5lZWQgdG8gYmUgc3BlY2lmaWVkIGlmCj4gICAgICB0aGV5IGFyZSBi
ZWluZyBleHRlcm5hbGx5IHN1cHBsaWVkLiBBcyBjb3ZlcmVkIGluCj4gICAgICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3JlZ3VsYXRvci50eHQKCi0tIApMZWUg
Sm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8u
b3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzog
RmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
