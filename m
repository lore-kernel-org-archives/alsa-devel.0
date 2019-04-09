From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v5 05/14] ASoC: SOF:
 Add PCM operations support
Date: Tue, 9 Apr 2019 09:23:17 -0500
Message-ID: <dd1fdce0-1ae8-c5f3-a744-d04891951de2@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0m2caz6.wl-tiwai@suse.de>
 <f5346e231c80876f0fa74e1172d570b0033cbf42.camel@linux.intel.com>
 <s5hv9zsy6qr.wl-tiwai@suse.de>
 <7f8f25fc-0ea5-7562-37bb-64a8468f040d@linux.intel.com>
 <s5hmukz4nbf.wl-tiwai@suse.de>
 <aafcef1c-ca4d-3026-0c58-788713479df9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <aafcef1c-ca4d-3026-0c58-788713479df9@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, alsa-devel@alsa-project.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cj4gb2ssIHRoYW5rcyBmb3IgY29uZmlybWluZy4gd2UnbGwgcmVtb3ZlIHRoZSBJTkZPX1JFU1VN
RSBmbGFnIGluIFNPRiBhbmQgCj4gZm9sbG93LXVwIHdpdGggdGhlIHJlbW92YWwgb24gYWxsIG90
aGVyIEludGVsIGRyaXZlcnMuIFRoYW5rcyBmb3IgCj4gZW5saWdodGVuaW5nIHVzIG9uIHRoaXMu
CgpBY3R1YWxseSBvbmUgbW9yZSBxdWVzdGlvbiByZWxhdGVkIHRvIHRoZSBkb2N1bWVudGF0aW9u
LCB3aGljaCByZWFkcwoKIk5vdGUgdGhhdCB0aGUgdHJpZ2dlciB3aXRoIFNVU1BFTkQgY2FuIGFs
d2F5cyBiZSBjYWxsZWQgd2hlbiAKc25kX3BjbV9zdXNwZW5kX2FsbCgpIGlzIGNhbGxlZCwgcmVn
YXJkbGVzcyBvZiB0aGUgU05EUlZfUENNX0lORk9fUkVTVU1FIApmbGFnLiBUaGUgUkVTVU1FIGZs
YWcgYWZmZWN0cyBvbmx5IHRoZSBiZWhhdmlvciBvZiBzbmRfcGNtX3Jlc3VtZSgpLiAKKFRodXMs
IGluIHRoZW9yeSwgU05EUlZfUENNX1RSSUdHRVJfUkVTVU1FIGlzbuKAmXQgbmVlZGVkIHRvIGJl
IGhhbmRsZWQgaW4gCnRoZSB0cmlnZ2VyIGNhbGxiYWNrIHdoZW4gbm8gU05EUlZfUENNX0lORk9f
UkVTVU1FIGZsYWcgaXMgc2V0LiBCdXQsIAppdOKAmXMgYmV0dGVyIHRvIGtlZXAgaXQgZm9yIGNv
bXBhdGliaWxpdHkgcmVhc29ucy4pIgoKSSBjb3VsZCBub3QgZmlndXJlIG91dCB3aGF0IHRoZSBs
YXN0IHNlbnRlbmNlIG1lYW5zLiBJdCdzIG15IAp1bmRlcnN0YW5kaW5nIHRoYXQgdGhlIHJlc3Vt
ZV90cmlnZ2VyIHdpbGwgbmV2ZXIgYmUgY2FsbGVkIHdpdGggdGhlIGNvZGUgCmZsb3cgYmVsb3cg
d2hlbiBJTkZPX1JFU1VNRSBpc24ndCBkZWNsYXJlZC4gV291bGQgeW91IG1pbmQgY2xhcmlmeWlu
ZyAKd2hhdCB0aGlzIGNvbXBhdGliaWxpdHkgbWlnaHQgYmU/IFRoYW5rcyEKCnN0YXRpYyBpbnQg
c25kX3BjbV9wcmVfcmVzdW1lKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLCBp
bnQgCnN0YXRlKQp7CglzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1lID0gc3Vic3RyZWFt
LT5ydW50aW1lOwoJaWYgKCEocnVudGltZS0+aW5mbyAmIFNORFJWX1BDTV9JTkZPX1JFU1VNRSkp
CgkJcmV0dXJuIC1FTk9TWVM7CgpyZXMgPSBvcHMtPnByZV9hY3Rpb24oc3Vic3RyZWFtLCBzdGF0
ZSk7CmlmIChyZXMgPCAwKQogICAgCXJldHVybiByZXM7IDw8PCByZXR1cm4gbWVhbnMgdHJpZ2dl
cl9yZXN1bWUgaXMgbm90IGNhbGxlZD8KcmVzID0gb3BzLT5kb19hY3Rpb24oc3Vic3RyZWFtLCBz
dGF0ZSk7CgpzdGF0aWMgY29uc3Qgc3RydWN0IGFjdGlvbl9vcHMgc25kX3BjbV9hY3Rpb25fcmVz
dW1lID0gewoJLnByZV9hY3Rpb24gPSBzbmRfcGNtX3ByZV9yZXN1bWUsCgkuZG9fYWN0aW9uID0g
c25kX3BjbV9kb19yZXN1bWUsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
