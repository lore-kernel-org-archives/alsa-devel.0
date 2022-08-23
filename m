Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B68C32772
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 14:47:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DDDA1679;
	Tue, 23 Aug 2022 16:46:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DDDA1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661266059;
	bh=dmfYriQxeo901lZI5S6yytX6hz3k3DOeAq3cR6hUSQE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fnO8vsAu71C77QWm6GaKnOWj0sLE4y9Z40p4mzu6ZDoz65tEQLEbMyiRcLlK7RLcK
	 uvAwBRuPZRFRe9JegetAbyycVxi0Bmns+qynK1EMZIFMu9v35ToOZOImbLTn0SxpQm
	 hDSj9AlGB1kclZSfVCaOI9ODIo75gBIBzrKllSnc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDB3BF8014E;
	Tue, 23 Aug 2022 16:46:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF434F8020D; Tue, 23 Aug 2022 16:46:47 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7431BF8014E
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 16:46:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7431BF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="NGblMmxP"
Received: by mail-ot1-x32d.google.com with SMTP id
 t11-20020a05683014cb00b0063734a2a786so9902532otq.11
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc;
 bh=2jfpeWGpRBtOpt5eYln9rpGYhFiNef9meziglYN4UtA=;
 b=NGblMmxP1WCLkpwR2qWByNr2zD0ntLukrfPFLnTMpbuWpF4OVdFfbbprBh2/eoY8Gj
 b7hhQPh4JYe/19ZGIRZXGxNLnQQpMogYL93/i9r9jt7b5GKZv963oLwGIarTCADzh1d6
 aq4dpwemVn/CmIQvkBncgPqSv0LaOryHmKlvoEytdtyM0CTSjqntcFNU9abiBf6ZsbNk
 7yN10gKA7chm1KOXVgYpoeNDVGgIPGq25VEkIH+GiHV9J5lQRQO1OBj3mTvd3YG5WCpc
 qciOHBE0g2RcG0Rwc/nv390q5ve4/mwFJnDiR73PO/7gaFljbogS7d3gDRhdXaGtxrgb
 PhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=2jfpeWGpRBtOpt5eYln9rpGYhFiNef9meziglYN4UtA=;
 b=M0JMqf1Qw2cJ4XdfGKrreM/35bt9lHoGG6AcdfIxdYX1st3md4i5XiPN3F+WfH5Kr0
 kXZ3iFSijU+gB417qoPOWQ4KXEZRkrXOe57ZN1fKa+uTtWrTzgUG7cpsjYpuDmmnSN6o
 EgyA3KzpfAskYNRhllvnELo1pQi4ZU715M5hSOy8Z0sObK7++VsqSqHlTtAWadVw3z26
 vsRGJ+4k9kmMz84U1FJsSRpnpbzGaC0NANYOqhSF2VfEuX+8sSiChpN+sJn2xu7oT8Vt
 U/EcTiMQ5+MrgKba9DW8DR3mwN/YI20T26ZJRPXvw2WNcXuOxRz04bNVT2MxDmpIe6R5
 fPAg==
X-Gm-Message-State: ACgBeo2/Ndhu0SKsp1kcjzupPa5YXPRGfaLorV2k1vt6kyET1eOzx2Xx
 uxkn6748MxtvctgSlHNltH8=
X-Google-Smtp-Source: AA6agR4L7uHhSh0T0sWt1c++aOY06HS8EOZXFYLG1hMZyJAVmmZwt+UJz0dXZpbyscHu0BdvVeys0w==
X-Received: by 2002:a05:6830:25c4:b0:637:2a66:1dfd with SMTP id
 d4-20020a05683025c400b006372a661dfdmr9241945otu.383.1661265998963; 
 Tue, 23 Aug 2022 07:46:38 -0700 (PDT)
Received: from geday ([2804:7f2:8006:f71:a581:5947:7302:d05f])
 by smtp.gmail.com with ESMTPSA id
 cp19-20020a056830661300b0061cd208fadesm3741226otb.71.2022.08.23.07.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Aug 2022 07:46:38 -0700 (PDT)
Date: Tue, 23 Aug 2022 11:46:38 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm/bridge: dw-hdmi-i2s: set insert_pcuv bit if hardware
 supports it
Message-ID: <YwToTmr4DI3k+STF@geday>
References: <YwF+JYR5DxLBnE8F@geday>
 <YwOEPpO0gux+njQe@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwOEPpO0gux+njQe@sirena.org.uk>
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>,
 ALSA-devel <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Mon, Aug 22, 2022 at 02:27:26PM +0100, Mark Brown wrote:
> On Sat, Aug 20, 2022 at 09:36:53PM -0300, Geraldo Nascimento wrote:
> 
> > +	/*
> > +	 * dw-hdmi introduced insert_pcuv bit in version 2.10a.
> > +	 * When set (1'b1), this bit enables the insertion of the PCUV
> > +	 * (Parity, Channel Status, User bit and Validity) bits on the
> > +	 * incoming audio stream (support limited to Linear PCM audio)
> > +	 */
> > +
> > +	if (hdmi_read(audio, HDMI_DESIGN_ID) >= 0x21)
> > +		conf2 |= HDMI_AUD_CONF2_INSERT_PCUV;
> 
> So what if we're not handlign linear PCM?

Hi Mark,

I think we may be able to restrict the fix for L-PCM only by checking
byte 0 of iec.status, specifically bit 1. Our define is called
IEC958_AES0_NONAUDIO but https://tech.ebu.ch/docs/tech/tech3250.pdf
calls it the "Linear PCM identification" bit. There's also a
supplement to AES/EBU 3250 in https://tech.ebu.ch/docs/n/n009_1.pdf

Let me know if the following is OK. I'll be happy to submit V2 if
it is.

Thanks,
Geraldo Nascimento

--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -42,6 +42,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	struct dw_hdmi *hdmi = audio->hdmi;
 	u8 conf0 = 0;
 	u8 conf1 = 0;
+	u8 conf2 = 0;
 	u8 inputclkfs = 0;
 
 	/* it cares I2S only */
@@ -101,6 +102,18 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/*
+	 * dw-hdmi introduced insert_pcuv bit in version 2.10a.
+	 * When set (1'b1), this bit enables the insertion of the PCUV
+	 * (Parity, Channel Status, User bit and Validity) bits on the
+	 * incoming audio stream (support limited to Linear PCM audio)
+	 */
+
+	if (hdmi_read(audio, HDMI_DESIGN_ID) >= 0x21 &&
+			!(hparms->iec.status[0] & IEC958_AES0_NONAUDIO))
+		conf2 = HDMI_AUD_CONF2_INSERT_PCUV;
+
 	dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
 	dw_hdmi_set_channel_status(hdmi, hparms->iec.status);
 	dw_hdmi_set_channel_count(hdmi, hparms->channels);
@@ -109,6 +122,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	hdmi_write(audio, inputclkfs, HDMI_AUD_INPUTCLKFS);
 	hdmi_write(audio, conf0, HDMI_AUD_CONF0);
 	hdmi_write(audio, conf1, HDMI_AUD_CONF1);
+	hdmi_write(audio, conf2, HDMI_AUD_CONF2);
 
 	return 0;
 }
