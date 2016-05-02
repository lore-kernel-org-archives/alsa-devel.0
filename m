From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH v3 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Tue, 3 May 2016 00:35:18 +0200
Message-ID: <5727D626.809@invoxia.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5A0FRZ52UGeqLJaVF8BiWhzmpNSgQm4B0U1gc2wGU6KhA@mail.gmail.com>
 <20160429035402.GB1944@Asurada>
 <CAG5mAdwFd3avEv6Tup9F0YcmtTQAFgHa2oF6FzjeLaZnonpomA@mail.gmail.com>
 <5727D4E0.8010001@invoxia.com>
 <CAOMZO5DUgXsaynQrpjKyiWtcz9zwXy6YLU4YAC6JWgNfmf6AiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 82DD2260439
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 00:35:21 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id n129so124837244wmn.1
 for <alsa-devel@alsa-project.org>; Mon, 02 May 2016 15:35:21 -0700 (PDT)
In-Reply-To: <CAOMZO5DUgXsaynQrpjKyiWtcz9zwXy6YLU4YAC6JWgNfmf6AiA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Caleb Crome <caleb@crome.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

U29ycnksIEl0IGRpZG4ndCByZWJhc2Ugc2luY2UgNC40LgpJIGNhbiB0cnkgdG9tb3Jyb3cgdG8g
ZmluZCBzb21lIHRpbWUgdG8gZG8gdGhpcy4uLgoKYXJuYXVkCgpMZSAwMy8wNS8yMDE2IDAwOjMy
LCBGYWJpbyBFc3RldmFtIGEgw6ljcml0IDoKPiBIaSBBcm5hdWQsCj4KPiBPbiBNb24sIE1heSAy
LCAyMDE2IGF0IDc6MjkgUE0sIGFybmF1ZC5tb3VpY2hlQGludm94aWEuY29tCj4gPGFybmF1ZC5t
b3VpY2hlQGludm94aWEuY29tPiB3cm90ZToKPgo+PiBObywgbm8gbmV3IHZlcnNpb24gYWZ0ZXIg
dGhpcyBvbmUuCj4gRG8gdGhleSBzdGlsbCBhcHBseSBhZ2FpbnN0IGxpbnV4LW5leHQ/IElmIG5v
dCwgY2FyZSB0byByZWJhc2U/Cj4KPiBUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
