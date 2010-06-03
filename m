From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
	account for a write being currently in progress
Date: Thu, 3 Jun 2010 15:40:48 +0100
Message-ID: <AANLkTind6KbV7bpBhG1WK716EsTVCYrjIso3nuuOuBdo@mail.gmail.com>
References: <1275514176.8032.42.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8341A103AB5
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 16:40:49 +0200 (CEST)
Received: by fxm18 with SMTP id 18so151629fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 07:40:48 -0700 (PDT)
In-Reply-To: <1275514176.8032.42.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMiBKdW5lIDIwMTAgMjI6MjksIEpvaG4gTGluZGdyZW4gPGpvaG4ubGluZGdyZW5AdGRzLm5l
dD4gd3JvdGU6Cj4gSGksCj4KPiBJbiBhIG11bHRpLXRocmVhZGVkIGFwcGxpY2F0aW9uIGl0IGlz
IHBvc3NpYmxlIGZvciBzbmRfcGNtX2RlbGF5IG9yIGFuCj4gZXF1aXZhbGVudCBmdW5jdGlvbiB0
byBiZSBjYWxsZWQgYnkgb25lIHRocmVhZCB3aGlsZSBhbm90aGVyIGlzIHNpdHRpbmcKPiBpbiBz
bmRfcGNtX3dyaXRlaS4gwqBJbiB0aGlzIGNhc2UsIHNuZF9wY21fZGVsYXkgZG9lcyBub3QgdGFr
ZSBpbnRvCj4gYWNjb3VudCB0aGF0IHRoZXJlIG1heSBub3QgYmUgZW5vdWdoIHNwYWNlIGZvciBh
bGwgdGhlIGRhdGEgcGFzc2VkIHRvCj4gc25kX3BjbV93cml0ZWkgdG8gYmUgd3JpdHRlbiB0byB0
aGUgcmluZyBidWZmZXIgYXQgb25jZSwgYW5kIHdpbGwgcmV0dXJuCj4gaW5jb3JyZWN0IHZhbHVl
cy4KPgoKSSBiZWxpZXZlIHRoZSBkZWZpbml0aW9uIG9mIHNuZF9wY21fZGVsYXkoKSBpcyBpdCBy
ZXR1cm5zIGEgdmFsdWUgdGhhdAp3b3VsZCBiZSBmYWlybHkgYWNjdXJhdGUgYXQgdGhpcyBpbnN0
YW5jZSBvZiB0aW1lLiBJZiB5b3UgZm9sbG93ZWQgdGhlCnNuZF9wY21fZGVsYXkoKSB3aXRoIGEg
c25kX3BjbV93cml0ZWkoKSwgdGhlIHNhbXBsZXMgd291bGQgcmVhY2ggdGhlCnNwZWFrZXIgImRl
bGF5IiB0aW1lIGxhdGVyLgoKSSB0aGluayBpdCB3b3VsZCBiZSBmYWlyIHRvIHNheSB0aGF0IHRo
ZSB2YWx1ZSBvZiBzbmRfcGNtX2RlbGF5KCkgaXMKdW5kZWZpbmVkIGlmIGNhbGxlZCBkdXJpbmcg
YSBzbmRfcGNtX3dyaXRlaSgpIGNhbGwsIGJlY2F1c2UgeW91IHdpbGwKZ2V0IGEgcmV0dXJuIHZh
bHVlIGZyb20gc25kX3BjbV9kZWxheSgpIGJ1dCB5b3Ugd2lsbCBoYXZlIG5vIGlkZWEgaG93Cm1h
bnkgc2FtcGxlcyBvZiB0aGUgY3VycmVudCBzbmRfcGNtX3dyaXRlaSgpIGhhdmUgYmVlbiB3cml0
dGVuIGFuZAp0aHVzIG5vIGlkZWEgd2hhdCB0aGUgZGVsYXkgd2lsbCBiZSBvbiB0aGUgbmV4dCBz
bmRfcGNtX3dyaXRlaSgpLgoKRXZlbiBpbiBtdWx0aS10aHJlYWRlZCBhcHBsaWNhdGlvbnMgY2Fs
bGluZyB0d28gZnVuY3Rpb25zIGF0IHRoZSBzYW1lCnRpbWUgdGhhdCBpbnRlcmZlcmUgd2l0aCBl
YWNoIG90aGVyIGl0IG5vdCBnb29kLgpJZiBhIGZ1bmN0aW9uIGlzIHJlLWVudHJhbnQgaXQgaXMg
Z2VuZXJhbGx5IGNvbnNpZGVyZWQgdG8gYmUgdGhyZWFkCnNhZmUuIEl0IGRvZXMgbm90IG5lY2Vz
c2FyaWx5IG1lYW4gdGhhdCBpdCBpcyBzZW5zaWJsZSB0byBjYWxsIHR3bwpkaWZmZXJlbnQgZnVu
Y3Rpb25zIGF0IHRoZSBzYW1lIHRpbWUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
