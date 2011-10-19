From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH v6 1/2] ASoC: da7210: Add support for mute
 and zero cross controls
Date: Wed, 19 Oct 2011 17:45:03 +0100
Message-ID: <CABS+qY32mf+fnWfpEcpc2EZRxwuWCk_BUPhy2d2+YYa4L_QT=Q@mail.gmail.com>
References: <1319014146.7230.47.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id D402D24617
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 18:45:04 +0200 (CEST)
Received: by mail-yx0-f174.google.com with SMTP id 4so2425665yxp.33
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2011 09:45:03 -0700 (PDT)
In-Reply-To: <1319014146.7230.47.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

T24gMTkgT2N0b2JlciAyMDExIDA5OjQ5LCBBc2hpc2ggQ2hhdmFuIDxhc2hpc2guY2hhdmFuQGtw
aXRjdW1taW5zLmNvbT4gd3JvdGU6Cj4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIGJlbG93
IHNldCBvZiBjb250cm9scywKPiAoMSkgTXV0ZSBjb250cm9scyBmb3IgTUlDLCBBVVggYW5kIEFE
Qwo+ICgyKSBaZXJvIGNyb3NzIGNvbnRyb2xzIGZvciBoZWFkIHBob25lLCBBVVgsIElOUEdBIGFu
ZCBsaW5lIG91dAo+ICgzKSBIZWFkIHBob25lIG1vZGUgc2VsZWN0aW9uIC0gY2xhc3MgSCBvciBH
Cj4KPiBJdCBhbHNvIGFkZHMgZGlnaXRhbF9tdXRlKCkgY2FsbCBiYWNrLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogQXNoaXNoIENoYXZhbiA8YXNoaXNoLmNoYXZhbkBrcGl0Y3VtbWlucy5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogRGF2aWQgRGFqdW4gQ2hlbiA8ZGNoZW5AZGlhc2VtaS5jb20+Cj4gLS0tCj4g
Q2hhbmdlcyBzaW5jZSB2NDoKPiAtIENvbnZlcnRlZCBBREMgbXV0ZSBjb250cm9scyB0byBhIHNp
bmdsZSBzdGVyZW8gY29udHJvbAo+Cj4gQ2hhbmdlcyBzaW5jZSB2MjoKPiAtIEFkZGVkIGRpZ2l0
YWxfbXV0ZSgpIGNhbGwgYmFjayBhbmQgcmVtb3ZlZCBjb250cm9sIGZvciAiREFDIE11dGUKPiBT
d2l0Y2giCj4gLSBSZW5hbWVkIG11dGUgY29udHJvbCBzd2l0Y2hlcwo+Cj4gQ2hhbmdlcyBzaW5j
ZSB2MToKPiAtIENoYW5nZWQgTWljIG11dGUgY29udHJvbCB0byBhIGRvdWJsZSBjb250cm9sCj4g
LSBGaXhlZCBhIHR5cG8KPiAtLS0KPiDCoHNvdW5kL3NvYy9jb2RlY3MvZGE3MjEwLmMgfCDCoCA0
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxl
cyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKQWNrZWQtYnk6IExp
YW0gR2lyZHdvb2QgPGxyZ0B0aS5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
