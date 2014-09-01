From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 2/2] mfd: arizona: Update DT binding to
 support INn_MODE init_data
Date: Mon, 1 Sep 2014 09:34:00 +0100
Message-ID: <20140901083400.GD7374@lee--X1>
References: <1409365639-5320-1-git-send-email-ideal.song@samsung.com>
 <1409365639-5320-3-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f45.google.com (mail-qa0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC5A262607
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 10:34:08 +0200 (CEST)
Received: by mail-qa0-f45.google.com with SMTP id f12so4629011qad.4
 for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2014 01:34:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409365639-5320-3-git-send-email-ideal.song@samsung.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, sameo@linux.intel.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, cw00.choi@samsung.com, broonie@kernel.org, galak@codeaurora.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCAzMCBBdWcgMjAxNCwgSW5oYSBTb25nIHdyb3RlOgoKPiBUaGlzIHBhdGNoIHVwZGF0
ZSBEVCBiaW5kaW5nIHRvIHN1cHBvcnQgSU5uX01PREUgaW5pdF9kYXRhLiBFYWNoCj4gaW5wdXQg
c2lnbmFsIHBhdGggY2FuIGJlIGNvbmZpZ3VyYXRlZCBlaXRoZXIgYXMgYSBBbmFsb2d1ZSBvcgo+
IERpZ2l0YWwgdXNpbmcgdGhlIElObl9NT0RFIHJlZ2lzdGVycy4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBJbmhhIFNvbmcgPGlkZWFsLnNvbmdAc2Ftc3VuZy5jb20+Cj4gUmV2aWV3ZWQtYnk6IENoYXJs
ZXMgS2VlcGF4IDxja2VlcGF4QG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4KPiAtLS0KPiAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hcml6b25hLnR4dCB8IDcgKysr
KysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpBcHBsaWVkLCB0aGFua3Mu
Cgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2Fy
aXpvbmEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hcml6b25h
LnR4dAo+IGluZGV4IDVjN2U3MjMuLjdiZDEyNzMgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hcml6b25hLnR4dAo+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXJpem9uYS50eHQKPiBAQCAtNDIsNiArNDIsMTMg
QEAgT3B0aW9uYWwgcHJvcGVydGllczoKPiAgICAgIHRoZSBjaGlwIGRlZmF1bHQgd2lsbCBiZSB1
c2VkLiAgSWYgcHJlc2VudCBleGFjdGx5IGZpdmUgdmFsdWVzIG11c3QKPiAgICAgIGJlIHNwZWNp
ZmllZC4KPiAgCj4gKyAgLSB3bGYsaW5tb2RlIDogQSBsaXN0IG9mIElObl9NT0RFIHJlZ2lzdGVy
IHZhbHVlcywgd2hlcmUgbiBpcyB0aGUgbnVtYmVyCj4gKyAgICBvZiBpbnB1dCBzaWduYWxzLiBW
YWxpZCB2YWx1ZXMgYXJlIDAgKERpZmZlcmVudGlhbCksIDEgKFNpbmdsZS1lbmRlZCkgYW5kCj4g
KyAgICAyIChEaWdpdGFsIE1pY3JvcGhvbmUpLiBJZiBhYnNlbnQsIElObl9NT0RFIHJlZ2lzdGVy
cyBzZXQgdG8gMCBieSBkZWZhdWx0LgoKUGxlYXNlICNkZWZpbmUgdGhlc2UgaW4gaW5jbHVkZS9k
dC1iaW5kaW5ncyBpbiBhIHN1YnNlcXVlbnQgcGF0Y2guCgpBbmQgYW4gZXhhbXBsZT8KCj4gKyAg
ICBJZiBwcmVzZW50LCB2YWx1ZXMgbXVzdCBiZSBzcGVjaWZpZWQgbGVzcyB0aGFuIG9yIGVxdWFs
IHRvIHRoZSBudW1iZXIgb2YKPiArICAgIGlucHV0IHNpbmdhbHMuIElmIHZhbHVlcyBsZXNzIHRo
YW4gdGhlIG51bWJlciBvZiBpbnB1dCBzaWduYWxzLCBlbGVtZW50cwo+ICsgICAgdGhhdCBoYXMg
bm90IGJlZW4gc3BlY2lmZWQgYXJlIHNldCB0byAwIGJ5IGRlZmF1bHQuCj4gKwo+ICAgIC0gRENW
REQtc3VwcGx5LCBNSUNWREQtc3VwcGx5IDogUG93ZXIgc3VwcGxpZXMsIG9ubHkgbmVlZCB0byBi
ZSBzcGVjaWZpZWQgaWYKPiAgICAgIHRoZXkgYXJlIGJlaW5nIGV4dGVybmFsbHkgc3VwcGxpZWQu
IEFzIGNvdmVyZWQgaW4KPiAgICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
ZWd1bGF0b3IvcmVndWxhdG9yLnR4dAoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RNaWNyb2VsZWN0
cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3
YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9n
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
