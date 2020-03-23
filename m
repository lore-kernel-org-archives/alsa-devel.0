Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D70C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:21:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2169F2070A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eADSbp+g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8YmmXZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2169F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51B0586E;
	Mon, 23 Mar 2020 22:20:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51B0586E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584998500;
	bh=Qc83O17+LTPfl7iz+l0Jt/sawL8628YVwljv45qpNEg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eADSbp+gd+B9YUCYPpvpz1lUPuLpuUZiYtOSHgZA+JjGufcFdb5GyN0CliSZM9VQH
	 WjZr6cKIK6J5w316dVKBIdyknVt6HEc96TJdrVwOj+nDpSErAv9hwvcl9BkdtL/8Sf
	 HA4Gh/Av5n23hEx39pPe8ZZRERDzJoSvScH6mJkI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5F34F80147;
	Mon, 23 Mar 2020 22:20:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3127CF80158; Mon, 23 Mar 2020 22:20:48 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A4ABF800F6
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 22:20:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A4ABF800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="A8YmmXZ0"
Received: by mail-pl1-x641.google.com with SMTP id x1so2447734plm.4
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Gwk+oA56w7chZgB5rwcFzqm1eElVocnK0t0AHCBP8yQ=;
 b=A8YmmXZ0cGVBB3dUxG1y25+NUkRk38YFfGLeUWWJ++mJoZ1YBc1+Rk/EhQTctZAKeI
 dLaY219krh3CUOauviJMyB7ko8zTiEsdp7JsjxNonedzp2vpQNqsy0Z0iOOUmVv9Djap
 wzLMDPQeZMuXwUVCWNIngfyA9DEOvDpbfoSk/vAEmL0GlkiWov2zYfOjxxaP7iTG1cNK
 GzpQkSBw4fsb1Yz9EZusHfyAZdrPaJ1GA7MA6rifEZnSmIdCN7vslqhnhXx6A/pwkp/Z
 /1uII2u0+t7Kcdw2R4fXbCNmayagQ2Cs2jIdKt30hMa2qVqgFpRkYsbWroLqNfd9emcd
 tStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Gwk+oA56w7chZgB5rwcFzqm1eElVocnK0t0AHCBP8yQ=;
 b=nvbpaXYFRRXE+dosrCNUsQnB/KZoI67qYM5b8yJt30yRYdf4l2AwaI6mCOb1UzthgX
 n05zMKol8PQAsYnOJQRAZHGnZ/SGuYEdCjms9nAqHcnukxRRw9UyP4SB/KrI9SM32lOt
 E6ZurKoKuuYrNCNjlSLgGwWJ+Ty9DrLj737an5ZH9Qmoc3onm+OYcjRxs35TJvpiB+5o
 NKg3aEZvVFOTREn+P6KadEU5XoHCvQdKMC2LXQDnLwjYOh0PV+lQ9eYL/1VdhyzSHI2n
 I3NAhaqq5DhBB0FoqZhisDhTOG5zfxrJl6LGTmoz8dqoLvAEN1of1vDwJv/OyxXnWOwY
 z/Ag==
X-Gm-Message-State: ANhLgQ1RpfBrq+k9ovzXF3cHCzskpuks22pnCG0y5IK3YkVMjRyne+FO
 Dqa4FIm3sQOt/UVdXlDeido=
X-Google-Smtp-Source: ADFU+vv7tlepPAmm35itIz/eXxTaP0rUCj7Y76PBef7aDXcjLbwyTDKZpymRXFDJNAm9wfFzB26DWQ==
X-Received: by 2002:a17:90a:208:: with SMTP id
 c8mr1410640pjc.153.1584998442547; 
 Mon, 23 Mar 2020 14:20:42 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id s19sm14469184pfh.218.2020.03.23.14.20.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Mar 2020 14:20:42 -0700 (PDT)
Date: Mon, 23 Mar 2020 14:20:39 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200323212038.GA7527@Asurada-Nvidia.nvidia.com>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
 <20200320173213.GA9093@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320173213.GA9093@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
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

On Fri, Mar 20, 2020 at 11:32:13AM -0600, Rob Herring wrote:
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
> > >  			  will be in use as default. Otherwise, the big endian
> > >  			  mode will be in use for all the device registers.
> > >  
> > > +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> > > +			  Ends, which can replace the fsl,asrc-width.
> > > +			  The value is SNDRV_PCM_FORMAT_S16_LE, or
> > > +			  SNDRV_PCM_FORMAT_S24_LE
> > 
> > I am still holding the concern at the DT binding of this format,
> > as it uses values from ASoC header file instead of a dt-binding
> > header file -- not sure if we can do this. Let's wait for Rob's
> > comments.
> 
> I assume those are an ABI as well, so it's okay to copy them unless we 

They are defined under include/uapi. So I think we can use them?

> already have some format definitions for DT. But it does need to be copy 
> in a header under include/dt-bindings/.

Shengjiu is actually quoting those integral values, rather than
those macros, so actually no need copy to include/dt-bindings,
yet whoever adds this format property to a new DT would need to
look up the value in a header file under include/uapi. I's just
wondering if that's okay.

Thanks
