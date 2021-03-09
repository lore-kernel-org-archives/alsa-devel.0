Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC8FC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 17:36:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE2865215
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 17:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE2865215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 567451852;
	Tue,  9 Mar 2021 18:35:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 567451852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615311371;
	bh=qEeHF1bkF/s8Nup/YS/xmjD0GTJz/Fx5h6eW1p03+mg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NFav8gT2ZkNudmS4PaAjjviePDoUzdkcAHwi0D4dsBc0pB4poKSkwLv3jZV/JGJbD
	 Ynh4NLNYlKPLvbfyqqiwbOsGCNvAnEE3y76NED9b0gfwJShPyLhHuCb+Ln7woQmR6J
	 dltGaLYERwaeT1jJsPf2fmQBeR5s8x54FeBcQHi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD353F8019B;
	Tue,  9 Mar 2021 18:35:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E05E3F80227; Tue,  9 Mar 2021 18:35:17 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98C10F8014E
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 18:35:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98C10F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="UeuTg20m"
Received: by mail-io1-xd35.google.com with SMTP id p16so14840966ioj.4
 for <alsa-devel@alsa-project.org>; Tue, 09 Mar 2021 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DmuMTKPgI4rvpVuf8oMBCRKIFbTVFYpM6AjfH1czpVk=;
 b=UeuTg20mqMDa5llzeYwoXUajW0FO/a4FwBoRZN6CNMo8a7pdwj+9azgccEHL27ZeO4
 fubplDPVvW3cBUrM93gxHkcJ+dryrLEqTwRn3oN4fgGV5osDQeW3TI341L9k+3sydYbc
 0iBH/0QMfj3L9cv+3bF1tAQTMxvVAnwwk/8MQ440eVApMHkt+J/Aa3G1EIMhtkocINsU
 P/P8eQv6jllnD0koYDCesGy61FuVqEcgFXytApy7Afvegh67FN+VuaU0xggwQOWUlkCV
 +Oyr+NSl5SHOnR7q+5pcDnYpafmGqFadtwiaA+3HrTxwXliBnDquy6ZIwxUt9sdpG+KE
 FHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DmuMTKPgI4rvpVuf8oMBCRKIFbTVFYpM6AjfH1czpVk=;
 b=SZ6k11rv9aIXipRhRWXvwLeBAdkYatE9B6gGJRTDAZleb+7FyohEGAj524bvziKM7r
 cMXITq+s6ieApL25fIl5gODunjrE9JyTzdnUf5ywUuaPvxhdbqvJkcUrFj/fPmSL9fuP
 z12WJwgFE9MXZXrLxs6UPaf7sswxMSGMVy45g7ojUOhTX8/RhLOCTx5mtt8aSohtAdG4
 njaFVUqOnpnBJh21URh3Fbf7LRXkGW4mBtkepTVmb1IabEm4F//M8hFytqQp4ZcDyGSZ
 0OA1gZjhfaJikRAkfmto0je1vMv6DS7shY+1EWAj0P2hUZFw7yPFKFZLg/tfpy/DlrHx
 AgSA==
X-Gm-Message-State: AOAM531L1RM5lSYJMm986y1WteBEJS28LuYfaRPODKiHsIchqsdvPKLP
 ydD0SKOEVilEHF8wRZei3hsgPNyeyVBx1G0C46E=
X-Google-Smtp-Source: ABdhPJwlNhcPjktvbzqx7FyhH5EwSHjnBsptzPhHStDki9Ti7ZTG8feCYINbitY8EIRAv/lTSY4NVv4mKYMnzMTanvk=
X-Received: by 2002:a05:6638:91:: with SMTP id
 v17mr25799540jao.69.1615311303036; 
 Tue, 09 Mar 2021 09:35:03 -0800 (PST)
MIME-Version: 1.0
References: <998cafbe10b648f724ee33570553f2d780a38963.camel@gmail.com>
 <s5hk0qg3kds.wl-tiwai@suse.de>
In-Reply-To: <s5hk0qg3kds.wl-tiwai@suse.de>
From: Simeon Simeonoff <sim.simeonoff@gmail.com>
Date: Tue, 9 Mar 2021 19:34:51 +0200
Message-ID: <CAAKzhiZOW9ZO2eb8RQDGp4F0TbTjKJ4h=nGF3jMRMFSWrpvBNA@mail.gmail.com>
Subject: Re: [PATCH] SOUND: pci: hda: Add Sound BlasterX AE-5 Plus support
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: linux-kernel@vger.kernel.org, conmanx360@gmail.com, tiwai@suse.com,
 alsa-devel@alsa-project.org
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

Great, thanks!

On Tue, 9 Mar 2021 at 08:34, Takashi Iwai <tiwai@suse.de> wrote:

> On Mon, 08 Mar 2021 19:48:35 +0100,
> Simeon Simeonoff wrote:
> >
> >
> > The new AE-5 Plus model has a different Subsystem ID compared to the
> > non-plus model. Adding the new id to the list of quirks.
> >
> > Signed-off-by: Simeon Simeonoff <sim.simeonoff@gmail.com>
>
> Thanks, applied now.
>
>
> Takashi
>
