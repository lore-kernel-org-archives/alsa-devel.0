From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] ASoC: AMD: Add a fix voltage regulator for
 DA7219 and ADAU7002
Date: Wed, 25 Jul 2018 14:30:04 +0530
Message-ID: <343d6aa1-0687-a6d3-fb1a-3f1365db1e6a@amd.com>
References: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
 <20180720121816.GD10784@sirena.org.uk>
 <50343cff-bad4-7677-851f-f0b818ae7b29@amd.com>
 <20180724171428.GQ13268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730042.outbound.protection.outlook.com [40.107.73.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 88EDE26739D
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 11:00:29 +0200 (CEST)
In-Reply-To: <20180724171428.GQ13268@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

CgpPbiA3LzI0LzIwMTggMTA6NDQgUE0sIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gTW9uLCBKdWwg
MjMsIDIwMTggYXQgMTA6NTY6NDRBTSArMDUzMCwgQWdyYXdhbCwgQWtzaHUgd3JvdGU6Cj4gCj4+
IFRoaXMgYXBwcm9hY2ggc2hvd3MgaW5jb25zaXN0ZW5jaWVzIGFuZCBpbiBzb21lIGJvb3QgY3lj
bGVzIGRhNzIxOSBmYWlscwo+PiB0byBnZXQgcmVndWxhdG9yLiBGb3JtIHRoZSBsb2dzIChiZWxv
dykgaXQgc2hvd3MgdGltZSBnYXAgYmV0d2VlbiB0aGUKPj4gdGltZSB3ZSBjYWxsIOKAnHBsYXRm
b3JtX2RldmljZV9yZWdpc3RlcigmYWNwX2RhNzIxOV9yZWd1bGF0b3IpO+KAnSBhbmQgd2hlbgo+
PiB0aGUgcmVndWxhdG9yIGFjdHVhbGx5IGdldHMgcmVnaXN0ZXJlZC4KPiAKPiBUaGlzIGhhY2sg
aXNuJ3QgZ29pbmcgdG8gaGVscCB3aXRoIHRoYXQgQUZBSUNULCB5b3UncmUgc3RpbGwgcmVnaXN0
ZXJpbmcKPiBhIHBsYXRmb3JtIGRldmljZSBhbmQgcmVseWluZyBvbiBpdCBhcHBlYXJpbmcgaW4g
dGltZT8gIEl0IGp1c3QKPiByZWdpc3RlcnMgbGVzcyBvZnRlbi4KClllcywgSSBhZ3JlZSBhbmQg
YnkgInRoaXMgYXBwcm9hY2giIEkgYWxzbyBtZWFudCByZWdpc3RlcmluZyBwbGF0Zm9ybQpkZXZp
Y2UgYW5kIHdhaXRpbmcgZm9yIGl0cyBwcm9iZSB0byBoYXBwZW4uCgpJbnN0ZWFkIG9mIGFkZGlu
ZyBhIHBsYXRmb3JtIGRldmljZSB0byB0aGUgcmVnLWZpeGVkLXZvbHRhZ2UsIHdlIGNhbgpyZWdp
c3RlciBhIHJlZ3VsYXRvciBhbmQgdGh1cyBub3Qgd2FpdCBmb3IgdGhlIHByb2JlIHRvIG9jY3Vy
LgpQdXNoaW5nIGEgdjIgd2l0aCB0aGlzIGNoYW5nZSB3aGljaCBoYXMgY29uc2lzdGVudCBiZWhh
dmlvci4KClRoYW5rcywKQWtzaHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
