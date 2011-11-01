From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] RFC for snd-usb: rework usb endpoint
	logic
Date: Tue, 01 Nov 2011 10:15:11 +0100
Message-ID: <4EAFB89F.5050704@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<4EAE96BC.6060605@gmail.com>
	<CAE-xCyPKy2JTXPPDLsn99YWa1D5XUtjzUX2PxjQ8VvH-h=7Fpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2AA832438E
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 12:03:25 +0100 (CET)
Received: by faao24 with SMTP id o24so7030121faa.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Nov 2011 04:03:25 -0700 (PDT)
In-Reply-To: <CAE-xCyPKy2JTXPPDLsn99YWa1D5XUtjzUX2PxjQ8VvH-h=7Fpw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?QXVyw6lsaWVuIExlYmxvbmQ=?= <blablack@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

T24gMDEuMTEuMTEgMDk6NTAsIEF1csOpbGllbiBMZWJsb25kIHdyb3RlOgo+IEhpIERhbmllbCwK
PiAKPiBCcmlsbGlhbnQhCj4gCj4gSSBoYXZlIGEgcXVlc3Rpb24gdGhvdWdoLCByZWxhdGVkIHRv
IGhvdyB5b3UgZ3V5cyBpbiBBbHNhIHdvcmsgYW5kCj4gd2hhdCBwcm9jZXNzZXMgeW91IGZvbGxv
dy4KPiAKPiBBcmUgeW91IGxvb2tpbmcgZm9yIHRlc3RlcnMgYWxyZWFkeT8KPiAKPiBPciBtb3Jl
IGZvciBzb21lIGtpbmQgb2YgYXBwcm92YWwgZmlyc3QgZnJvbSBzb21lIG90aGVyIEFsc2EgZ3Vy
dXMgdG8KPiBnZXQgdGhlIGNvZGUgYWNjZXB0ZWQ/CgpObywgZ28gYWhlYWQgYW5kIHRlc3QuIEJl
IHdhcm5lZCB0aGF0IHlvdXIgbWFjaGluZSBtaWdodCBzdGlsbCBsb2NrIHVwLApidXQgYW55IGtp
bmQgb2YgZmVlZGJhY2sgaXMgY2VydGFpbmx5IHZhbHVhYmxlLgoKVGhhbmtzLApEYW5pZWwKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
