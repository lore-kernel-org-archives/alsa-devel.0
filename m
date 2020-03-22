Return-Path: <SRS0=tBF4=5H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A10AC54EEB
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:48:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A3820663
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XYmUyg/C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfJ1Ktbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A3820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A463852;
	Sun, 22 Mar 2020 11:47:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A463852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584874106;
	bh=/xGDNL9h4p3OAlnCcwTQynpt/51AlJF8yIy+kFuBUao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYmUyg/Ci6bj6AsIwVWrtHjc3Iygfyov4UZjb8MT7k/ZMHca9W+Klb7h90mAMlHR8
	 etil8gtZjq5M19qw6sVXAm3JUOnNj7zdx5CFoqnVcBdUDgIUYQ3tkVQfP/216BfGcj
	 nGxav/BYDTL7ScFRtAr8zZ0enpk6L495KdrkOENQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAB93F801A3;
	Sun, 22 Mar 2020 11:47:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A8E1F801F8; Sun, 22 Mar 2020 11:47:28 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC9E4F800B9
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2020 11:47:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC9E4F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="vfJ1Ktbe"
Received: by mail-qk1-x743.google.com with SMTP id j4so12075331qkc.11
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2020 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S6yehooPiFA7WFzSiN6iRq3URFGEeFNRubLJGaTKKeg=;
 b=vfJ1KtbeLDw5rFqeb6hIPBm5Sc1u7NaY5cV22O2B6Qr5sj+BUBGQBoxgBnDyG25Uun
 XarmSsEFe+LOGy/CsGvlXp+gB1ey4rj/w4Psk1IdT1KxfgfNvtobd8eTKawz4omDaCAp
 9Q1QqhexZiCi+puZyxpV4LbWTJuBfTBAcqE1JoZWo+/JFNDLXF0lZPnVSo+5jl0996fB
 IGiNJbsb2PBmJIQOaHcEPBaA6RMSFpgUk6E0F6mA/cK5z1KzcLPQfehaIJPM83S3xcQ/
 LjQj/DgPr2S3dv9JTzva8TGWqrNMpWa3T1ybGhe65sBtgGwJoKR509wm+j/05GFrFu65
 EB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S6yehooPiFA7WFzSiN6iRq3URFGEeFNRubLJGaTKKeg=;
 b=dFesCP77A9LLFfskGc7Cf4PPhkuL/QVV2JEblboPsEzEXR7Y55n0g42/yJWbevugCo
 wbM5uWoeg7V98XHk/FNwb+ytD3mVtnrSkpmED7F7tPrrkhikX7Qia9avqThgL6GQJFsT
 qi3RKvTZa0daIoTB27m8//2mkE8v3iG4mYjwub+czanTVdf+Qx2SoB3lea2fLIHH+CN2
 vnm2aUMchtUrlC4KSyxMLxOucSoiebz45/+MeuRBLCnB8FfnAVF5wO2EvMeaugfsgkKk
 HmbRM4/7anNXl6a6pEvxlPFMQqrRW+c7POwzzxtM4+UKatPj8FpCnnmEiLLsjiVE5CLs
 w4iA==
X-Gm-Message-State: ANhLgQ1G/SMnLhB9m45jE/37v/vTKeWSHWYpHhBUWhTXZwNxkppX6UXE
 KhXFGku7fxSNY7ccs6DgqjHKmNCcpLSjrUzFv+4=
X-Google-Smtp-Source: ADFU+vtFlqm8k9nbdJLDkTWAYuVNBzwsd2eGqUIfasY6+bquWnBaxo5guuFzQCC/yubJX5XQ8gab/74PHmKPUs49zC4=
X-Received: by 2002:a37:9683:: with SMTP id
 y125mr16639605qkd.450.1584874041867; 
 Sun, 22 Mar 2020 03:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
 <20200320173213.GA9093@bogus>
In-Reply-To: <20200320173213.GA9093@bogus>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sun, 22 Mar 2020 18:47:09 +0800
Message-ID: <CAA+D8APtW+ZRvJufzhNSw8acTdhGRQNphZcyVYnV-ZLUbtTGew@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl,
 asrc-format
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sat, Mar 21, 2020 at 1:34 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 09, 2020 at 02:19:44PM -0700, Nicolin Chen wrote:
> > On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > > In order to support new EASRC and simplify the code structure,
> > > We decide to share the common structure between them. This bring
> > > a problem that EASRC accept format directly from devicetree, but
> > > ASRC accept width from devicetree.
> > >
> > > In order to align with new ESARC, we add new property fsl,asrc-format.
> > > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > > can accept format from devicetree, don't need to convert it to
> > > format through width.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > index cb9a25165503..780455cf7f71 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > @@ -51,6 +51,11 @@ Optional properties:
> > >                       will be in use as default. Otherwise, the big endian
> > >                       mode will be in use for all the device registers.
> > >
> > > +   - fsl,asrc-format       : Defines a mutual sample format used by DPCM Back
> > > +                     Ends, which can replace the fsl,asrc-width.
> > > +                     The value is SNDRV_PCM_FORMAT_S16_LE, or
> > > +                     SNDRV_PCM_FORMAT_S24_LE
> >
> > I am still holding the concern at the DT binding of this format,
> > as it uses values from ASoC header file instead of a dt-binding
> > header file -- not sure if we can do this. Let's wait for Rob's
> > comments.
>
> I assume those are an ABI as well, so it's okay to copy them unless we
> already have some format definitions for DT. But it does need to be copy
> in a header under include/dt-bindings/.

Thanks for reviewing. seems it is not a good time to add a new header
file in include/dt-bindings/ in this patch serial. I will drop this change
this time, that still using the "fsl,asrc-width".

best regards
wang shengjiu
