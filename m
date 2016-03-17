From: "Pan, Harry" <harry.pan@intel.com>
Subject: Re: [PATCH] ASoC: dapm: Do not traverse widget hooks to
 snd-soc-dummy
Date: Thu, 17 Mar 2016 13:04:15 +0000
Message-ID: <1458219853.24844.10.camel@intel.com>
References: <1458127071-14417-1-git-send-email-harry.pan@intel.com>
	 <20160317095438.GD2566@sirena.org.uk> <1458211115.965.13.camel@intel.com>
	 <20160317112514.GE2566@sirena.org.uk> <56EAA4FC.5090408@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56EAA4FC.5090408@metafoo.de>
Content-Language: en-US
Content-ID: <1A2815CFB6FB5A4889A88817CBE63027@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "lars@metafoo.de" <lars@metafoo.de>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gs0622@gmail.com" <gs0622@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.com" <tiwai@suse.com>, "perex@perex.cz" <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

PiBJJ2Qgc2F5IGFzIGEgcXVpY2sgZml4IGZvciBzdGFibGUgY2hlY2sgdGhhdCBjYXJkIGlzIG5v
dCBOVUxMIGluDQo+IGRhcG1fd2lkZ2V0X3Nob3dfY29tcG9uZW50KCkuIEFuZCBhcyBhIGxvbmd0
ZXJtIGZpeCBnZXQgcmlkIG9mDQo+IGRhcG1fd2lkZ2V0DQo+IGZpbGUuIE5vYm9keSBzaG91bGQg
aG9wZWZ1bGx5IHVzZSBpdCBhbnltb3JlIHdpdGggZGVidWdmcyBiZWluZw0KPiBhdmFpbGFibGUg
YXMNCj4gdGhlIGZhciBiZXR0ZXIgYWx0ZXJuYXRpdmUuDQo+IA0KPiAtIExhcnMNCg0KV2VsbCwg
dGhhdCB3YXMgbXkgb3JpZ2luYWwgYXBwcm9hY2ggd2hpbGUgSSByZWFsaXplZCBwcm9ibGVtDQpp
cyBjYXVzZWQgYnkgZGUtcmVmZXJlbmNpbmcgYSBudWxsIHBvaW50ZXIgdG8gaXRzIG1lbWJlciBv
Zg0KJ3dpZGdldCcgbGlzdC4NCg0KaS5lLg0KaHR0cHM6Ly9jaHJvbWl1bS1yZXZpZXcuZ29vZ2xl
c291cmNlLmNvbS8jL2MvMzMxMjg1LzMvc291bmQvc29jL3NvYy1kYXANCm0uYw0KDQorwqDCoMKg
aWYgKFdBUk5fT04oIWNvZGVjLT5jb21wb25lbnQuY2FyZCkpDQorwqDCoMKgwqDCoMKgwqByZXR1
cm4gMDsNCisNCg0KQWRkaXRpb25hbCByZW1hcmsgaXMgdGhhdCBJIHdhcyB3b3JraW5nIG9uIGNo
cm9taXVtLW9zIHYzLjE4IGtlcm5lbCwNCnNvIHRoYXQgdGhlIGludGVyZmFjZSBhbmQgYXJndW1l
bnQgYXJlIHNvcnQgb2YgZGlmZmVyZW50IHRoYW4gd2hhdA0KSSB0aGVuIGNoZXJyeS1waWNrJ2Vk
IHRoZW4gc2VudCwgd2hpY2ggd2FzIGJhc2VkIG9uIGxhdGVzdCA0LjUuDQoNClRoZW4gSSB3YXMg
c3R1Y2sgYXQgaGVyZSBjb3VwbGUgZGF5cyBrZWVwaW5nIGh1bnRpbmcgcm9vdCBjYXVzZSwNClR1
cm5lZCBvdXQgSSBmb3VuZCB0aGF0IGNvbW1pdCBza2lwcGVkIHByb2JpbmcgZHVtbXkgY29tcG9u
ZW50Lg0KDQpMb25nIHN0b3J5IHNob3J0Lg0KDQotSGFycnkNCg0K
