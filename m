Return-Path: <SRS0=mf6l=XU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C3C432C2
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:26:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AE221D80
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vCUgV7lM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGEHjKoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AE221D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC33816FB;
	Wed, 25 Sep 2019 15:25:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC33816FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569418005;
	bh=7dTJFjiGmUiTg9bmGxEpkPLxlIxXeByPyyn9VDjMAsc=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vCUgV7lMwi03+WUmi2lUIx7g9TQV88S+i20QpOpC+GSMcp8VVDW+bLP9PzZ9rR7lG
	 mjmhXCAB/VAmJjXa3eBqh1Y7gTzYun+JrUJ95YYDi2ahObBsbaJgE5xVaRoijwYGSv
	 qvnHE0+CMyzGhXNXHmj8+O2Lo7zJ/eO8yXxoV6GU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 349BEF80323;
	Wed, 25 Sep 2019 15:25:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8702FF8044C; Wed, 25 Sep 2019 15:25:48 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50041F802BD
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2019 15:25:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50041F802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="tGEHjKoS"
Received: by mail-wm1-x335.google.com with SMTP id 3so4966021wmi.3
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2019 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=U5LbEhvdDcYAgldwxf5AE0NTYVKCqDWsYOrZ5rG3o9Y=;
 b=tGEHjKoSaBedvQ4ihgLytRPwNwwX3kPzLQTn7dZsJT5LngsbQQkLlIq1/4USp76D6w
 YnpFS282TnkpnKgin323JjioTVEPzB2YGhv5GrjzmgcYeMsiFVl8Lb/R1I7GtcshAAXf
 cEaGiA+ILdcwNkFBDfCpp7V7iZI4fn0ykqpCHQncOGfamcyvmQlxaAVBBNNIxkhHRYC4
 bHKqhZL2j1wcAXgceheSLR1bvYN5V5S61CFOOLSQbXcA/Ore80qZdXA4AFgftxpxvyCT
 PBvMI81nRXT+26kAmEst87tLa4wMs6dU64twTjA7vtAqejqX86zOML4FbTEHGQZLc4Px
 aWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=U5LbEhvdDcYAgldwxf5AE0NTYVKCqDWsYOrZ5rG3o9Y=;
 b=M3zGvoHcki4M58XEuw8kYIMHjJxFR46MeB3I+9CfjwK7RG1FKweshi+/Gw+ozpRA5v
 yJaMpl5BLBwZhiXqoS8dYfU4ELfmNCo8TvLu8j6FSyL1OndNJh2ll+fd/8ydg52m7y4D
 WbgRf3Xm6YKptoKawr2vW8EqVidMvxlfdXnBI1wO52FTYukJilHat2pnom98A7YN0ia0
 4sn1N3RuJVnrQuMgVtSibprQgHFNU9JNqhbl09alv5x0zQQWJBiDydMzrRr0EeqZ6AFr
 d9zZLlm3WLSN+Rho28er43ermukVP76YO5HVwnJxns6OFz/AjtBjx4d1uG3TRhgmNhV7
 +Gyg==
X-Gm-Message-State: APjAAAUwcFAv+OA+T2pNathFD0ul/HISJRBh/5Do/42VKahvAGvwdvAP
 sqwtR4FGnHa/maAJRL7vg6ZDtN67wK6h9V7Fw3RCxowNvXcmcg==
X-Google-Smtp-Source: APXvYqwRXiQbBDbVqr1dKbzREGmLhhjKV75aL+JbBmDHLwG5GEejG3s5JxZeM/RycfXY4uu9fu9LCfCJcI5UwCk7nsY=
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr2335595wmj.87.1569417940863;
 Wed, 25 Sep 2019 06:25:40 -0700 (PDT)
MIME-Version: 1.0
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 25 Sep 2019 16:25:28 +0300
Message-ID: <CAEnQRZD6VsaKbjP1FaBMk5iT2jkk=baPUixVyWMNoqqRXM9hhw@mail.gmail.com>
To: Linux-ALSA <alsa-devel@alsa-project.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [alsa-devel] About soc_check_tplg_fes
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi all,

In function soc_check_tplg_fes (sound/soc/soc-core.c)
there is this code:

    for_each_card_prelinks(card, i, dai_link) {

        /* ignore this FE */
        if (dai_link->dynamic) {
            dai_link->ignore = true;
            continue;
        }
        dev_info(card->dev, "info: override FE DAI link %s\n",
            card->dai_link[i].name);

So, we ignore any FE DAI link but then the info message says the contrary.

Any idea?

thanks,
Daniel.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
