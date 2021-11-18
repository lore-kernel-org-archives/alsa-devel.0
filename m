Return-Path: <SRS0=e+ka=QF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B1C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 09:49:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8C261ACE
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 09:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB8C261ACE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26CAE1877;
	Thu, 18 Nov 2021 10:48:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26CAE1877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637228961;
	bh=yZtWnV2AZaTtP7W31ku5iWN+RjlPIjMELYCK0vwIHbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iUhNCz4w/fwP3O3E89Mwgprpa61WuXhR7ucqJAuHr+fhA1VuzbLbmDTiCIBiDuXLi
	 ZMekAJ+LiNwOOFMSZOwR/hszTZlzxctKH1PaGOFC1f0mW4v6hGq6RJwtLCWlv3SlXW
	 9iR4W6wfzL6wZD2tkaqdmgNDOeJ9zd7qYnIFKL5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5DA8F800FA;
	Thu, 18 Nov 2021 10:48:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8D05F80272; Thu, 18 Nov 2021 10:48:28 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24035F800FA
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 10:48:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24035F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HZWqpB6k"
Received: by mail-wr1-x429.google.com with SMTP id d27so10320334wrb.6
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 01:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yZtWnV2AZaTtP7W31ku5iWN+RjlPIjMELYCK0vwIHbQ=;
 b=HZWqpB6kFbD+fz5zJokWz51ktHZPeZ7IeIpoCZ407WXMnXPc7wpkgf+Fbv9QgTn6Ms
 zaUZ2kCSuHX+PXyxJ8dDdCRoimWUriQbmsnvAMe8QZCGwH0c4d278pCrnUZ5f8tsU/5I
 K8EscoS8cxrF+j2+pDpkuJmKFJcltxwSG0FqdaX8UPT8KbzpMVXFP3typfVGtKwE3mNt
 ev3kxzF68C3cu0rrv5PDC4hIv7sAtGyWETSaSp6HytSy4bwOEx1PLDlS37Frz4R/xiAS
 KkPr+jAoGY+32/8M3QqiSnfQZ1tXBBcVCQWy8h1TRgMUJYYgcaygaBu7fzvOEX6yU9l4
 w2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yZtWnV2AZaTtP7W31ku5iWN+RjlPIjMELYCK0vwIHbQ=;
 b=mfwS1qX1ND4/i4ZrqPrFcbWhudGXWizPlM+ocYs0aVs3D2JN2hbCRzdtgrB/jRhy2G
 OPteK5qMP2fImbzdijeunLx9B53rnM+wvjMmfFZ/p+o4SYuIlWkn5Gq9FJNJUJ4vf83M
 tSzFIuctF8Ds4lQqjtrahfzn905GhcOuTGlVjxhrD2XrD4Va3x455rgFdh9J1cuNwKjs
 oN0btCJG8cefIdLj9T60AVesI2yUynVaqKk4b2MFpQYYuYh54M8BtUY13nDxTfMstGcg
 Qd0v+wq365VAFI1GO1spNpMDUg2v4Uhmw6hI17pVkh+kHAJom7MIPKMM8+fvgX3qQfk8
 abiQ==
X-Gm-Message-State: AOAM533KMiOQZmRkLFmPDHw4J010dEZzqB8K24TvPSsAJU6PZULkso9S
 dCmmFLofnM8kt1mZmTqJP4uWpjrxn6DwLEXfeB0=
X-Google-Smtp-Source: ABdhPJxiBmKacSHCnqardmw88c4Q0OW5/V3fLQzY75pI9koggT83OYbb35ZfIORvxITUz582p+Dl+EQo408sLfo+RiY=
X-Received: by 2002:a5d:598c:: with SMTP id n12mr28836702wri.250.1637228903193; 
 Thu, 18 Nov 2021 01:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-17-daniel.baluta@oss.nxp.com>
 <YZU75B2JHbYHy40l@sirena.org.uk>
 <e918b4c4-dc85-dcf5-2781-5edfcd1bf1a5@nxp.com>
 <CAEnQRZBCc4bhX-sT43KT6Tb-=RK=J9poxRvEM_H=1oXh0_AsPA@mail.gmail.com>
In-Reply-To: <CAEnQRZBCc4bhX-sT43KT6Tb-=RK=J9poxRvEM_H=1oXh0_AsPA@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 18 Nov 2021 11:48:11 +0200
Message-ID: <CAEnQRZAgRW-VRGOsKninEV29NJJH4GjoaOaEAEYbHFqtM3PiHQ@mail.gmail.com>
Subject: Re: [PATCH 16/21] ASoC: SOF: topology: Add support for Mediatek AFE
 DAI
To: Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, AjitKumar.Pandey@amd.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@oss.nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Julian.Schroeder@amd.com,
 linux-mediatek@lists.infradead.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Balakishore.pati@amd.com,
 =?UTF-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
 vishnuvardhanrao.ravulapati@amd.com, vsreddy@amd.com,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

On Thu, Nov 18, 2021 at 11:34 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> Hi Mark,
>
> I noticed that you already applied this. Should I resend the entire
> series or just a fixup?

Later edit: All good. You applied only the AMD patches. Sorry for the noise.

Will fix and resend the MTK patches.
