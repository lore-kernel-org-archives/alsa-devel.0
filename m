Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C35C7618E
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 07:48:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7293BE7C;
	Fri, 21 Apr 2023 09:47:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7293BE7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682063296;
	bh=1X8M0CZpC1FZhLYX9pooVWGBzQPNMcMuBOrTg1y0PQ8=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YpHUNxlxNhE5RFaFfD8mgoXsCyEBEJnd2ZZb56fI3IYjr+GuqGBPN715Pgokdw4pc
	 VJSO4z1dRVCZaurRa2/fSFggIzCbTm6jkMkrHoRRCj+p4yIuR4BHeno1KRxfs05k4m
	 sHq4SJ0b6sds+otyq76rOUN33rGbwL68m386oLRk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 14C0EF800D0;
	Fri, 21 Apr 2023 09:47:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 739EEF80155; Fri, 21 Apr 2023 09:46:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D1756F800D0
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 09:46:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1756F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Osc6ezp4
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B73B06482C;
	Fri, 21 Apr 2023 07:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B351EC433D2;
	Fri, 21 Apr 2023 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682063164;
	bh=1X8M0CZpC1FZhLYX9pooVWGBzQPNMcMuBOrTg1y0PQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Osc6ezp4yO0TGfwIqrTwWXFgeGg5yPQDS4KleuTAyefc7doXn1IswrVJ2dw5+vGjJ
	 IcldAGss4ZJXY71xp9zJl5EPEjOfBSAOAPOskfQAYpcDjHowhqOaY2J+h4z6k4j/9a
	 afGi6IriSyi1cS3UgfnnvCHdHz9tMTM5xTi/0KytEAHDXIVbdteEjHgwa9ii4vgUkL
	 lbQtnPdyHvEMS7yhT7xvYgW+TAkdOjb5A44h14e8uG4FSwefgsLQLeWGqjvnSf8ZD2
	 Jd9FJaaOMMw49qMPK0pBRIkHjIrgItJWW3r/5OvITKIYXnpDjXAqM6tLR2aiWg25Ha
	 3w/aF8x5dlZRw==
Date: Fri, 21 Apr 2023 08:45:58 +0100
From: Lee Jones <lee@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 3/7] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230421074558.GQ996918@google.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
 <20230417171601.74656-4-herve.codina@bootlin.com>
 <20230420123946.GB996918@google.com>
 <20230420151551.78c1288b@bootlin.com>
 <20230420134703.GC996918@google.com>
 <20230421092645.56127f11@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421092645.56127f11@bootlin.com>
Message-ID-Hash: OOVALDDDVPA6YDYLRA2LFAK76SCD5FXG
X-Message-ID-Hash: OOVALDDDVPA6YDYLRA2LFAK76SCD5FXG
X-MailFrom: lee@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OOVALDDDVPA6YDYLRA2LFAK76SCD5FXG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 21 Apr 2023, Herve Codina wrote:

