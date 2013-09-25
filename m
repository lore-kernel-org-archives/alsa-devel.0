From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum
 workaround into SPI I/O function
Date: Wed, 25 Sep 2013 12:55:02 +0100
Message-ID: <20130925115502.GI5132@lee--X1>
References: <1379960073-23245-1-git-send-email-broonie@kernel.org>
 <1379960073-23245-2-git-send-email-broonie@kernel.org>
 <20130925111954.GG5132@lee--X1>
 <20130925113103.GN3226@sirena.org.uk>
 <20130925114643.GH5132@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f169.google.com (mail-ea0-f169.google.com
 [209.85.215.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 59916265388
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 13:55:07 +0200 (CEST)
Received: by mail-ea0-f169.google.com with SMTP id k11so3140022eaj.14
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 04:55:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130925114643.GH5132@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAyNSBTZXAgMjAxMywgTGVlIEpvbmVzIHdyb3RlOgoKPiBPbiBXZWQsIDI1IFNlcCAy
MDEzLCBNYXJrIEJyb3duIHdyb3RlOgo+IAo+ID4gT24gV2VkLCBTZXAgMjUsIDIwMTMgYXQgMTI6
MTk6NTRQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gCj4gPiA+IEkgYXNzdW1lIHRoaXMg
aXMgb2theSB0byBnbyBpbiB2aWEgdGhlIE1GRCB0cmVlLgo+ID4gCj4gPiA+IEkndmUgYXBwbGll
ZCBpdCB1bnRpbCB5b3Ugc2F5IG90aGVyd2lzZS4KPiA+IAo+ID4gQ2FuIHlvdSBwbGVhc2UgcHV0
IGl0IG9uIGEgYnJhbmNoIEkgY2FuIHB1bGwgaW50byBBU29DIGluIGNhc2Ugd2UgbWFuYWdlCj4g
PiB0byBnZXQgcmlkIG9mIGFsbCB0aGUgb3RoZXIgdXNlcnMgdGhpcyBjeWNsZT8KPiAKPiBZZXMs
IEkgY2FuIGRvIHRoYXQuCgpodHRwczovL2dpdC5saW5hcm8ub3JnL2dpdHdlYj9wPXBlb3BsZS9s
am9uZXMvbWZkLmdpdCBtZmQtYXNvYwoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RNaWNyb2VsZWN0
cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3
YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9n
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
