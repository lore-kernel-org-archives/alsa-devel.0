From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX233 audio capture: glitches on task switch?
Date: Mon, 14 Apr 2014 09:59:06 -0300
Message-ID: <CAOMZO5AgghFwnZtH0AVsnxoaFAH-9KU5_CRWJ4Lvxptx7fGY2Q@mail.gmail.com>
References: <CANpMpoTQM9vpr8g+FFjkAiwh6fEKq-Qn_txD72pj2WrFQL5D_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C6E426109F
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 14:59:06 +0200 (CEST)
Received: by mail-wg0-f48.google.com with SMTP id l18so8013688wgh.31
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 05:59:06 -0700 (PDT)
In-Reply-To: <CANpMpoTQM9vpr8g+FFjkAiwh6fEKq-Qn_txD72pj2WrFQL5D_w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Gilles_Gr=C3=A9goire?= <gilles.gregoire@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGkgR2lsbGVzLAoKT24gU2F0LCBBcHIgMTIsIDIwMTQgYXQgMTE6MTMgQU0sIEdpbGxlcyBHcsOp
Z29pcmUKPGdpbGxlcy5ncmVnb2lyZUBnbWFpbC5jb20+IHdyb3RlOgo+IERlYXIgYWxzYSBkZXZl
bG9wZXJzLAo+Cj4gSSBuZWVkIGhlbHAgZGVidWdnaW5nIGEgZHJpdmVyIGZvciB0aGUgYnVpbHRp
biBjb2RlYyBvZiBGcmVlc2NhbGUncyBpTVgyMzMgU29DLgo+Cj4gSSBhbSBmYWNpbmcgYW4gaXNz
dWUgd2hlbiBjYXB0dXJpbmcgYXVkaW86IGdhcmJhZ2UgZGF0YSAoZ2xpdGNoZXMpCj4gYXBwZWFy
cyBwZXJpb2RpY2FsbHkgaW4gdGhlIHJlY29yZGVkIGF1ZGlvIGRhdGEuIEF1ZGlvIHBsYXliYWNr
IGxvb2tzCj4gZmluZSwgYXMgZmFyIGFzIEkgY2FuIHRlbGwuCj4KPiBJIGFtIHVzaW5nIGtlcm5l
bCAzLjEzLjYuIEEgZHJpdmVyIGJ5IEZyZWVzY2FsZSBleGlzdHMgZm9yIGEgMi42LjM1Cj4ga2Vy
bmVsIGJ1dCBpdCB3YXMgbmV2ZXIgc3VibWl0dGVkIHRvIG1haW5saW5lLiBUaGVyZWZvcmUsIHRo
ZSBkcml2ZXIgSQo+IHVzZSBpcyBhIHBvcnQgb2YgRnJlZXNjYWxlJ3MgZHJpdmVyIHRvIGtlcm5l
bCAzLjEzLjYgYnkgTWljaGFsCj4gVWxpYW5rby4gWW91IGNhbiBmaW5kIGl0IGluIHRoZSBhdHRh
Y2hlZCBwYXRjaCtkdHMuIFBsZWFzZSBub3RlIHRoYXQKPiB0aGlzIGlzIHN0aWxsIGEgd29yayBp
biBwcm9ncmVzcy4KCkkgd291bGQgc3VnZ2VzdCB5b3UgdG8gcG9zdCB0aGUgaW5pdGlhbCBkcml2
ZXIgc3VwcG9ydCBhcyBhIGZvcm1hbApwYXRjaCB0byB0aGlzIGxpc3QgZmlyc3QuCgpBcyB5b3Ug
bWVudGlvbmVkIHRoYXQgcGxheWJhY2sgd29ya3MgZmluZSwgeW91IGNvdWxkIHN0YXJ0IGJ5IGFk
ZGluZwp0aGUgbXgyMyBhdWRpbyBkcml2ZXIgd2l0aCBwbGF5YmFjayBzdXBwb3J0IG9ubHkuCgpP
bmNlIHRoZSBpbml0aWFsIHN1Ym1pc3Npb24gaXMgYWNjZXB0ZWQsIHRoZW4gd2UgY291bGQgbG9v
ayBhdCB0aGUKcmVjb3JkaW5nIHNpZGUuCgpLZWVwaW5nIHRoaXMgYXVkaW8gZHJpdmVyIG91dCBv
ZiB0cmVlIGRvZXMgbm90IHJlYWxseSBoZWxwLgoKQ2FyZSB0byBzdWJtaXQgaXQgdG8gdGhpcyBs
aXN0PwoKUmVnYXJkcywKCkZhYmlvIEVzdGV2YW0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
