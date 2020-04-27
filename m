Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D29C55199
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:00:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AD7206B6
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZyYjqTRY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL2IJv0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AD7206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27ED6844;
	Mon, 27 Apr 2020 08:59:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27ED6844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587970840;
	bh=tQa8lkDTSXiJX97GClHGLKQ34P045c93GRDfYkb3SxI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZyYjqTRYbNf74Q4U/jhr4FTzfAS/haLfIjASncue2qHaIrMSDypsfpwSqpibHx5X5
	 WeIbuNbFEuCByIij+PgbjuF2NISRxezcaX8Tu/SZrPgoHw1mTQArnZxPw9fNBy168z
	 wmsoYc+Kltl9ZB1zxzdeZSIoiGHN1oRtH4REEZj0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A0A9F8010A;
	Mon, 27 Apr 2020 08:59:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4F38F8022B; Mon, 27 Apr 2020 08:59:47 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5EE5F8010A
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 08:59:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5EE5F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="IL2IJv0C"
Received: by mail-pj1-x1044.google.com with SMTP id fu13so6466210pjb.5
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WNj7owPD+ZbRnStugkoSGfUDDLECau6V6cMguxLHseM=;
 b=IL2IJv0CwAvaTDLiqlc/43W1WRn+mgpJHcQ8lcGu5IP5LESVReGp34dPTQGf6e0LZa
 3rCwR8nNmXOAEkd7Qzy7NviBN1004OJr8Pb5pMjqmfp3qpJihUZhwd7nyTcdErdOInIe
 uT/acoJunK3/lzcWSYlr70GlAd1cL4+5aQRsO6ogXJBgfPAl7j9pz2uqOwVdBWbYe0q6
 lbHRELStH3w+8HvL6IraAq8odymfgvcnvKnG15I3pwiOqF/UTkx28z5RWu01Jb8zRX6u
 8N7Ya3TKyfDwMXJcwDdk6fA1JUwRLmFDLFLl41eCmhPhg6qDStbEFse06rD8j62TGsit
 h9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WNj7owPD+ZbRnStugkoSGfUDDLECau6V6cMguxLHseM=;
 b=A78N1uyEal/PeXbkmtyR4pW+767Pnq6kmzGvlO17B6CcmD/plJZFvzw2JxnYPMILBn
 NFaCOu6JhGHQ8EVgunOJcEmasKpxkk1G5pcjofPOw3ETzDN2mBYqLte8Ty9ERk/utHtQ
 cGEjUv8aC9q8/cy3Nkdv6Wfvac2IMCXHEnEMpANT4ssMfqXOCxlJxoqASlWJ1LFBXRVz
 F391lOGyzy3ePGQgbjJ8YQywODTi8KwpeO9xhMnr1l3zxrd77i/z2WDkuOxDVl4Kc2qp
 H+F1lMDAc7gmSSme8NqGN9iAa0p10mNkURBJmneYKcIBUPep8W9QOQPB1ozWwUvAXUwq
 +LNA==
X-Gm-Message-State: AGi0PuaRLHEEEldKGnhNZQwn+yeMOlrlJtdQ7IjpIuAvPMSrsWB+s1ya
 OkUuZv4u5u8vHKhTiD2/fEA=
X-Google-Smtp-Source: APiQypK642idgdGmw8QuDMMdid04wPSy9FsGffFOvsU2o0XwcfqVKE56jYsP/DglCL+LJ7YRbhEZMA==
X-Received: by 2002:a17:902:9895:: with SMTP id
 s21mr249837plp.158.1587970781619; 
 Sun, 26 Apr 2020 23:59:41 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 h9sm11317108pfo.129.2020.04.26.23.59.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 26 Apr 2020 23:59:41 -0700 (PDT)
Date: Sun, 26 Apr 2020 23:59:34 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Disable exception interrupt before
 scheduling tasklet
Message-ID: <20200427065934.GA2236@Asurada>
References: <a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Mon, Apr 27, 2020 at 02:23:21PM +0800, Shengjiu Wang wrote:
> Disable exception interrupt before scheduling tasklet, otherwise if
> the tasklet isn't handled immediately, there will be endless xrun
> interrupt.
> 
> Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
