Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6DEC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Mar 2022 10:57:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA2B61743;
	Tue, 29 Mar 2022 12:56:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA2B61743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648551418;
	bh=Vanfv+C3aqbPnrDC0qF+JurcUHu2Jv83zt5/MrYkOx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vud+53iginISvNdN41PesUtK+HlkETza1csxRF7JL4jF+gca/X0NFUDDjgrob7TC7
	 eEAmOZ+pWRIRoPPkwtCbmJ2wU0MMmLBMeCsj23hZlLeWdQwG4igH+9WOVz5rtdg9kX
	 cW6dswVrl6bUsgM3LhfoR+KXToQ64JrpNIxbEsgA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D7EAF8014E;
	Tue, 29 Mar 2022 12:56:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CE3DF800FA; Tue, 29 Mar 2022 12:56:06 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBDEEF800FA
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2022 12:55:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBDEEF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="a78onrOf"
Received: by mail-ed1-x535.google.com with SMTP id w25so20203982edi.11
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2022 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vanfv+C3aqbPnrDC0qF+JurcUHu2Jv83zt5/MrYkOx0=;
 b=a78onrOfV/1JQF+FKcVBb3s6X3GVh02eT+3PcNerfq0vv0Uk4qy9EkcfkB4CWwCnaY
 So15LZztMsMwzgfj0ygqpaEqwm7lU9drdV8ONqYHUozRv8nh6yqrCH46wgFicgS1Xopr
 z8E/F3Q0Ew+/zbSiuuVu5P1Y0KE9RZjHElqmq5et/1XpmkYni5IFsjrsYM1H2fjkbaeI
 9vrcuEF1XED+W1WjN1AGrUqpAiowQTPI3gUJWDjqT8YjccjuufhdooF/YzVNDPcClAKS
 VdkzSAjgzI7MtCipTfo6wINFpRZy4RppNbSI8Zwa8vEzvpyEWVpRK2YSmiJB+rmJr3r9
 +PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vanfv+C3aqbPnrDC0qF+JurcUHu2Jv83zt5/MrYkOx0=;
 b=nWh3bAKAgsB1xMaaUDVTZOwt04JfoXUe4s4bNdSBYI+vITWk8GDRExj1w3RGXr0nN0
 EclYUnikkpCJJWEORwn7ElOINlyi3IsnBm1023zCMezFkWR/DkugOXlduqHzxXWw+gPN
 pX8Y+p9uBF3jHyd7T7baV1BlDCUVkzAZ3DRbDeHUDlUkYdE00yrZNRnQfl/3T5fdkQ2n
 HYL9ERBtvM+jdVwi9OfZTHCNK00dh8aQ1p+ZnWNZO5MRkafUUZ2UN57wnzdVR4UXPSPh
 oCCfBp3+fNA6lYWPwRfmyKGOV0aI0fRmcUkcPDmVZUesbGHYfGJmvVgkemL9ADykhu49
 rxZw==
X-Gm-Message-State: AOAM533giT6ACBT5uK5nS6zZJMNQheY9QnR61jx8Qyby1+0xks9GehLr
 emvaQFp8nXJKdBEBwMUU7x/PKLQ6+UNwvDQ0bVA=
X-Google-Smtp-Source: ABdhPJywFt6RYNTgOD3XCMsZrq6YuZNaPg7SZt/ag1gmDG70iXx7hrXsHHaBoSph8DuZZ9/byyxkHqp6kO8GgcG4zqo=
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id
 f11-20020a0564021e8b00b003da58e69a09mr3712913edf.155.1648551357686; Tue, 29
 Mar 2022 03:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-11-s.hauer@pengutronix.de>
In-Reply-To: <20220328112744.1575631-11-s.hauer@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Mar 2022 07:55:45 -0300
Message-ID: <CAOMZO5B3TdYMhvYX55H5c+tSgaR8mgUKPo=hOw2xKvd+b+X8=g@mail.gmail.com>
Subject: Re: [PATCH v2 10/19] dma: imx-sdma: Add multi fifo support
To: Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 Shengjiu Wang <shengjiu.wang@gmail.com>
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

Hi Sascha,

On Mon, Mar 28, 2022 at 8:28 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Please add a commit log, thanks.
