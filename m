From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] drm: adv7511_audio: Add .get_dai_id callback to map port
 number to dai id
Date: Tue, 13 Jun 2017 15:01:27 -0700
Message-ID: <CALAqxLUP+O-OGSULdrueTn5heFiC9ovuL7fKig2hNe++YjcXmw@mail.gmail.com>
References: <1497391189-9301-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1497391189-9301-1-git-send-email-john.stultz@linaro.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBKdW4gMTMsIDIwMTcgYXQgMjo1OSBQTSwgSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6
QGxpbmFyby5vcmc+IHdyb3RlOgo+IEFMU0EgU29DIG5lZWRzIHRvIGtub3cgY29ubmVjdGVkIERB
SSBJRCBmb3IgcHJvYmluZy4gVXNpbmcKPiB0aGUgbmV3IGF1ZGlvLWNhcmQtZ3JhcGggYXBwcm9h
Y2gsIHBvcnRzL2VuZHBvaW50cyBhcmUgdXNlZAo+IHRvIGRlc2NyaWJlIGhvdyB0aGUgbGlua3Mg
YXJlIGNvbm5lY3RlZC4gVW5mb3J0dW5hdGVseSwgc2luY2UKPiBwb3J0cy9lbmRwb2ludHMgYXJl
IHVzZWQgYXMgd2VsbCBmb3IgdmlkZW8gbGlua2FnZXMsIHRoZXJlCj4gYXJlIHNvbWUgaXNzdWVz
IG1peGluZyB0aGUgcG9ydCBpZHMgdG8gdGhlIHR3byAodmlkZW8gYW5kCj4gYXVkaW8pIG5hbWVz
cGFjZXMuCj4KPiBUbyBzb2x2ZSB0aGlzIGlzc3VlLCB0aGlzIHBhdGNoIGFkZHMgbmV3IC5nZXRf
ZGFpX2lkIGNhbGxiYWNrCj4gb24gaGRtaV9jb2RlY19vcHMuCj4KPiBUaGUgd2lsbCBhc3N1bWUg
dGhhdCBIRE1JIGF1ZGlvIG91dCB3aWxsIGJlIGNvbm5lY3RlZCB0bwo+IHJlZyA9IDwyPi4gVGhp
cyB3aWxsIHRoZW4gYmUgcmVtYXBwZWQgdG8gdGhlIEFMU0EgU29DIHNpZGUgd2lsbAo+IGFzIERB
SSAwLiBBbGxvd2luZyB0aGUgYWR2NzUxMSdzIGhkbWkgYXVkaW8gc3VwcG9ydCB0byBiZSB1c2Vk
Cj4gd2l0aCB0aGUgYXVkaW8tY2FyZC1ncmFwaC4KPgo+IENyZWRpdCB0byBLdW5pbm9yaSBNb3Jp
bW90byB3aG8ncyBwYXRjaCB0byBkdy1oZG1pLWkycy1hdWRpby5jCj4gd2FzIHdoYXQgdGhpcyB3
YXMgbW9zdGx5IGNvcHktcGFzdGVkIGZyb20uCgpGb3Jnb3QgdG8gbm90ZSB0aGlzIGhhcyBkZXBl
bmRlbmNpZXMgb24gcGF0Y2hlcyBpbiB0aGUgQVNvQyB0cmVlIGluCi1uZXh0LCBzbyBpdCBwcm9i
YWJseSBzaG91bGQgZ28gaW4gdmlhIHRoYXQgdHJlZS4KCnRoYW5rcwotam9obgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
