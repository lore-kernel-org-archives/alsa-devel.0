Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD81C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:37:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4992072D
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ag9Bxv8I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQQfuMNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4992072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8070815F9;
	Tue, 25 Aug 2020 16:36:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8070815F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598366264;
	bh=HxJmcEyCz0FOgPHkuFBg/mO6k2aqIYXS10wXgaBveeI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ag9Bxv8Iu0UQbedeUOxv0YhlJjta1kBEtsjCw2IwW3e/DpUEVNvXPv4VAZFkN1mjz
	 CGm/5NeNLT1cNBmUEI9m0AP9XF8S7i6E7njr0F5qe2HgiEpOi2WFViutLTo2pajrv+
	 J2CuXfZFiz0Wee3vv+qsaIW4IdneSZfr/cjohdtU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15E2FF80245;
	Tue, 25 Aug 2020 16:36:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6E98F8025A; Tue, 25 Aug 2020 16:36:52 +0200 (CEST)
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com
 [IPv6:2607:f8b0:4864:20::942])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5628F800EB
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 16:36:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5628F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="fQQfuMNA"
Received: by mail-ua1-x942.google.com with SMTP id z12so3785196uam.12
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hL0qJ9j23Ng/ln8JnPeYmHVc6nK2CKWzcn8mrUMi/WM=;
 b=fQQfuMNAzUotSn5AERfS/BxrBuA/aSQ+Er3rg89bh+TOg/PwYDrkRzW2UEGYGQsG+c
 GYcIHPKnd5ApX+cHbBYmVT2nrY+XQpo58POMfXb6b37hYAIivgnvmD3jQw9Y+LpnaBok
 /oIEhtvitaDovdqAllM2xKOS5+p7ApbNGen7EWqk3t3JotrCSprxGrrqtRnhXjgCfcfe
 FpwKvTDoR/urfOd2z/c2k3kVKVu892Su+JCaeMME5sAj46xGI6oN1hDZJwFcofwW/3+3
 BAzepJ109XCasmQpUf5vT2taWHnY8DvEhujrwXzqix564UugmsQ/UX+khht/jidbJszs
 TPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hL0qJ9j23Ng/ln8JnPeYmHVc6nK2CKWzcn8mrUMi/WM=;
 b=BfF7E3d4ghIOLn9TKzCXIdknyZKntk0qEoPaDlxeVieLO2gjfY4DoEqK4iJLsCsNOh
 24RocYzASPRo99lQbRAbYhW8zxpt3xhTdxUFIaB2WNxhu54QaUUcpnatGi8E1+XlKjqq
 vECvXa5TwmOqJW7cma/gr4iiy9nxvTYcVI3K7lAv+e/QdPgSwbOlzGXtx+lYPDG0eEGQ
 f25DWNfX/ftswlHedzpKuReoElp/O2LxKrZvtdoK4NMVYCgwSkfxXda9VU5NpoM1KdrR
 uNd58PtWYaGbeOqyOEGD6fS8O7u9pTWi9YnplkRsTYLqlKMLkFkuip1VH4jWqOENNWD6
 y5+g==
X-Gm-Message-State: AOAM5304oTbHqyK8/7nOhDtYrbnYOUgUybAe0jS7y284KbVjHLHn4Dt4
 sYZB7cYVIG8dO2Cn2fVUmrBKBQUxmVQlGP8gARg=
X-Google-Smtp-Source: ABdhPJzNY4JSY1QZUWMNhAkujYiFpUD1BIDesSZMaD3oHh1fpFeZSIILItI07ZeWw14WCgwcdG6kysZ7S8JeaDLbeIQ=
X-Received: by 2002:ab0:462:: with SMTP id 89mr5866066uav.34.1598366199357;
 Tue, 25 Aug 2020 07:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <7210c752-0a1f-3985-91f0-b70facf0293c@gmail.com>
 <30693624-744d-6971-1dc8-8ffe4df6082c@gmail.com>
 <s5h7dtn6tpc.wl-tiwai@suse.de>
In-Reply-To: <s5h7dtn6tpc.wl-tiwai@suse.de>
From: Adrien Crivelli <adrien.crivelli@gmail.com>
Date: Tue, 25 Aug 2020 23:36:13 +0900
Message-ID: <CACjDtnKEGf_z3_wvP5Y_55UgqdPuNRWtONefBXtg0tq7f=ArxQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion
 15 inches
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Alex Dewar <alex.dewar90@gmail.com>, linux-kernel@vger.kernel.org
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

I believe the code is correct (even though the diff is confusing), but I
can edit the commit message to also mention the model name.

Should I submit the patch here as a reply ? or should I create a brand new
submission in a new thread ?

On Tue, 25 Aug 2020 at 17:00, Takashi Iwai <tiwai@suse.de> wrote:

> On Mon, 24 Aug 2020 14:31:17 +0200,
> Alex Dewar wrote:
> >
> > My mistake -- I didn't read your changelog properly. Sorry!
>
> Would you resubmit the corrected fix patch?
>
> Also, better to indicate the device id number in the patch
> description.  It's confusing which entry you've corrected
> intentionally for what, and documenting it would help understanding
> it.
>
>
> thanks,
>
> Takashi
>
> >
> > On 24/08/2020 13:30, Alex Dewar wrote:
> > > There's a mistake in this. The ID numbers are the wrong way round.
> > >
> > > Alex
> >
>
