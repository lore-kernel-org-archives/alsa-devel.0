From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: core: Move pcm_mutex up to card
 level from snd_soc_pcm_runtime
Date: Fri, 16 Aug 2019 13:49:24 +0300
Message-ID: <78250be1-5f0f-4cc8-3cb1-2d9f30a5a557@ti.com>
References: <20190813104532.16669-1-peter.ujfalusi@ti.com>
 <1968e008-5311-e624-c997-9433ac624341@linux.intel.com>
 <c040ea94-37c7-3896-3d3b-7baa9f6399fc@ti.com>
 <8558e96c-f78b-56d8-82be-3756617bdfc2@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 254BBF8011F
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 12:49:16 +0200 (CEST)
In-Reply-To: <8558e96c-f78b-56d8-82be-3756617bdfc2@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

CgpPbiAxNS8wOC8yMDE5IDE2LjU2LCBQaWVycmUtTG91aXMgQm9zc2FydCB3cm90ZToKPj4+IEFj
dHVhbGx5IHlvdSAqY2FuKiB0ZXN0IGJ5IHN1Ym1pdHRpbmcgYSBQUiBmb3IgU09GLCBpdCdsbCB0
cmlnZ2VyIHNvbWUKPj4+IHRlc3RzIG9uIEludGVsIHBsYXRmb3JtcyB1c2luZyBEUENNLiBJdCdz
IG5vdCBnb2luZyB0byB0ZXN0IGFueXRoaW5nCj4+PiByZWxhdGVkIHRvIHRoZSBjb21wcmVzc2Vk
IEFQSSBidXQgaXQncyBiZXR0ZXIgdGhhbiBub3RoaW5nLgo+Pgo+PiBHb29kIHRvIGtub3cgYW5k
IHRoYW5rcy4KPj4gSSB3b3VsZCBub3QgdGhvdWdodCBvZiBhYnVzaW5nIHRoZSBTT0YgcHJvamVj
dCB0byBydW4gdGVzdHMsIG5vdCB0aGF0IEkKPj4ga25vdyBob3cgdG8gdHJpZ2dlciB0aGUgcmln
aHQgdGVzdHMgOykKPiAKPiB3ZWxsIHdlIHdpbGwgcnVuIHRob3NlIHRlc3RzIGFueXdheXMgd2hl
biB3ZSBkbyB0aGUgd2Vla2x5IG1lcmdlcywgYW5kCj4gd2hlbiBpbiBkb3VidCBpdCBtaWdodCBi
ZSBtb3JlIHByb2R1Y3RpdmUgZm9yIGFuIEFMU0EgY29udHJpYnV0b3IgdG8gcnVuCj4gdGhlIHRl
c3RzIGFoZWFkIG9mIHRpbWUgdGhhbiByZXBvcnQgdGhhdCB0aGluZ3MgYXJlIGJyb2tlbiBhZnRl
ciB0aGUKPiBtZXJnZSAoYXMgc2VlbiAyIHdlZWtzIGluIGEgcm93IHdpdGggdGhlIG1vZHVsZV9w
dXQgYW5kIGNvbXBpbGF0aW9uIGlzc3VlcykKCkknbGwga2VlcCBpbiBtaW5kLCBkbyB5b3UgaGF2
ZSBzb21lIGRvY3VtZW50YXRpb24gb24gdGhlIHRlc3RzPwoKPj4+IEkgdG9vayB0aGlzIHBhdGNo
IGFuZCBjcmVhdGVkIG9uZSBQUiBhcyBhbiBleGFtcGxlCj4+PiBodHRwczovL2dpdGh1Yi5jb20v
dGhlc29mcHJvamVjdC9saW51eC9wdWxsLzExMzIKPj4KPj4gU2hvdWxkIEkgYmUgd29ycmllZCBi
ZWNhdXNlIG9mIHlvdXIgY29tbWVudCB0aGVyZSBzYXlpbmcgJ0kgaGF2ZSBubyBpZGVhCj4+IHdo
eSB0aGUgQllUX05PQ09ERUMgbW9kZSBmYWlscywgdGhlcmUncyBubyBpbmZvcm1hdGlvbiBwcm92
aWRlZC4nID8KPiAKPiBSZWRvaW5nIHRoZSB0ZXN0cyByZW1vdmVzIHRoYXQgZXJyb3IsIHNvIHRo
aXMgbG9va3MgZmluZS4gTXVzdCBoYXZlIGJlZW4KPiBhIENJIGdsaXRjaAoKSHJtLCBkaWQgaXQg
aGFkIHRoZSBzYW1lIGZhaWx1cmUgdy9vIG15IHBhdGNoPyBSZW9yZGVyaW5nIHRlc3RzIG1pZ2h0
Cmp1c3QgaGlkZSBhIGJ1ZyBzb21ld2hlcmUuLi4KCj4+PiBXaWxsIHNoYXJlIHJlc3VsdHMgd2hl
biBJIGhhdmUgdGhlbS4KPiAKPiBTbyBmYXIgbm8gaXNzdWVzLiBzbyBGV0lXIHNpbmNlIGl0J3Mg
anVzdCAxc3Qgb3JkZXIgYXV0b21hdGljIHRlc3RpbmcKPiAKPiBUZXN0ZWQtYnk6IFBpZXJyZS1M
b3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20+CgpUaGFu
ayB5b3UhCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5r
YXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4g
S290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
