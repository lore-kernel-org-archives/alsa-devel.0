From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] pxa2xx-ac97: fix reset gpio mode setting
Date: Tue, 12 May 2009 10:32:20 +0800
Message-ID: <f17812d70905111932t42cf0eeanc289cef3beccbe01@mail.gmail.com>
References: <1242036698-29136-1-git-send-email-mike@compulab.co.il>
	<20090511180430.GB26817@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 869A4245B3
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 04:32:21 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1949655qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 19:32:20 -0700 (PDT)
In-Reply-To: <20090511180430.GB26817@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, eric.miao@marvell.com, linux-arm-kernel@lists.arm.linux.org.uk, Mike Rapoport <mike@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBNYXkgMTIsIDIwMDkgYXQgMjowNCBBTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIE1vbiwgTWF5IDExLCAyMDA5IGF0
IDAxOjExOjM4UE0gKzAzMDAsIE1pa2UgUmFwb3BvcnQgd3JvdGU6Cj4+IFNpZ25lZC1vZmYtYnk6
IE1pa2UgUmFwb3BvcnQgPG1pa2VAY29tcHVsYWIuY28uaWw+Cj4KPiBBcHBsaWVkLCB0aGFua3Mu
IMKgUGxlYXNlIENDIG1lIG9uIHRoaW5ncy4uLgoKTXkgZmF1bHQsIEkgZm9yZ290IHRvIGluY2x1
ZGUgeW91LCBzb3JyeSBhYm91dCB0aGF0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
