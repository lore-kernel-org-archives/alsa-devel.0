From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 19:32:22 +0900
Message-ID: <1b68c6791002180232p6cd86811sc78699ac87236015@mail.gmail.com>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com> <20100217105202.GB31765@sirena.org.uk>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
	<20100217131421.GB11510@rakim.wolfsonmicro.main>
	<1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
	<20100218093459.GB3315@rakim.wolfsonmicro.main>
	<1b68c6791002180142l422a9203se2a71cae5795d6a9@mail.gmail.com>
	<20100218095249.GE3315@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CF861038B4
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 11:32:23 +0100 (CET)
Received: by vws18 with SMTP id 18so1125522vws.38
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 02:32:22 -0800 (PST)
In-Reply-To: <20100218095249.GE3315@rakim.wolfsonmicro.main>
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
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBGZWIgMTgsIDIwMTAgYXQgNjo1MiBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFRodSwgRmViIDE4LCAyMDEwIGF0
IDA2OjQyOjI2UE0gKzA5MDAsIGphc3NpIGJyYXIgd3JvdGU6Cj4+IE9uIFRodSwgRmViIDE4LCAy
MDEwIGF0IDY6MzUgUE0sIE1hcmsgQnJvd24KPgo+PiA+IENvdWxkIHlvdSBwbGVhc2UgYmUgbW9y
ZSBzcGVjaWZpYyBhYm91dCB3aGF0IHRoZSB3b3JrYXJvdW5kIHlvdSBhcmUKPj4gPiByZWZlcnJp
bmcgdG8gaXM/IMKgSSdtIGdlbnVpbmVseSBub3QgY2xlYXIgd2hhdCB5b3UgbWVhbiBoZXJlLgo+
Cj4+IEluIG9yZGVyIGZvciBhIGNvZGVjX2RhaSB0byBiZSB1c2VkIGluIG1vcmUgdGhhbiBvbmUg
ZGFpX2xpbmsKPj4gSSBjaGVjayBmb3IgaXRzICdhY3RpdmUnIGNvdW50ZXIgYW5kIGNhbGwgc2h1
dGRvd24sIHN0YXJ0dXAsIG11dGUKPj4gYW5kIHNjaGVkdWxlX2RlbGF5ZWRfd29yayBvbmx5IGlm
IG5vIG90aGVyIGRhaV9saW5rIGlzCj4+IGFjdGl2ZWx5IHVzaW5nIHRoYXQgY29kZWNfZGFpLgo+
Cj4gV2hlcmUgaXMgdGhlIGNvZGUgeW91IGFyZSB0YWxraW5nIGFib3V0IGhlcmU/IMKgVGhpcyBz
b3VuZHMgbGlrZSBkcml2ZXIKPiBjb2RlLi4uCkFoaC4uLiBpdCdzIGFsbCBtZXNzZWQgdXAgYnkg
dGhhdCBzYW1zdW5nLmdpdCBsaW5rIHRoYXQgSm9vbnlvdW5nIFNoaW0gc2hhcmVkLgpJIGFzc3Vt
ZWQgeW91IGhhZCBhIGxvb2sgYXQgdGhhdC4gVGhlIGNvZGUganVzdCBhIHF1aWNrIHdvcmthcm91
bmQsIHNvCkkgZGlkbid0IHB1dCBpdCB1cCBoZXJlCmh0dHA6Ly9naXQua2VybmVsLm9yZy8/cD1s
aW51eC9rZXJuZWwvZ2l0L2traV9hcC9saW51eC0yLjYtc2Ftc3VuZy5naXQ7YT1jb21taXRkaWZm
O2g9ZTU4NTg5NDhiYjJjNTM0MjUxYjY1YTg1MGNhZjE5N2FlODgwY2UxZgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
