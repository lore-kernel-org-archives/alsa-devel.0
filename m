From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 4/8] ASoC: sun8i-codec-analog: Add
 amplifier event to fix first delay
Date: Fri, 10 Feb 2017 14:08:54 +0800
Message-ID: <CAGb2v66NXJ5RG8VUbvtZcqXzzOvhRc8A_M1R=2rRpfnHNbZDpw@mail.gmail.com>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
 <20170202092422.5588-5-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id A9AA5266951
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 07:09:20 +0100 (CET)
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
 [209.85.214.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id B312D226DA
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 14:09:16 +0800 (CST)
Received: by mail-it0-f51.google.com with SMTP id 203so135435563ith.0
 for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2017 22:09:16 -0800 (PST)
In-Reply-To: <20170202092422.5588-5-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBGZWIgMiwgMjAxNyBhdCA1OjI0IFBNLCBNeWzDqG5lIEpvc3NlcmFuZAo8bXlsZW5l
Lmpvc3NlcmFuZEBmcmVlLWVsZWN0cm9ucy5jb20+IHdyb3RlOgo+IFdoZW4gcGxheWluZyBhIHNv
dW5kIGZvciB0aGUgZmlyc3QgdGltZSwgYSBzaG9ydCBkZWxheSwgd2hlcmUgdGhlIGF1ZGlvCj4g
ZmlsZSBpcyBub3QgcGxheWVkLCBjYW4gYmUgbm90aWNlZC4KPiBPbiBhIHNlY29uZCBwbGF5IChy
aWdodCBhZnRlciksIHRoZSBzb3VuZCBpcyBwbGF5ZWQgY29ycmVjdGx5Lgo+IElmIHdlIHdhaXQg
YSBzaG9ydCB0aW1lICh+NSBzZWMgd2hpY2ggY29ycmVzcG9uZHMgdG8gdGhlIGFwbGF5Cj4gdGlt
ZW91dCksIHRoZSBkZWxheSBpcyBiYWNrLgo+Cj4gVGhpcyBwYXRjaCBmaXhlcyBpdCBieSB1c2lu
ZyBhbiBldmVudCBvbiBoZWFkcGhvbmUgYW1wbGlmaWVyLgo+IEl0IGFsbG93cyB0byBrZWVwIHRo
ZSBhbXBsaWZpZXIgZW5hYmxlIHdoaWxlIHBsYXlpbmcgYSBzb3VuZC4KPiBBIGRlbGF5IG9mIDcw
MG1zIGFsbG93cyB0byB3YWl0IHRoYXQgdGhlIGFtcGxpZmllciBpcyBwb3dlcmVkLXVwCj4gYmVm
b3JlIHBsYXlpbmcgdGhlIHNvdW5kLgo+Cj4gU2lnbmVkLW9mZi1ieTogTXlsw6huZSBKb3NzZXJh
bmQgPG15bGVuZS5qb3NzZXJhbmRAZnJlZS1lbGVjdHJvbnMuY29tPgo+IEFja2VkLWJ5OiBNYXhp
bWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGZyZWUtZWxlY3Ryb25zLmNvbT4KCkkgZ2V0IHNvbWUg
c3RhdGljIGluIG15IGhlYWRwaG9uZXMgaW4gdGhlIHRpbWUgYmV0d2VlbiB3aGVuIHRoZQphbXBs
aWZpZXIgaXMgZW5hYmxlZCBhbmQgd2hlbiBzb3VuZCBzdGFydHMgcGxheWluZy4gV29uZGVyIGlm
CnRoaXMgY2FuIGJlIGZpeGVkIGluIGFueSB3YXk/CgpPbmUgc29sdXRpb24gdGhhdCBtaWdodCB3
b3JrIGlzIHRvIG11dGUgdGhlIGhlYWRwaG9uZSBvdXRwdXQKd2hpbGUgdGhlIGFtcCBpcyBiZWlu
ZyBjaGFyZ2VkLCBieSBzZXR0aW5nIFNVTjhJX0FEREFfSFBfVk9MQ19IUF9WT0wKdG8gMCwgYW5k
IHRoZW4gcmVzdG9yaW5nIHRoZSB2YWx1ZSBvbmNlIGl0IGlzIGNoYXJnZWQuIEluIG90aGVyCndv
cmRzLCBvdmVycmlkaW5nIHRoZSB2YWx1ZSBmb3IgdGhlIGR1cmF0aW9uIG9mIHN1bjhpX2hlYWRw
aG9uZV9hbXBfZXZlbnQuCgpSZWdhcmRzCkNoZW5ZdQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
