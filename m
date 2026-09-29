Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD237CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:11:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 111356030D;
	Tue, 29 Sep 2026 21:11:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 111356030D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790709086;
	bh=9uSCZ5sWyZ1CBoBDl8Q6S3AGCXxU6Y97lD816RJ3qTI=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZbFpJMkFxivu9WfdixgyeqP5fqPfAsiJDMglfJ4rz5noKfpwle/MFSABUpOhEFyeQ
	 oxzOJpRI71L/n4Q4A5dY8kiutR/jyRmEsgG0cepfM8gdZRRTcWLWE/NsNzRz+bl03r
	 zP1QNDPUWbRsW/MmXrCBDnY2deyj308kNKbTU/QA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B31AF896C7; Tue, 29 Sep 2026 21:07:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9B00F896DF;
	Tue, 29 Sep 2026 21:07:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8186BF8055C; Tue, 29 Sep 2026 16:22:17 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=185.70.43.25
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790691735;
	b=bAPs7qgw/lr+5qz+O38TRI6YeqDO2sPMi/ARBbsm2BFr/AKzPoNpTuXhCmDjQPstfeE3
	 S3n4QeMoNx4GEMlfBbaaX+utB4dzvh7+Rbx5j62EXLk2nOvQNLItR4Vo3EbAsmGbComi9
	 D2LnTVtxPKRIij9mgQvogWX2obAaeoXlgGPEybtTD/YCAz0FDSuKC3jUXSkB6nCyKD2T9
	 SkdcQxK8/sQpfeOgDbUhyEn0K0ajoEMMVrPpwfuIJtDC2WhtsuTvn5DMxBH2z9uhJNkhq
	 gCjUcd8Xj3QrpOkOUlJ59bccuFkIE9CXxmlIU6ajmta8mgJck+Kqg9tkuG1oTnYo+WQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790691735;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version;
	bh=9uSCZ5sWyZ1CBoBDl8Q6S3AGCXxU6Y97lD816RJ3qTI=;
	b=ZobgyZjMoIScJvUCSlhhTFQliEn58nCyO/YlC1MijUvTGOS+6FvM+9IMIjuT3n66J7OK
	 utQmSn0LriZJlCIQntb8EIrIzqtum8sEWTjzBN3n1Sap4q1EUlohNyJMfMdqpF1j3fGML
	 I8pkpiU879+lyaYIiYGV08dKYkGlKZ6nomdTL1MtdSUIzAAsyfBpmFvt6JHDNHj6W7Pya
	 dO9z6zIHeTn1S3uLsoXgQ5ljFhhblxeD2v2w74Utw2DTg3kf35w02/gly0NNdhjaceqq7
	 vKMHz2QVXLbTqIgfBRa/uo2qbfQIF8Z+2Xfdwxs/1VnB/LpjeYtbhi6AK//0SGzwiwA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=yginvw56ybc55g4ctypjuzbqru.protonmail2 header.b="ng/83GJp";
	arc=none smtp.remote-ip=185.70.43.25
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch
 [185.70.43.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7EADAF80020
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 16:22:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EADAF80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=yginvw56ybc55g4ctypjuzbqru.protonmail2 header.b=ng/83GJp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=yginvw56ybc55g4ctypjuzbqru.protonmail2; t=1790691733;
	x=1790950933; bh=93VhP2nickyZU74PlPLi377f/JHumKlse6MNV8J0tOM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ng/83GJpmvpU4C/NDK5beEGznM/JxwxC/ZQSLAaeTfjMxgrErImNr8CzZeZE/3WD/
	 y5hWlvsdk95gKY7sDRbbs1l0zh4e2Bvs0yXjKmDhVbGUoUoCIXs4HAb4xzWcO0+9x1
	 XLBMJalBiOs4PHEQW5rcYI1vNIjXRshq6YgFlD2gzE/rCNCoWyv+ExaDicZ7Cth6Qp
	 +apO/auTLrxAXzAKPNU2JYkLUJXWlSTy/HTDijcIl5WsX0Qm/LywsA9jciuk9cHpzJ
	 jpQLQbd1rqK46h6HTUubd4hONWZcyB8Ygv8pNDRSNQmmPqRdrLeJMyPL3YLk6rDunx
	 IlVBcrXOvkj2Q==
Date: Tue, 29 Sep 2026 14:22:07 +0000
To: Takashi Iwai <tiwai@suse.de>
From: dchristensen8 <dchristensen8@proton.me>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/ca0132: Add Sound BlasterX AE-5 external RGB
 LED strip support
Message-ID: 
 <0UViNKefxgxrLggTEzDgzIe9-kh2EqU2Pnip6zuyJl1sthZtgJ-OIai3KBgkltft587c-ryvum1IqQZt-awOQTdrohMWKh79F3X8u6JOjuo=@proton.me>
In-Reply-To: <87fqys19vt.wl-tiwai@suse.de>
References: 
 <eFYfxKMV2ei__fURd-elssegCIVmOuRDne6lj9PMaM2bEgnYkz7Tzf6JLrgEaPZtvrUC_wHnmnwaUZAOdg0uh24nt73FQqi6T65qvJebHJA=@proton.me>
 <87fqys19vt.wl-tiwai@suse.de>
Feedback-ID: 45895322:user:proton
X-Pm-Message-ID: cffb55e0cf897f0fc2fcaac4f6441abeaee05c57
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MailFrom: dchristensen8@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5276YCD7IHIOK7GGVWIIXAOIU43Y6G35
X-Message-ID-Hash: 5276YCD7IHIOK7GGVWIIXAOIU43Y6G35
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:07:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5276YCD7IHIOK7GGVWIIXAOIU43Y6G35/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thanks for the quick review!
 =20
    I went with sysfs mainly because of the streaming nature of WS2812 stri=
ps (using an atomic DMA frame):        =20
 =20
    -The LED subsystem has no strip or pixel-buffer concept, individual led=
_classdevs would hit sysfs with thousands of writes/sec at 30-60 FPS (and l=
eds-class.rst advises against it for addressable arrays anyway).
    -An ALSA kcontrol could hold raw bytes, but pushing frames at 60 Hz spa=
ms control change events to PipeWire/PulseAudio.
 =20
    I initially went with text attributes  (ae5_strip_leds/ae5_strip_num_le=
ds) so basic shell scripts could just echo colors into it, but I know comma=
-separated lists bend the "one value per file" rule. Would you prefer a bin=
_attribute for raw RGB bytes instead? or keeping both?             =20
 =20
    All your code points make total sense too. I have no objections.
 =20
Let me know your thoughts on the sysfs format.
 =20
Thanks,
Devin





On Tuesday, September 29th, 2026 at 9:10 AM, Takashi Iwai <tiwai@suse.de> w=
rote:

> On Mon, 28 Sep 2026 19:26:05 +0200,
> dchristensen8 wrote:
> >
> >     Hi Takashi, Jaroslav,
> >
> >     Please find attached a patch adding support for the external addres=
sable RGB LED strip header on the Creative Sound BlasterX AE-5 and AE-5 Plu=
s.
> >
> >     The patch is attached as a .patch file.
> >
> >     The Sound BlasterX AE-5 and AE-5 Plus expose a 3-pin 5V addressable=
 RGB header driven directly by the CA0113 PCIe-to-HD-Audio bridge. Rather t=
han using the CA0132 DSP or MMIO GPIO, the CA0113 contains an autonomous HD=
A link sniffer that snoops a designated HDA DMA playback stream, extracts t=
he 24-bit GRB color payload, and serializes it as 800 kHz single-wire NRZ p=
ulses to the strip (WS2812B protocol).
> >
> >     Expose the strip through a sysfs interface on the codec device:
> >     ae5_strip_leds: read current colors write a comma-deparated #RRGGBB=
 or R,G,B list (a single color replicates across all active LEDs)
> >
> > ae5_strip_num_leds: get or set the active LED count (1..100)
> >
> >     Writes allocate an idle HDA playback stream, format a 32 KB DMA buf=
fer populated with repeating WS2812 frames (5-word zero preamble, 4 audio w=
ords per LED, and reset gap), configure the CA0113 BAR2 serializers and str=
eam-tag pin mux, and pulse the stream long enough for the reset latch to fi=
re. Access is serialized with a per-spec mutex, and the attributes are only=
 registered on QUIRK_AE5 devices.
> >
> >     Document the new sysfs attributes in documentation/ABI/testing.
> >
> >     Signed-off-by: Devin Christensen <dchristensen8@proton.me>
> >     Testing & Subsystem Context:
> >      - Verified on physical Sound BlasterX AE-5 hardware.
> >      - Tested continuous 60 FPS streaming and dynamic strip resizing (1=
0 -> 7 -> 10 LEDs)
> >        via the OpenRGB effects engine (MR: https://gitlab.com/CalcProgr=
ammer1/OpenRGB/-/merge_requests/3658).
> >      - Verified concurrent audio playback and LED updates without dropp=
ed samples or xruns.
> >      - Built clean against tiwai/sound for-next (commit 72107104d4f5).
> >      - Passes scripts/checkpatch.pl with 0 errors and 0 checks.
>=20
> Thanks for the patch.
>=20
> It's an interesting stuff (rather surprising that they (ab)use
> HD-audio for such an interface :)
>=20
> Through a quick glance, most of the code looks OK.
>=20
> So the question is rather the interface -- is the sysfs the best
> choice for this kind of display controls?  The implementation can be
> refactored at any time, but the interface must be set solid, so that's
> the most important question to be clarified.
>=20
> About the code:
>=20
> >  /*
> > - * Setup default parameters for the Sound BlasterX AE-5 DSP.
> > + * Sound BlasterX AE-5 External WS2812B RGB LED Strip Transport
> >   */
> > +static void ae5_strip_encode_24(u32 u, u32 *words)
> > +{
> > +=09/* Bit-for-bit exact encoding matching CtxHda.sys FUN_00042944:
> > +=09 * 24-bit pixel -> 4 x 32-bit audio words (6 bits per word).
> > +=09 * Hardware audio serializer transmits MSB first (bits 31 down to 0=
).
> > +=09 * For word i (i8 =3D 23, 17, 11, 5), bit_idx 0..5 (MSB to LSB with=
in the word)
> > +=09 * is placed at n =3D 29 - bit_idx * 4 (bits 29, 25, 21, 17, 13, 9)=
:
> > +=09 *   out |=3D (bit << n) | ((bit | 2) << (n + 1))
> > +=09 * Bit 0 -> 0b010 (375ns high, 1042ns low)
> > +=09 * Bit 1 -> 0b111 (1083ns high, 333ns low)
> > +=09 */
> > +=09int i8 =3D 23;
> > +=09int i;
> > +
> > +=09for (i =3D 0; i < 4; i++) {
> > +=09=09u32 out =3D 0;
> > +=09=09int bit_idx;
> > +
> > +=09=09for (bit_idx =3D 0; bit_idx < 6; bit_idx++) {
> > +=09=09=09int bit =3D (u >> (i8 - bit_idx)) & 1;
> > +=09=09=09int n =3D 29 - bit_idx * 4;
> > +
> > +=09=09=09out |=3D (u32)(bit << n) | ((u32)(bit | 2) << (n + 1));
> > +=09=09}
> > +=09=09words[i] =3D out;
> > +=09=09i8 -=3D 6;
> > +=09}
>=20
> I guess some BIT() macro or such could help in a bit cleaner form.
>=20
>=20
> > +static struct hdac_stream *ae5_strip_find_stream(struct hda_codec *cod=
ec)
> > +{
> > +=09struct ca0132_spec *spec =3D codec->spec;
> > +=09struct hdac_bus *bus =3D &codec->bus->core;
> > +=09struct hdac_stream *s, *dsp =3D NULL, *first =3D NULL;
> > +=09unsigned long flags;
> > +
> > +=09spin_lock_irqsave(&bus->reg_lock, flags);
> > +=09list_for_each_entry(s, &bus->stream_list, list) {
> > +=09=09if (s->direction !=3D SNDRV_PCM_STREAM_PLAYBACK)
> > +=09=09=09continue;
> > +=09=09if (s->running || s->locked)
> > +=09=09=09continue;
> > +=09=09if (!first)
> > +=09=09=09first =3D s;
> > +=09=09/* The DSP DMA consumes the DSP-loader stream (tag in dsp_stream=
_id). */
> > +=09=09if (spec->dsp_stream_id && s->stream_tag =3D=3D spec->dsp_stream=
_id)
> > +=09=09=09dsp =3D s;
> > +=09}
> > +=09spin_unlock_irqrestore(&bus->reg_lock, flags);
>=20
> Try to use guard() instead of manual lock/unlock.
>=20
>=20
> > +/*
> > + * Caller must hold spec->ae5_strip_mutex.
> > + */
>=20
> You can put a lockdep assert to assure that in the actual code, too.
>=20
> > +static int ae5_strip_send_frame(struct hda_codec *codec, const u32 *gr=
b_colors, int num_leds)
> > +{
> > +=09struct ca0132_spec *spec =3D codec->spec;
> > +=09struct snd_dma_buffer dmab;
> > +=09struct hdac_stream *hstr =3D NULL;
> > +=09unsigned int format, stream_tag;
> > +=09u32 enc_words[4];
> > +=09u32 *dst;
> > +=09int total_words =3D 0x8000 / sizeof(u32); /* 8192 words (32KB) */
>=20
> It should be defined as a constant instead?
>=20
> > +=09int word_idx =3D 0;
> > +=09int frame_words;
> > +=09int led, w;
> > +=09int retries =3D 20; /* ~100ms max */
> > +=09u8 orig_sd_ctl =3D 0;
> > +
> > +=09if (!spec || !spec->mem_base)
> > +=09=09return -ENODEV;
> > +=09if (num_leds <=3D 0 || num_leds > AE5_STRIP_MAX_LEDS)
> > +=09=09return -EINVAL;
> > +
> > +=09snd_hda_power_up(codec);
> > +
> > +=09/*
> > +=09 * 44.1kHz, 24-bit, 2-channel format (0x4031) matches Windows CtxHd=
a
> > +=09 * HDAUDIO_STREAM_FORMAT.
> > +=09 */
> > +=09format =3D snd_hdac_stream_format(2, 24, 44100);
> > +
> > +=09for (;;) {
> > +=09=09hstr =3D ae5_strip_find_stream(codec);
> > +=09=09if (!hstr) {
> > +=09=09=09if (--retries <=3D 0) {
> > +=09=09=09=09codec_warn(codec, "AE5 strip: no free azx stream after ret=
ries\n");
> > +=09=09=09=09snd_hda_power_down(codec);
> > +=09=09=09=09return -EBUSY;
> > +=09=09=09}
> > +=09=09=09usleep_range(5000, 10000);
> > +=09=09=09continue;
> > +=09=09}
> > +
> > +=09=09stream_tag =3D snd_hdac_dsp_prepare(hstr, format, 0x8000, &dmab)=
;
> > +=09=09if ((int)stream_tag > 0)
> > +=09=09=09break;
> > +
> > +=09=09/* Prepare failed (e.g. -EBUSY due to race with playback startin=
g); retry */
> > +=09=09if (--retries <=3D 0) {
> > +=09=09=09codec_warn(codec, "AE5 strip: snd_hdac_dsp_prepare failed %d\=
n",
> > +=09=09=09=09   (int)stream_tag);
> > +=09=09=09snd_hda_power_down(codec);
> > +=09=09=09return (int)stream_tag;
> > +=09=09}
> > +=09=09usleep_range(5000, 10000);
> > +=09}
> > +
> > +=09/* Prevent interrupt storms during free-running LED stream, saving =
original control bits */
> > +=09if (hstr->sd_addr) {
> > +=09=09orig_sd_ctl =3D readb(hstr->sd_addr);
> > +=09=09writeb(orig_sd_ctl & ~0x1c, hstr->sd_addr); /* Clear IOCE, FEIE,=
 DEIE */
> > +=09}
> > +
> > +=09/* 1. Populate the 32KB DMA buffer with repeating WS2812 frames + r=
eset gaps */
> > +=09memset(dmab.area, 0, 0x8000);
> > +=09dst =3D (u32 *)dmab.area;
> > +
> > +=09/* Words per frame: 5 words zero preamble + num_leds * 4 words + 83=
 words reset gap */
> > +=09frame_words =3D 5 + (num_leds * 4) + 83;
> > +
> > +=09while (word_idx + frame_words <=3D total_words) {
> > +=09=09/* 5-word zero preamble per Windows CtxHda FUN_00042944 */
> > +=09=09for (w =3D 0; w < 5; w++) {
> > +=09=09=09*dst++ =3D 0;
> > +=09=09=09word_idx++;
> > +=09=09}
> > +=09=09/* LEDs */
> > +=09=09for (led =3D 0; led < num_leds; led++) {
> > +=09=09=09ae5_strip_encode_24(grb_colors[led], enc_words);
> > +=09=09=09for (w =3D 0; w < 4; w++) {
> > +=09=09=09=09*dst++ =3D enc_words[w];
> > +=09=09=09=09word_idx++;
> > +=09=09=09}
> > +=09=09}
> > +=09=09/* 83 words (> 1.8 ms) zero reset gap (WS2812 requires > 50 us l=
ow) */
> > +=09=09for (w =3D 0; w < 83; w++) {
>=20
> Here, too.  Let's avoid magic numbers.
>=20
> > +=09=09=09*dst++ =3D 0;
> > +=09=09=09word_idx++;
> > +=09=09}
> > +=09}
> > +=09while (word_idx < total_words) {
> > +=09=09*dst++ =3D 0;
> > +=09=09word_idx++;
> > +=09}
> > +=09/* Ensure DMA buffer writes are committed before triggering the HDA=
 stream */
> > +=09wmb();
> > +
> > +=09/* 2. Configure CA0113 BAR2 hardware registers */
> > +=09/* Power up clocks (CtxHdb 0x141b7 / 0x14210) */
> > +=09writel(readl(spec->mem_base + 0xc04) | 0x7, spec->mem_base + 0xc04)=
;
> > +
> > +=09/* Base serializer initialization (CtxHdb 0x14ba4) */
> > +=09writel(readl(spec->mem_base + 0x400) | 1, spec->mem_base + 0x400);
> > +=09writel(readl(spec->mem_base + 0x42c) & ~1, spec->mem_base + 0x42c);
> > +=09writel(readl(spec->mem_base + 0x46c) & ~1, spec->mem_base + 0x46c);
> > +=09writel(readl(spec->mem_base + 0x4ac) & ~1, spec->mem_base + 0x4ac);
> > +=09writel(readl(spec->mem_base + 0x4ec) & ~1, spec->mem_base + 0x4ec);
> > +=09writel(0, spec->mem_base + 0x43c);
> > +=09writel(0, spec->mem_base + 0x47c);
> > +=09writel(0, spec->mem_base + 0x4bc);
> > +=09writel(0, spec->mem_base + 0x4fc);
> > +=09writel(readl(spec->mem_base + 0x408) | 1, spec->mem_base + 0x408);
> > +=09writel(readl(spec->mem_base + 0x40c) | 1, spec->mem_base + 0x40c);
> > +=09writel((readl(spec->mem_base + 0x410) & ~0xb) | 0x14, spec->mem_bas=
e + 0x410);
> > +
> > +=09/* Configure serializers 0..3 clocking (CtxHdb 0x14a6c) */
> > +=09writel(readl(spec->mem_base + 0x43c) | 0x33, spec->mem_base + 0x43c=
);
> > +=09writel(readl(spec->mem_base + 0x47c) | 0x33, spec->mem_base + 0x47c=
);
> > +=09writel(readl(spec->mem_base + 0x4bc) | 0x33, spec->mem_base + 0x4bc=
);
> > +=09writel(readl(spec->mem_base + 0x4fc) | 0x33, spec->mem_base + 0x4fc=
);
>=20
> Some helpers or macros look deserving.
>=20
> I stop at this point, as we'd need to define the interface at first.
>=20
>=20
> thanks,
>=20
> Takashi
> 
