Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C219BCA5FF1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:58:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC24260220;
	Wed,  7 Oct 2026 08:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC24260220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791356297;
	bh=8dmL0LukSpRiln6yna50c+zTlXYL+Z9rs/NNHq7/NQc=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ukRIv7YDN6cMEytr+3S/SJzmLv1Y3hO/Lw28wIiM8VKAooIvDl3voAuPBm8SZGIgo
	 P1x+WUv3RC4aaJ1F7LF7oMHckmVISsVyZG5E7kgTv+Lf0Uunfu1Lk4qzCImk3OwTA2
	 qldUQcaPa44tZTt6G+wRKRwzCv/1KIPcryhONPX4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 711DEF8065E; Wed,  7 Oct 2026 08:57:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F291F80641;
	Wed,  7 Oct 2026 08:57:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10D04F80548; Sat,  3 Oct 2026 03:42:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=79.135.106.102
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790991718;
	b=KYJ1vKQ0xyAqzIto0oqo2Nh6gljAmovcwVJQdegpUzMApUX27HBTycXMgw1fyCaJzB/y
	 BXW7zjPk4l4bKt6WHXG3A73OKUn4GB/ZMyIsfMn8HVImr3DvDYJCq2Sab8NKL6vaP7hD4
	 GVUtXV8XZwkiehOD2mx3v+Ug76GHYy2a2+B5H0vgPrpweaOqFwAD/Cq4M1+YmjOZfoXnX
	 IK8BAGvcB7tuRFRFOx37cOTmvjSJnV1w4WbCCG+Go32+nh6fCsHy/47p3CDCGmvV2lrb6
	 rtG3yTfKgsXP+hOl40tmaWUqN1Uf1noLKZKcC6zpQ2Uqlgq1QM8KvSskztbi1g2eZgA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790991718;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version;
	bh=avIZ3xIOrNERBwVT/Y0tKRuVUWKhOPgUjqQnLM/kQTk=;
	b=mzfkKQCcAyaTDr3hVQdqIZI8CaSUVZU2bk2u1PE0VgU3RV95r826MF6EUeDVbqXgbdYk
	 H+dhjnOmue+Nu6TwTfJW9lw3gyRTo7g+J51o5iXvq1YZ0lh7Y/78nXnzqT60+MrV/adLe
	 3AUOLULwYR7ahJvu+bLBf7SAf+FEulh1LWCsKkgZ4/Lg3UsNZVDf6zOjr1yeeL2uke5N7
	 IsY79R1tkISZ7u+4N4Dg3OYuuwr4RzrRDSYMRoGl44530tMrpPwt1Is4JbzD4VktIE0N7
	 AC5UEsY3uHYFVteD2YndEENJKON5SDzawPketGroSIrmJMokabnF6mL0I33hWI/5WQA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=rzmy4uojrzajzovvod53ou5aoq.protonmail2 header.b=IjrG22TV;
	arc=none smtp.remote-ip=79.135.106.102
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch
 [79.135.106.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 28AE2F80246
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 03:41:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28AE2F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=rzmy4uojrzajzovvod53ou5aoq.protonmail2 header.b=IjrG22TV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rzmy4uojrzajzovvod53ou5aoq.protonmail2; t=1790991715;
	x=1791250915; bh=ns7+f9A0rXK/RMXn0r3RsErrjH5JxWXOliIgUCJ5RRY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IjrG22TVX3kOH8UJbGvnSUbk0yLHDPKT1Rzww0Fg39QpHaypXgWYqV1vEzLcU0853
	 +LOv9EbT0fzqBF+mLphx2oqWhnXlFet6WaIl++Kv2TuNh9DXPqBsfs2nWIZmt9W/u0
	 kyb3XTIH6wm1fJu53GovwPr6unqY6HgL4UQ/qBJoYaCrFAS9OtBoGTWzXP4HtGaid5
	 t2K0kqSgXnUE1wU+FM/iLJRwAkewfS4EGb6lU25ypO1ofcLPqcRHACfJxxFI+Ic/S2
	 TsBLJ53rI7uo5s5n2qQwrzaJcfBl9oeIGEKydsGkh8tr/Pc3AWQKKJWvlnAtEg6CGK
	 5bMy/i6NcIc8Q==
Date: Sat, 03 Oct 2026 01:41:51 +0000
To: Takashi Iwai <tiwai@suse.de>
From: dchristensen8 <dchristensen8@proton.me>
Cc: "tiwai@suse.com" <tiwai@suse.com>, "perex@perex.cz" <perex@perex.cz>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/ca0132: Add Sound BlasterX AE-5 external RGB
 LED strip support
Message-ID: 
 <qOF5tUXvi5MWOfDFTuE8fU0Wiqk3eTZMHhdWpsxR-JFuTXCwEeayR_yxgYmAQ6SIHogQmMkvtM8otTM9z1Wi4KIujjj6LtQPORGuegUuRmM=@proton.me>
In-Reply-To: <87ik3kyy0h.wl-tiwai@suse.de>
References: 
 <I690osvh2wujN3P04R4abtKFqOqtIiC-qin2ZEFs9q8kKU7-qfIg2cya4BuHS7Vg83Wkon6BCJGtVIxeJVfRZ8nG07laTUlv-fJjELMgp1Y=@proton.me>
 <87ik3kyy0h.wl-tiwai@suse.de>
Feedback-ID: 45895322:user:proton
X-Pm-Message-ID: 1459dfcaa834d432a8a0a0749aabeb3f1b6e4c98
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_jq0YukUUeP2mIo9ttNfYyyoDxpnZe6r6R87by9fBMAM"
X-MailFrom: dchristensen8@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FTNEFQ44R2BTVLPV7ST3X5XIRVS37GC5
X-Message-ID-Hash: FTNEFQ44R2BTVLPV7ST3X5XIRVS37GC5
X-Mailman-Approved-At: Wed, 07 Oct 2026 06:57:15 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FTNEFQ44R2BTVLPV7ST3X5XIRVS37GC5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--b1=_jq0YukUUeP2mIo9ttNfYyyoDxpnZe6r6R87by9fBMAM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Thanks for the review! I moved the dma-mapping.h include into the main head=
er block, added the s->opened check to ae5_strip_find_stream(), wrapped all=
 the strip code in IS_ENABLED(CONFIG_SND_HDA_DSP_LOADER) with a no-op stub =
when it's disabled, and updated the put callbacks to return 1 when the valu=
es actually change.

One other thing: I was talking with the maintainer of openrgb and he sugges=
ted a patch to make zone0 led's work via the same mechanism (this card has =
onboard led's at zone0 and external led's at zone1). Should I add that to t=
his patch or submit a separate patch after this one is completed?

