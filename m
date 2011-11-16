From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] ASoC: alc5632: rename volume/switch
 contols for master and speaker volumes.
Date: Wed, 16 Nov 2011 07:18:49 +0200
Message-ID: <CALq1K=KrL5sfSt4kH=0NiJr7kLX7pM1n=GAGWzc+v+048SEaEQ@mail.gmail.com>
References: <1321213993-27920-1-git-send-email-leon@leon.nu>
	<20111114213915.GH6528@opensource.wolfsonmicro.com>
	<CALq1K=+gUXnt0q4TxpUOhZFmdnHd+jdnkMpbj0JpF7_BkpCiDg@mail.gmail.com>
	<20111115192509.GA4223@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7B9EC2412D
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 06:19:11 +0100 (CET)
Received: by wyg36 with SMTP id 36so52784wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 21:19:10 -0800 (PST)
In-Reply-To: <20111115192509.GA4223@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBOb3YgMTUsIDIwMTEgYXQgMjE6MjUsIE1hcmsgQnJvd24KPGJyb29uaWVAb3BlbnNv
dXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBNb24sIE5vdiAxNCwgMjAxMSBhdCAx
MTo1MDowNVBNICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6Cj4+IE9uIE1vbiwgTm92IDE0
LCAyMDExIGF0IDIzOjM5LCBNYXJrIEJyb3duCj4KPj4gPiBUaGlzIGxvb2tzIHJlYWxseSBzdXNw
aWNpb3VzLCB3aHkgYXJlIHdlIHJlbmFtaW5nIHRoZSBsaW5lIG91dHB1dCBhcyBhCj4+ID4gc3Bl
YWtlciBvdXRwdXQ/IMKgVGhpcyBtaWdodCBiZSBhcHByb3ByaWF0ZSBvbiB5b3VyIGJvYXJkIGJ1
dCBpZiB0aGUKPj4gPiBkcml2ZXJzIGFyZW4ndCBwYXJ0IG9mIHRoZSBDT0RFQyBpdCBtaWdodCBu
b3QgYmUgYXBwcm9wcmlhdGUgb24gYW5vdGhlcgo+PiA+IGJvYXJkLgo+Cj4+IFRoZXJlIGFyZSB0
d28gbWFpbiByZWFzb25zOgo+PiAxKSBXZSBhcmUgY2hhbmdpbmcgU1BLX09VVF9WT0wgd2hpY2gg
b24gdGhlIHNjaGVtYXRpY3MgbWFya2VkIGFzIGEKPj4gc3BlYWtlciwgYW5kIHdlIHdhbnQgdG8g
YmUgYXMgY2xvc2UgYXMgcG9zc2libGUgdG8gdGhlIGRhdGFzaGVldC4KPj4gMikgV2UgYXJlIHRp
cmVkIHRvIGV4cGxhaW4gdG8gdXNlcnMgdGhhdCB0aGUgc3BlYWtlciB2b2x1bWUgY29udHJvbGxl
ZAo+PiBieSAiTGluZSBQbGF5YmFjayBWb2x1bWUiIGluIGFsc2FtaXhlci4KPgo+IFRoZSBhYm92
ZSBib3RoIHNvdW5kIGJvYXJkIHNwZWNpZmljLiDCoFdoYXQgZG9lcyB0aGUgQ09ERUMgaXRzZWxm
IGNhbGwKPiB0aGVzZSBvdXRwdXRzPwpTUEtfT1VUL1NQS19PVVROCmh0dHA6Ly9hYzEwMC53aWtp
c3BhY2VzLmNvbS9maWxlL3ZpZXcvYWxjNTYzMl9taXhlcl9wYXRoLlBORy8yNTEwOTUyNjYvYWxj
NTYzMl9taXhlcl9wYXRoLlBORwoKLS0gCkxlb24gUm9tYW5vdnNreSB8IEluZGVwZW5kZW50IExp
bnV4IENvbnN1bHRhbnQKwqAgwqAgwqAgwqDCoHd3dy5sZW9uLm51wqB8IGxlb25AbGVvbi5udQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
