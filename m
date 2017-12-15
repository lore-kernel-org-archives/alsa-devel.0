From: Hans de Goede <hdegoede@redhat.com>
Subject: Silencing plops / click sounds on start / stop
 of playing audio when snd_hda_intel.power_save=1
Date: Fri, 15 Dec 2017 13:35:04 +0100
Message-ID: <522e1590-6f1c-6c7d-4c8a-96c5dcbf6051@redhat.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: alsa-devel@alsa-project.org
Cc: jeremy@jcline.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

SGkgQWxsLAoKRm9yIEZlZG9yYSAyOCB3ZSBwbGFuIHRvIHNoaXAgdGhlIGtlcm5lbCB3aXRoIHNu
ZF9oZGFfaW50ZWwucG93ZXJfc2F2ZQpkZWZhdWx0aW5nIHRvIDE6CgpodHRwczovL2ZlZG9yYXBy
b2plY3Qub3JnL3dpa2kvQ2hhbmdlcy9JbXByb3ZlZExhcHRvcEJhdHRlcnlMaWZlCgpXZSd2ZSBo
YWQgYW4gdXBkYXRlIGZvciBGMjcgaW4gdXBkYXRlcy10ZXN0aW5nIGZvciBhIHdoaWxlIHdoaWNo
IG1hZGUKdGhlIHNhbWUgY2hhbmdlIGZvciBGMjcsIGJ1dCB3ZSd2ZSByZWNlaXZlZCBzZXZlcmFs
IGJ1ZyByZXBvcnRzCmFib3V0IHBsb3BzIC8gY2xpY2sgc291bmRzIG9uIHN0YXJ0IC8gc3RvcCBv
ZiBwbGF5aW5nIGF1ZGlvOgoKaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNn
aT9pZD0xNTI1MTA0CgpJIGtub3cgb3RoZXJzIGhhdmUgcHJvYmFibHkgYWxyZWFkeSB0cmllZCBm
aXhpbmcgdGhpcywgYnV0IEknbQp3b25kZXJpbmcgaWYgdGhlcmUgYXJlIGFueSBpZGVhcyBob3cg
dG8gZml4IHRoaXMgLyB0aGluZ3MgdG8gdHJ5PwoKSWRlYXMgb2YgbXkgb3duOgoKMSkgTXV0ZSB0
aGUgc3BlYWtlcnMgLyBoZWFkcGhvbmUgb3V0cHV0IGluIHRoZSBtaXhlciBiZWZvcmUKYWN0aXZh
dGluZyBwb3dlci1zYXZpbmcuIFF1ZXN0aW9uIGhvdyBoYXJkIHdvdWxkIGl0IGJlIHRvCm1ha2Ug
dGhpcyBoYXBwZW4/CgoyKSBQdXQgYSBkZWxheSBiZXR3ZWVuIHZhcmlvdXMgc3RlcHMgaW52b2x2
ZWQgaW4gdHVybmluZwp0aGluZ3Mgb2ZmIC8gb24uCgpSZWdhcmRzLAoKSGFucwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpwdWxzZWF1ZGlvLWRpc2N1c3Mg
bWFpbGluZyBsaXN0CnB1bHNlYXVkaW8tZGlzY3Vzc0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxzZWF1ZGlvLWRp
c2N1c3MK