Attached is v3.

Thanks,
Devin

On Friday, October 2nd, 2026 at 10:31 AM, Takashi Iwai <tiwai@suse.de> wrot=
e:

> On Fri, 02 Oct 2026 03:41:50 +0200,
> dchristensen8 wrote:
> >
> >
> > Takashi,
> >
> > Thank you for your assistance on this! I updated it to use CLASS
> > (snd_hda_power_pm, pm)(codec) for the power management call, which clea=
ned up
> > all the manual power-down error exits nicely.
> >
> > Attached is the proper v2 patch for upstreaming.
>=20
> Now reviewing further in details, and some issues found:
>=20
> > --- a/sound/hda/codecs/ca0132.c
> > +++ b/sound/hda/codecs/ca0132.c
> > @@ -35,6 +35,8 @@
> >  #include <sound/tlv.h>
> >  #endif
> >
> > +#include <linux/dma-mapping.h>
>=20
> Let's move this into the block with other header file inclusions.
> Not needed to be alone here.
>=20
>=20
> > +static struct hdac_stream *ae5_strip_find_stream(struct hda_codec *cod=
ec)
> > +{
> > +=09struct ca0132_spec *spec =3D codec->spec;
> > +=09struct hdac_bus *bus =3D &codec->bus->core;
> > +=09struct hdac_stream *s, *dsp =3D NULL, *first =3D NULL;
> > +
> > +=09guard(spinlock_irqsave)(&bus->reg_lock);
> > +=09list_for_each_entry(s, &bus->stream_list, list) {
> > +=09=09if (s->direction !=3D SNDRV_PCM_STREAM_PLAYBACK)
> > +=09=09=09continue;
> > +=09=09if (s->running || s->locked)
> > +=09=09=09continue;
>=20
> It should also check s->opened, too.
>=20
> > +=09for (;;) {
> > +=09=09hstr =3D ae5_strip_find_stream(codec);
> > +=09=09if (!hstr) {
> > +=09=09=09if (--retries <=3D 0) {
> > +=09=09=09=09codec_warn(codec, "AE5 strip: no free azx stream after ret=
ries\n");
> > +=09=09=09=09return -EBUSY;
> > +=09=09=09}
> > +=09=09=09usleep_range(5000, 10000);
> > +=09=09=09continue;
> > +=09=09}
> > +
> > +=09=09stream_tag =3D snd_hdac_dsp_prepare(hstr, format, AE5_STRIP_DMA_=
SIZE, &dmab);
>=20
> The function needs CONFIG_SND_HDA_DSP_LOADER, and it's not always
> selected.  Although the compile would works, it makes no sense to keep
> the code without the support code.
>=20
>=20
> > +static int ae5_strip_ctl_put(struct snd_kcontrol *kcontrol,
> > +=09=09=09     struct snd_ctl_elem_value *ucontrol)
> > +{
> > +=09struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> > +=09struct ca0132_spec *spec =3D codec->spec;
> > +=09u32 colors[AE5_STRIP_MAX_LEDS];
> > +=09int i, num_leds;
> > +
> > +=09guard(mutex)(&spec->ae5_strip_mutex);
> > +=09num_leds =3D spec->ae5_strip_cur_num_leds;
> > +=09for (i =3D 0; i < num_leds; i++) {
> > +=09=09u8 r =3D ucontrol->value.bytes.data[i * 3 + 0];
> > +=09=09u8 g =3D ucontrol->value.bytes.data[i * 3 + 1];
> > +=09=09u8 b =3D ucontrol->value.bytes.data[i * 3 + 2];
> > +
> > +=09=09colors[i] =3D ((u32)g << 16) | ((u32)r << 8) | (u32)b;
> > +=09}
> > +=09memcpy(spec->ae5_strip_cur_colors, colors, sizeof(u32) * num_leds);
> > +=09ae5_strip_send_frame(codec, colors, num_leds);
> > +=09return 0;
>=20
> In general, the put callback should return 1 if the values are
> modified.
>=20
>=20
> thanks,
>=20
> Takashi
> 
--b1=_jq0YukUUeP2mIo9ttNfYyyoDxpnZe6r6R87by9fBMAM
Content-Type: text/x-patch;
 name=v3-0001-ALSA-hda-ca0132-Add-Sound-BlasterX-AE-5-external-.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=v3-0001-ALSA-hda-ca0132-Add-Sound-BlasterX-AE-5-external-.patch

RnJvbSAyZDg0MzA2NTM0ZDY3ZGIxMTAxODliNWJkMTJkZGI3YTMwZmJiZjE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZXZpbiBDaHJpc3RlbnNlbiA8ZGNocmlzdGVuc2VuOEBwcm90
b24ubWU+CkRhdGU6IEZyaSwgMiBPY3QgMjAyNiAyMTozMDoyMCAtMDQwMApTdWJqZWN0OiBbUEFU
Q0ggdjNdIEFMU0E6IGhkYS9jYTAxMzI6IEFkZCBTb3VuZCBCbGFzdGVyWCBBRS01IGV4dGVybmFs
IFJHQiBMRUQKIHN0cmlwIHN1cHBvcnQKClRoZSBTb3VuZCBCbGFzdGVyWCBBRS01IGFuZCBBRS01
IFBsdXMgZXhwb3NlIGEgMy1waW4gNVYgYWRkcmVzc2FibGUgUkdCCmhlYWRlciBkcml2ZW4gZGly
ZWN0bHkgYnkgdGhlIENBMDExMyBQQ0llLXRvLUhELUF1ZGlvIGJyaWRnZS4gUmF0aGVyCnRoYW4g
dXNpbmcgdGhlIENBMDEzMiBEU1Agb3IgTU1JTyBHUElPLCB0aGUgQ0EwMTEzIGNvbnRhaW5zIGFu
CmF1dG9ub21vdXMgSERBIGxpbmsgc25pZmZlciB0aGF0IHNub29wcyBhIGRlc2lnbmF0ZWQgSERB
IERNQSBwbGF5YmFjawpzdHJlYW0sIGV4dHJhY3RzIHRoZSAyNC1iaXQgR1JCIGNvbG9yIHBheWxv
YWQsIGFuZCBzZXJpYWxpemVzIGl0IGFzCjgwMCBrSHogc2luZ2xlLXdpcmUgTlJaIHB1bHNlcyB0
byB0aGUgc3RyaXAgKFdTMjgxMkIgcHJvdG9jb2wpLgoKRXhwb3NlIHRoZSBzdHJpcCB0aHJvdWdo
IHZvbGF0aWxlIGNhcmQgY29udHJvbCBlbGVtZW50czoKCiAgIkFFLTUgTEVEIFN0cmlwIiAgICAg
ICAgKFJXLCBCWVRFUyk6IDMwMC1ieXRlIFJHQiBwYXlsb2FkIHJlcHJlc2VudGluZwogICAgICAg
ICAgICAgICAgICAgICAgICAgIHVwIHRvIDEwMCBhZGRyZXNzYWJsZSBMRURzICgzIGJ5dGVzIHBl
ciBMRUQpLgogICJBRS01IExFRCBTdHJpcCBDb3VudCIgIChSVywgSU5URUdFUik6IEFjdGl2ZSBM
RUQgY291bnQgKDEuLjEwMCkuCgpUaGUgY29udHJvbHMgYXJlIG1hcmtlZCB3aXRoIElGQUNFX0NB
UkQgYW5kIFNORFJWX0NUTF9FTEVNX0FDQ0VTU19WT0xBVElMRQpzbyBjaGFuZ2VzIGRvIG5vdCB0
cmlnZ2VyIHVubmVjZXNzYXJ5IGF1ZGlvIGRhZW1vbiB3YWtldXBzIG9yIHN0YXRlCnJlc3RvcmF0
aW9uIGJ5IGFsc2FjdGwuCgpXcml0ZXMgYWxsb2NhdGUgYW4gaWRsZSBIREEgcGxheWJhY2sgc3Ry
ZWFtLCBmb3JtYXQgYSAzMiBLQiBETUEgYnVmZmVyCnBvcHVsYXRlZCB3aXRoIHJlcGVhdGluZyBX
UzI4MTIgZnJhbWVzIChwcmVhbWJsZSwgYXVkaW8gd29yZHMgcGVyIExFRCwKYW5kIHJlc2V0IGdh
cCksIGNvbmZpZ3VyZSB0aGUgQ0EwMTEzIEJBUjIgc2VyaWFsaXplcnMgYW5kIHN0cmVhbS10YWcK
cGluIG11eCwgYW5kIHB1bHNlIHRoZSBzdHJlYW0gbG9uZyBlbm91Z2ggZm9yIHRoZSByZXNldCBs
YXRjaCB0byBmaXJlLgpBY2Nlc3MgaXMgc2VyaWFsaXplZCB3aXRoIGEgcGVyLXNwZWMgbXV0ZXgs
IGFuZCB0aGUgY29udHJvbHMgYXJlIG9ubHkKcmVnaXN0ZXJlZCBvbiBRVUlSS19BRTUgZGV2aWNl
cy4KClRoZSBzdHJpcCB0cmFuc3BvcnQgdXNlcyBzbmRfaGRhY19kc3BfcHJlcGFyZSgpIC8gc25k
X2hkYWNfZHNwX2NsZWFudXAoKSwKd2hpY2ggcmVxdWlyZSBDT05GSUdfU05EX0hEQV9EU1BfTE9B
REVSLiBUaGUgc3RyaXAgY29udHJvbCBjb2RlIGFuZAphc3NvY2lhdGVkIHNwZWMgZmllbGRzIGFy
ZSB0aGVyZWZvcmUgY29uZGl0aW9uYWxseSBjb21waWxlZCB1bmRlcgpJU19FTkFCTEVEKENPTkZJ
R19TTkRfSERBX0RTUF9MT0FERVIpLCB3aXRoIGEgbm8tb3Agc3R1YiBmb3IKYWU1X2FkZF9zdHJp
cF9jb250cm9scygpIHdoZW4gdGhlIG9wdGlvbiBpcyBkaXNhYmxlZC4KClNpZ25lZC1vZmYtYnk6
IERldmluIENocmlzdGVuc2VuIDxkY2hyaXN0ZW5zZW44QHByb3Rvbi5tZT4KLS0tCiBzb3VuZC9o
ZGEvY29kZWNzL2NhMDEzMi5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3NvdW5kL2hkYS9jb2RlY3MvY2EwMTMyLmMgYi9zb3VuZC9oZGEvY29kZWNzL2NhMDEz
Mi5jCmluZGV4IDg5NTgwMDkxNy4uMDM2YWU3MzU4IDEwMDY0NAotLS0gYS9zb3VuZC9oZGEvY29k
ZWNzL2NhMDEzMi5jCisrKyBiL3NvdW5kL2hkYS9jb2RlY3MvY2EwMTMyLmMKQEAgLTE4LDYgKzE4
LDcgQEAKICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogI2luY2x1ZGUgPGxpbnV4L2lvLmg+CiAj
aW5jbHVkZSA8bGludXgvcGNpLmg+CisjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KICNp
bmNsdWRlIDxhc20vaW8uaD4KICNpbmNsdWRlIDxzb3VuZC9jb3JlLmg+CiAjaW5jbHVkZSA8c291
bmQvaGRhX2NvZGVjLmg+CkBAIC0zNSw4ICszNiw2IEBACiAjaW5jbHVkZSA8c291bmQvdGx2Lmg+
CiAjZW5kaWYKIAotI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+Ci0KICNkZWZpbmUgRkxP
QVRfWkVSTwkweDAwMDAwMDAwCiAjZGVmaW5lIEZMT0FUX09ORQkweDNmODAwMDAwCiAjZGVmaW5l
IEZMT0FUX1RXTwkweDQwMDAwMDAwCkBAIC0xMTY3LDEwICsxMTY2LDEyIEBAIHN0cnVjdCBjYTAx
MzJfc3BlYyB7CiAJICovCiAJYm9vbCB1c2VfYWx0X2NvbnRyb2xzOwogCisjaWYgSVNfRU5BQkxF
RChDT05GSUdfU05EX0hEQV9EU1BfTE9BREVSKQogCS8qIEFFLTUgV1MyODEyIHN0cmlwIGNvbnRy
b2wgKi8KIAlzdHJ1Y3QgbXV0ZXggYWU1X3N0cmlwX211dGV4OwogCXUzMiBhZTVfc3RyaXBfY3Vy
X2NvbG9yc1tBRTVfU1RSSVBfTUFYX0xFRFNdOwogCWludCBhZTVfc3RyaXBfY3VyX251bV9sZWRz
OworI2VuZGlmCiB9OwogCiAvKgpAQCAtNjg1NSw3ICs2ODU2LDE0IEBAIHN0YXRpYyBpbnQgY2Ew
MTMyX2FsdF9hZGRfbWljX2Jvb3N0X2VudW0oc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAKIH0K
IAorI2lmIElTX0VOQUJMRUQoQ09ORklHX1NORF9IREFfRFNQX0xPQURFUikKIHN0YXRpYyBpbnQg
YWU1X2FkZF9zdHJpcF9jb250cm9scyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYyk7CisjZWxzZQor
c3RhdGljIGlubGluZSBpbnQgYWU1X2FkZF9zdHJpcF9jb250cm9scyhzdHJ1Y3QgaGRhX2NvZGVj
ICpjb2RlYykKK3sKKwlyZXR1cm4gMDsKK30KKyNlbmRpZgogCiAvKgogICogQWRkIGhlYWRwaG9u
ZSBnYWluIGVudW1lcmF0ZWQgY29udHJvbCBmb3IgdGhlIEFFLTUuIFRoaXMgc3dpdGNoZXMgYmV0
d2VlbgpAQCAtODMzMyw2ICs4MzQxLDcgQEAgc3RhdGljIHZvaWQgc2J6X3NldHVwX2RlZmF1bHRz
KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogLyoKICAqIFNvdW5kIEJsYXN0ZXJYIEFFLTUgRXh0
ZXJuYWwgV1MyODEyQiBSR0IgTEVEIFN0cmlwIFRyYW5zcG9ydAogICovCisjaWYgSVNfRU5BQkxF
RChDT05GSUdfU05EX0hEQV9EU1BfTE9BREVSKQogI2RlZmluZSBBRTVfU1RSSVBfRE1BX1NJWkUJ
CTB4ODAwMAogI2RlZmluZSBBRTVfU1RSSVBfVE9UQUxfV09SRFMJCShBRTVfU1RSSVBfRE1BX1NJ
WkUgLyBzaXplb2YodTMyKSkKICNkZWZpbmUgQUU1X1NUUklQX1BSRUFNQkxFX1dPUkRTCTUKQEAg
LTgzODAsNyArODM4OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgaGRhY19zdHJlYW0gKmFlNV9zdHJpcF9m
aW5kX3N0cmVhbShzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5
KHMsICZidXMtPnN0cmVhbV9saXN0LCBsaXN0KSB7CiAJCWlmIChzLT5kaXJlY3Rpb24gIT0gU05E
UlZfUENNX1NUUkVBTV9QTEFZQkFDSykKIAkJCWNvbnRpbnVlOwotCQlpZiAocy0+cnVubmluZyB8
fCBzLT5sb2NrZWQpCisJCWlmIChzLT5vcGVuZWQgfHwgcy0+cnVubmluZyB8fCBzLT5sb2NrZWQp
CiAJCQljb250aW51ZTsKIAkJaWYgKCFmaXJzdCkKIAkJCWZpcnN0ID0gczsKQEAgLTg1OTMsNyAr
ODYwMiw3IEBAIHN0YXRpYyBpbnQgYWU1X3N0cmlwX2N0bF9wdXQoc3RydWN0IHNuZF9rY29udHJv
bCAqa2NvbnRyb2wsCiAJc3RydWN0IGhkYV9jb2RlYyAqY29kZWMgPSBzbmRfa2NvbnRyb2xfY2hp
cChrY29udHJvbCk7CiAJc3RydWN0IGNhMDEzMl9zcGVjICpzcGVjID0gY29kZWMtPnNwZWM7CiAJ
dTMyIGNvbG9yc1tBRTVfU1RSSVBfTUFYX0xFRFNdOwotCWludCBpLCBudW1fbGVkczsKKwlpbnQg
aSwgbnVtX2xlZHMsIGNoYW5nZTsKIAogCWd1YXJkKG11dGV4KSgmc3BlYy0+YWU1X3N0cmlwX211
dGV4KTsKIAludW1fbGVkcyA9IHNwZWMtPmFlNV9zdHJpcF9jdXJfbnVtX2xlZHM7CkBAIC04NjA0
LDkgKzg2MTMsMTMgQEAgc3RhdGljIGludCBhZTVfc3RyaXBfY3RsX3B1dChzdHJ1Y3Qgc25kX2tj
b250cm9sICprY29udHJvbCwKIAogCQljb2xvcnNbaV0gPSAoKHUzMilnIDw8IDE2KSB8ICgodTMy
KXIgPDwgOCkgfCAodTMyKWI7CiAJfQotCW1lbWNweShzcGVjLT5hZTVfc3RyaXBfY3VyX2NvbG9y
cywgY29sb3JzLCBzaXplb2YodTMyKSAqIG51bV9sZWRzKTsKKwljaGFuZ2UgPSBtZW1jbXAoc3Bl
Yy0+YWU1X3N0cmlwX2N1cl9jb2xvcnMsIGNvbG9ycywKKwkJCXNpemVvZih1MzIpICogbnVtX2xl
ZHMpICE9IDA7CisJaWYgKGNoYW5nZSkKKwkJbWVtY3B5KHNwZWMtPmFlNV9zdHJpcF9jdXJfY29s
b3JzLCBjb2xvcnMsCisJCSAgICAgICBzaXplb2YodTMyKSAqIG51bV9sZWRzKTsKIAlhZTVfc3Ry
aXBfc2VuZF9mcmFtZShjb2RlYywgY29sb3JzLCBudW1fbGVkcyk7Ci0JcmV0dXJuIDA7CisJcmV0
dXJuIGNoYW5nZTsKIH0KIAogc3RhdGljIGludCBhZTVfc3RyaXBfbnVtX2xlZHNfaW5mbyhzdHJ1
Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwKQEAgLTg2NDUsNyArODY1OCw3IEBAIHN0YXRpYyBp
bnQgYWU1X3N0cmlwX251bV9sZWRzX3B1dChzdHJ1Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwK
IAkJcmV0dXJuIDA7CiAJc3BlYy0+YWU1X3N0cmlwX2N1cl9udW1fbGVkcyA9IHZhbDsKIAlhZTVf
c3RyaXBfc2VuZF9mcmFtZShjb2RlYywgc3BlYy0+YWU1X3N0cmlwX2N1cl9jb2xvcnMsIHZhbCk7
Ci0JcmV0dXJuIDA7CisJcmV0dXJuIDE7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tj
b250cm9sX25ldyBhZTVfc3RyaXBfY3Rsc1tdID0gewpAQCAtODY4MSw2ICs4Njk0LDcgQEAgc3Rh
dGljIGludCBhZTVfYWRkX3N0cmlwX2NvbnRyb2xzKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQog
CX0KIAlyZXR1cm4gMDsKIH0KKyNlbmRpZiAvKiBDT05GSUdfU05EX0hEQV9EU1BfTE9BREVSICov
CiAKIHN0YXRpYyB2b2lkIGFlNV9zZXR1cF9kZWZhdWx0cyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2Rl
YykKIHsKQEAgLTkxMDUsOCArOTExOSwxMCBAQCBzdGF0aWMgdm9pZCBjYTAxMzJfaW5pdF9jaGlw
KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCXVuc2lnbmVkIGludCBvbjsKIAogCW11dGV4X2lu
aXQoJnNwZWMtPmNoaXBpb19tdXRleCk7CisjaWYgSVNfRU5BQkxFRChDT05GSUdfU05EX0hEQV9E
U1BfTE9BREVSKQogCW11dGV4X2luaXQoJnNwZWMtPmFlNV9zdHJpcF9tdXRleCk7CiAJc3BlYy0+
YWU1X3N0cmlwX2N1cl9udW1fbGVkcyA9IDEwOworI2VuZGlmCiAKIAkvKgogCSAqIFRoZSBXaW5k
b3dzIGRyaXZlciBhbHdheXMgZG9lcyB0aGlzIHVwb24gc3RhcnR1cCwgd2hpY2ggc2VlbXMgdG8K
QEAgLTk5OTMsNyArMTAwMDksOSBAQCBzdGF0aWMgdm9pZCBjYTAxMzJfZnJlZShzdHJ1Y3QgaGRh
X2NvZGVjICpjb2RlYykKIAlpZiAoc3BlYy0+bWVtX2Jhc2UpCiAJCXBjaV9pb3VubWFwKGNvZGVj
LT5idXMtPnBjaSwgc3BlYy0+bWVtX2Jhc2UpOwogI2VuZGlmCisjaWYgSVNfRU5BQkxFRChDT05G
SUdfU05EX0hEQV9EU1BfTE9BREVSKQogCW11dGV4X2Rlc3Ryb3koJnNwZWMtPmFlNV9zdHJpcF9t
dXRleCk7CisjZW5kaWYKIAlrZnJlZShzcGVjLT5zcGVjX2luaXRfdmVyYnMpOwogCWtmcmVlKGNv
ZGVjLT5zcGVjKTsKIAljb2RlYy0+c3BlYyA9IE5VTEw7Ci0tIAoyLjU1LjAKCg==

--b1=_jq0YukUUeP2mIo9ttNfYyyoDxpnZe6r6R87by9fBMAM--