> Hi Lee, Krzysztof,
> 
> On Thu, 20 Apr 2023 14:47:03 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Thu, 20 Apr 2023, Herve Codina wrote:
> > 
> > > On Thu, 20 Apr 2023 13:39:46 +0100
> > > Lee Jones <lee@kernel.org> wrote:
> > >   
> > > > On Mon, 17 Apr 2023, Herve Codina wrote:
> > > >   
> > > > > The Lantiq PEF2256 is a framer and line interface component designed to
> > > > > fulfill all required interfacing between an analog E1/T1/J1 line and the
> > > > > digital PCM system highway/H.100 bus.
> > > > > 
> > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > ---
> > > > >  drivers/mfd/Kconfig         |  16 +
> > > > >  drivers/mfd/Makefile        |   1 +
> > > > >  drivers/mfd/pef2256-regs.h  | 250 ++++++++++
> > > > >  drivers/mfd/pef2256.c       | 950 ++++++++++++++++++++++++++++++++++++    
> > > > 
> > > > 95% of this driver needs to be moved somewhere else.
> > > > 
> > > > What is a Framer?  Perhaps sound/ is a good candidate?  
> > > 
> > > The pef2256 framer is a device that transfers data to/from a TDM (time-slots
> > > data) from/to quite old telecommunication lines (E1 in my case).
> > > Several subsystem can set/get data to/from the TDM. Each device using their
> > > own time-slots set.
> > > 
> > > On my use-case, I have some audio consumer and a not yet upstreamed HDLC
> > > consumer. Both of them uses the framer to know the E1 link state.
> > > The framer needs to be initialized 'globally' and not by a specific consumer
> > > as several consumers can use the framer.  
> > 
> > I can't think of a good place for this.
> > 
> > If all else fails, it's drivers/misc
> > 
> > > > >  include/linux/mfd/pef2256.h |  52 ++
> > > > >  5 files changed, 1269 insertions(+)
> > > > >  create mode 100644 drivers/mfd/pef2256-regs.h
> > > > >  create mode 100644 drivers/mfd/pef2256.c
> > > > >  create mode 100644 include/linux/mfd/pef2256.h    
> > > > 
> > > > [...]
> > > >   
> > > > > +static int pef2256_add_audio_devices(struct pef2256 *pef2256)
> > > > > +{
> > > > > +	const char *compatible = "lantiq,pef2256-codec";
> > > > > +	struct mfd_cell *audio_devs;
> > > > > +	struct device_node *np;
> > > > > +	unsigned int count = 0;
> > > > > +	unsigned int i;
> > > > > +	int ret;
> > > > > +
> > > > > +	for_each_available_child_of_node(pef2256->dev->of_node, np) {
> > > > > +		if (of_device_is_compatible(np, compatible))
> > > > > +			count++;
> > > > > +	}    
> > > > 
> > > > Converting Device Tree nodes into MFD cells to register with the
> > > > Platform Device API is not a reasonable use-case of MFD.
> > > > 
> > > > Have the CODEC driver match on "lantiq,pef2256-codec" and let it
> > > > instantiate itself.  
> > > 
> > > As the framer is going to used by several subsystem, I cannot instantiate
> > > it in the specific ASoC subsystem.
> > >   
> > > > 
> > > > Your first version using of_platform_populate() was closer to the mark.  
> > > 
> > > The issue was that I need MFD cells for the pinctrl part.  
> > 
> > Why can't it be represented in DT?
> 
> The pinctrl part has no specific compatible string.
> Not sure that a compatible string for pinctrl can be accepted
> as there is only one pinctrl subnode and no specific reg for this
> subnode.
> 
> The DT looks like this:
>     framer@2000000 {
>       compatible = "lantiq,pef2256";
>       reg = <0x2000000 0x100>;
>       ...
>       pinctrl {
>         pef2256_rpa_sypr: rpa-pins {
>           pins = "RPA";
>           function = "SYPR";
>         };
>       };
> 
>       pef2256_codec0: codec-0 {
>         compatible = "lantiq,pef2256-codec";
>         #sound-dai-cells = <0>;
>         sound-name-prefix = "PEF2256_0";
>       };
>     };
> 
> Krzysztof, is it acceptable to have a compatible string in the pinctrl node ?

Why wouldn't it be?

$ git grep ".compatible" -- drivers/pinctrl/

> In this case, it will looks like this:
>     framer@2000000 {
>       compatible = "lantiq,pef2256";
>       reg = <0x2000000 0x100>;
>       ...
>       pinctrl {
>         compatible = "lantiq,pef2256-pinctrl";
>         pef2256_rpa_sypr: rpa-pins {
>           pins = "RPA";
>           function = "SYPR";
>         };
>       };
> 
>       pef2256_codec0: codec-0 {
>         compatible = "lantiq,pef2256-codec";
>         #sound-dai-cells = <0>;
>         sound-name-prefix = "PEF2256_0";
>       };
>     };
> 
> Best regards,
> Hervé

-- 
Lee Jones [李琼斯]
