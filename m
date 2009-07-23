From: rom1dep <rom1dep@gmail.com>
Subject: Re: [snd_via82xx] EAGAIN on snd_pcm_prepare after
	EPIPE on mmap_commit
Date: Thu, 23 Jul 2009 19:23:39 +0200
Message-ID: <494d907f0907231023h26829d85ub13caec4a56ddec8@mail.gmail.com>
References: <494d907f0907230821ga09abcflb770b020b21b3735@mail.gmail.com>
	<s5hocrbwgu6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id A50C31037F2
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 19:24:00 +0200 (CEST)
Received: by fxm26 with SMTP id 26so1022430fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 10:24:00 -0700 (PDT)
In-Reply-To: <s5hocrbwgu6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MjAwOS83LzIzIFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT46Cj4gQXQgVGh1LCAyMyBKdWwg
MjAwOSAxNzoyMTo0NCArMDIwMCwKPiByb20xZGVwIHdyb3RlOgo+Pgo+PiBIZWxsbyAhCj4+IEkg
YW0gZW5jb3VudGVyaW5nIHNvbWUgaXNzdWVzIHdpdGggcHVsc2VhdWRpbyA6IGFmdGVyIHNvbWUg
dGltZSBhbmQKPj4gZm9yIG5vIGV2aWRlbnQgcmVhc29uIFBBIHN0b3BzIHJvdXRpbmcgdGhlIHNv
dW5kLgo+PiBUaGF0J3Mgd2hhdCBJIGdldCB3aXRoICRwdWxzZWF1ZGlvIC12dnYgOgo+PiBodHRw
Oi8vcGFzdGViaW4ubWFuZHJpdmEuY29tLzEzNjQ4IChnb3QgZnJvbSBhIDIuNi4yOS42X21kdiBr
ZXJuZWwpCj4+IHJ1bm5pbmcgJHBhY21kIGxpc3Qtc2lua3Mgd2hlbiBzdHVjayBnaXZlcyA6Cj4+
IGh0dHA6Ly9wYXN0ZWJpbi5tYW5kcml2YS5jb20vMTM2NDkKPj4KPj4gT3VyIHB1bHNlYXVkaW8g
aW50ZWdyYXRvciBDb2xpbiBHdXRocmllIGNvbmNsdWRlZCA6Cj4+ICJPSywgc28gd2hhdCBpcyBo
YXBwZW5pbmcgaXMgdGhhdCBzb21lIGFsc2EgbGV2ZWwgcHJvYmxlbSBpcyBvY2N1cnJpbmcKPj4g
KGR1ZSB0byBtbWFwKS4gUHVsc2UgdHJpZXMgdG8gcmVjb3ZlciBmcm9tIHRoaXMgYnV0IGNhbm5v
dC4gVGhlIGFsc2EKPj4gc2luayAoYW5kIHRoZSB3aG9sZSBjYXJkKSBpcyBzdWJzZXF1ZW50bHkg
dW5sb2FkZWQgZHVlIHRvIHRoaXMgZmF0YWwKPj4gZXJyb3IuIgo+PiBBbmQgbm93Li4gYSBxdWlj
ayBwYXN0ZSBmcm9tIGlyYyA6Cj4+ICJbMDA6NDQ6MjBdIDxjb2xpbmc+IEp1bCAyMiAxNDowNDoy
OSA8bWV6Y2FsZXJvPiDCoCDCoCBjb2xpbmc6IGRyaXZlcgo+PiBpc3N1ZSBpIGFtIHByZXR0eSBz
dXJlCj4+IFswMDo0NDoyMF0gPGNvbGluZz4gSnVsIDIyIDE0OjA0OjMzIDxtZXpjYWxlcm8+IMKg
IMKgIGkgc2F3IHRoYXQgYmVmb3JlIG9uY2UKPj4gWzAwOjQ0OjIwXSA8Y29saW5nPiBKdWwgMjIg
MTQ6MDQ6NTUgPG1lemNhbGVybz4gwqAgwqAgY29saW5nOiBpLmUuCj4+IEVBR0FJTiBvbiBzbmRf
cGNtX3ByZXBhcmUgYWZ0ZXIgRVBJUEUgb24gbW1hcF9jb21taXQKPgo+IFRoaXMgaXMgb2RkLiDC
oEVBR0FJTiBpcyByZXR1cm5lZCBvbmx5IGF0IG9wZW4sIHJlYWQvd3JpdGUgYW5kIGRyYWluCj4g
aW9jdGxzLgo+Cj4gQ291bGQgeW91IHRyYWNrIHdpdGggc3RyYWNlPwo+Cj4KPiBUYWthc2hpCj4K
Ckl0IHdhc24ndCBlYXN5IDogdGhhdCBiaWcgb3V0cHV0IG1hZGUgbXkgY29uZmlnIHN3YXAgYW5k
IGZpbmFsbHkKcHVsc2VhdWRpbyBsZWF2ZSBmb3IgIkU6IGNwdWxpbWl0LmM6IFJlY2VpdmVkIHJl
cXVlc3QgdG8gdGVybWluYXRlIGR1ZQp0byBDUFUgb3ZlcmxvYWQuIgpidXQgOgpodHRwOi8vcGFz
dGViaW4ubWFuZHJpdmEuY29tLzEzNjY1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
