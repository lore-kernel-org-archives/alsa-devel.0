From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] pulseaudio fails to start
 with kernel 4.11, caused by new snd_hdmi_lpe_audio module)
Date: Wed, 22 Mar 2017 21:16:52 -0600
Message-ID: <b693d927-229e-e00a-ada5-29d12154547b@linux.intel.com>
References: <2549c113-f06b-f22e-d36e-f59fc2969bcb@redhat.com>
 <s5h8to0w4fs.wl-tiwai@suse.de>
 <6754b5cd-f6d0-e2e3-0f01-992946ec1b92@linux.intel.com>
 <s5hk27jjigd.wl-tiwai@suse.de>
 <1490082870.1321124.918129488.4F3143F8@webmail.messagingengine.com>
 <bba100b1-5e74-093a-7625-a7feaba1a065@redhat.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <bba100b1-5e74-093a-7625-a7feaba1a065@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>, Arun Raghavan <arun@arunraghavan.net>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

T24gMy8yMS8xNyAyOjU2IEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOgo+IEk6IFtwdWxzZWF1ZGlv
XSBhbHNhLXNpbmsuYzogVXNpbmcgMS4wIGZyYWdtZW50cyBvZiBzaXplIDM1MjgzMiBieXRlcwo+
ICgyMDAwLjE4bXMpLCBidWZmZXIgc2l6ZSBpcyAzNTI4MzIgYnl0ZXMgKDIwMDAuMThtcykKPiBJ
OiBbcHVsc2VhdWRpb10gYWxzYS1zaW5rLmM6IFRpbWUgc2NoZWR1bGluZyB3YXRlcm1hcmsgaXMg
MjAuMDBtcwo+IEk6IFtwdWxzZWF1ZGlvXSBhbHNhLXNpbmsuYzogRHJpdmVyIGRvZXMgbm90IHN1
cHBvcnQgaGFyZHdhcmUgdm9sdW1lCj4gY29udHJvbCwgZmFsbGluZyBiYWNrIHRvIHNvZnR3YXJl
IHZvbHVtZSBjb250cm9sLgo+IEk6IFtwdWxzZWF1ZGlvXSBhbHNhLXNpbmsuYzogRHJpdmVyIGRv
ZXMgbm90IHN1cHBvcnQgaGFyZHdhcmUgbXV0ZQo+IGNvbnRyb2wsIGZhbGxpbmcgYmFjayB0byBz
b2Z0d2FyZSBtdXRlIGNvbnRyb2wuCj4gSTogW2Fsc2Etc2luay1IZG1pTHBlQXVkaW9dIGNvcmUt
dXRpbC5jOiBTdWNjZXNzZnVsbHkgZW5hYmxlZCBTQ0hFRF9SUgo+IHNjaGVkdWxpbmcgZm9yIHRo
cmVhZCwgd2l0aCBwcmlvcml0eSA1Lgo+IEk6IFthbHNhLXNpbmstSGRtaUxwZUF1ZGlvXSBhbHNh
LXNpbmsuYzogU3RhcnRpbmcgcGxheWJhY2suCj4gSTogW2Fsc2Etc2luay1IZG1pTHBlQXVkaW9d
IChhbHNhLWxpYilwY21faHcuYzogU05EUlZfUENNX0lPQ1RMX0hXU1lOQwo+IGZhaWxlZCAoLTMy
KQoKSHVtbSwgc2luZ2xlIHBlcmlvZCBhbmQgaHdfc3luYyBmYWlsZWQsIHRoaXMgY291bGQgYmUg
dGVzdGluZyB0aGUgCnJvYnVzdG5lc3Mgb2YgdGhlIHNpbmdsZS1wZXJpb2QgY29kZSBhbmQgaXRz
IG1hcHBpbmcgb24gbXVsdGlwbGUgRE1BIApkZXNjcmlwdG9ycz8gSSBoYXZlbid0IGxvb2tlZCBh
dCB0aGUgYWxzYSBtb2R1bGUgaW4gZW9ucyBidXQgY2FuJ3QgdGhlIApudW1iZXIgb2YgcGVyaW9k
cyBiZSBmb3JjZWQgdG8gdHdvIHdpdGggbW9kdWxlIHBhcmFtZXRlcnMgd2hpbGUga2VlcGluZyAK
dGhlIHRpbWVyLWJhc2VkIHNjaGVkdWxuZz8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KcHVsc2VhdWRpby1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1
ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vcHVsc2VhdWRpby1kaXNjdXNzCg==
