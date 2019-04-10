From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the
 process_option table with function
Date: Wed, 10 Apr 2019 10:54:24 -0700
Message-ID: <20190410175424.GB24002@Asurada-Nvidia.nvidia.com>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410080052.GA5180@Asurada>
 <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410095129.GA3468@Asurada>
 <VE1PR04MB6479A2AA38FB6A27E120A441E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E34EF8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 19:54:29 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id y13so1915198pfm.11
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 10:54:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479A2AA38FB6A27E120A441E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBBcHIgMTAsIDIwMTkgYXQgMTA6MzQ6MDVBTSArMDAwMCwgUy5qLiBXYW5nIHdyb3Rl
Ogo+ID4gT24gV2VkLCBBcHIgMTAsIDIwMTkgYXQgMDg6MjY6NTlBTSArMDAwMCwgUy5qLiBXYW5n
IHdyb3RlOgo+ID4gPiA+IElzIGl0IHBvc3NpYmxlIHRvIHVwZGF0ZSB0aGUgdGFibGU/IEl0J2Qg
YmUgd2F5IHF1aWNrZXIgdG8gdXNlCj4gPiA+ID4gbG9va3VwIHRhYmxlIHRoYW4gcmVhbC10aW1l
IGNhbGN1bGF0aW9uIGFsbCB0aGUgdGltZS4gSSBiZWxpZXZlIHlvdQo+ID4gPiA+IGNhbiBzaW1w
bHkgY2FsY3VsYXRlIGFsbCB0aGUgdmFsdWVzIG91dCBmb3IgMTJLSHogYW5kIDI0S0h6IHNpbmNl
Cj4gPiA+ID4geW91IGhhdmUgdGhlIGZ1bmN0aW9uLiBJZiB0aGVyZSBhcmUgY2VydGFpbiBjb21i
aW5hdGlvbnMgb2YgdGhlc2UKPiA+ID4gPiB0d28gbm90IGJlaW5nIHN1cHBvcnRlZCwgdGhlbiB3
ZSBjb3VsZCBtYXJrIGl0IHdpdGggYSBzcGVjaWFsIHZhbHVlIGFuZAo+ID4gYWRkIGFuIGlmLWNo
ZWNrIHRvIGVycm9yIG91dC4KPiA+ID4gPgo+ID4gPgo+ID4gPiBZZXMsICBidXQgSSB0aGluayB0
aGUgZnVuY3Rpb24gc2hvdWxkIGJlIG1vcmUgZmxleGlibGUsIGlmIHNvbWVkYXkgd2UKPiA+ID4g
bmVlZCB0byBzdXBwb3J0IE90aGVyIHNhbXBsZSByYXRlLCBvbmx5IG5lZWQgdG8gdXBkYXRlIHRo
ZSBsaXN0Lgo+ID4gCj4gPiBHaXZlbiB0aGUgZmFjdCB0aGF0IHRoZSBvd25lciBvZiB0aGUgZnVu
Y3Rpb24gY2Fubm90IGdpdmUgbW9yZSBjb21tZW50cywgSQo+ID4gZmVlbCB0aGUgZnVuY3Rpb24g
d291bGRuJ3QgYmUgdmVyeSBtYWludGFpbmFibGUgYXMgbm9uZSBvZiB1cyB1bmRlcnN0YW5kcyBp
dAo+ID4gd2VsbC4gT24gdGhlIG90aGVyIGhhbmQsIHlvdSdsbCBuZWVkIHRvIHVwZGF0ZSB0aGUg
c3VwcG9ydGVkIEkvTyByYXRlIGxpc3RzCj4gPiBhbnl3YXksIHNvIHdoeSBub3QganVzdCB1cGRh
dGUgdGhlIHRhYmxlIGFzIHdlbGw/IFRoZSBzdXBwb3J0ZWQgc2FtcGxlCj4gPiByYXRlcyBmcm9t
IEFMU0EgYXJlIGxpbWl0ZWQgdG9vLiBPdmVyYWxsLCBJIHRoaW5rIHRoYXQgY29udGludWUgdXNp
bmcgYSBsb29rdXAKPiA+IHRhYmxlIHdpbnMuCj4gCj4gQWxzYSBzdXBwb3J0IFNORFJWX1BDTV9S
QVRFX0tOT1QsIHdlIGNhbiBkZWZpbmUgdGhlIHJhdGUgdGhhdCB3ZSB3YW50Cj4gVG8gc3VwcG9y
dCwgIGFuZCB1c2UgZnVuY3Rpb24gaXMgbW9yZSBmbGV4aWJsZSwgYW5kIHdlIGhhdmUgdXNlIHRo
ZSBmdW5jdGlvbgo+IEludGVybmFsbHkgZm9yIGxvbmcgdGltZSwgaXQgaXMgc3RhYmxl8J+YigoK
T0suIEkgd2lsbCB0cnkgdG8gaW5kdWxnZSBpdC4gTGV0J3Mgc2VlIHlvdXIgbmV4dCB2ZXJzaW9u
IGZpcnN0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
