Return-Path: <SRS0=kaWB=7O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271BEC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:25:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F6E20772
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rDRbaTAb";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwyL7sK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F6E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E07D16E4;
	Mon,  1 Jun 2020 09:24:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E07D16E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590996322;
	bh=mxAYzF8OzzHURzEooOCt5aqNg7V74tDjZtxIS2Xknxc=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rDRbaTAbqpqnQohAeUZKLSY2VYFRDH8YDYpwOzhXwuhy78dFoozpHS4tSAACNgirG
	 ZOtbZ0TH3GIFZADJmJBW67+x8I2j0v4OYr6p76jhheFsNCza+UTui9K3qQ6qsEHJyl
	 kBdQKWKihR2piyThPQTNREyNe8AxFY1ROffKM79Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACF43F801EC;
	Mon,  1 Jun 2020 09:24:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CA20F801ED; Mon,  1 Jun 2020 09:24:30 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF67BF80159
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2020 09:24:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF67BF80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BwyL7sK0"
Received: by mail-il1-x12b.google.com with SMTP id a13so3668457ilh.3
 for <alsa-devel@alsa-project.org>; Mon, 01 Jun 2020 00:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=mxAYzF8OzzHURzEooOCt5aqNg7V74tDjZtxIS2Xknxc=;
 b=BwyL7sK0mETBUeSxKVGfov8XBgJvy4xpWxgmdt6p19kGWb9n7qeXai/vgD8JR1b+SK
 XqDuWtL0WkV1uHmoC/OWfb7DNP/qLPnNuWz6/e8VWYJ3slJ5m7ZqCZ/WCKZBvup15fIo
 IYkHKVX9Ps+4K+28kNN9VkHTCDWI46oJSAHTTiEqqnuuNLckODzLI2Zf3I6+NzFTri/R
 BEJbeb1qk3yC4fyOVAvonu9POf3hQZe/btraMCmd0720Fclr9/uH0uZnQNn3k8r2/n3A
 DIBkCbhWWmrMu6EX4jaA5E8bFTJPeolrxTh1txJpf05Rpl8HcTQXstif1TZVv97n6466
 s/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=mxAYzF8OzzHURzEooOCt5aqNg7V74tDjZtxIS2Xknxc=;
 b=hvHoaNYUWFMJTXpOpK2h90M8bi9AbNu6n6jhZ4zeDodj6othwqmbTjZc8IUm+q6oAR
 wqxdDUJ2SFr1cCbZLiRGHmlRlooBlnKUOuleIBOrO7SytMOBunDqZVkhg4hK9gBPThuY
 aPpa7jFyPDHAoEarBNUPYSPxZe2/DiD0Kk3vtgux0fOFZYMvqsjBX9gEZCbydqc0JY5P
 OElC6e5t3YG6ycgzfUvTYlcBsEOaX4hUWOTbJh/HxXDqN91aIklEXZHDHcyXbVTaaps1
 bKvpSL32cM7muOjthLaFp18tz8DlIumB5hauCWcI14m3mwI+KXwdFNNrAny+NoHve8oW
 sxCw==
X-Gm-Message-State: AOAM532O/f4uUpglPLdYqI1HRonThLLe3OwZGD5Qpv443WimEnMyjfq2
 pM3nPOXy/GiLqf33J3sqhXLQh6Lkq6zpL+aET8xz05Haw18=
X-Google-Smtp-Source: ABdhPJyXTHyQpOj43kme+jjDaM0KZaZVwwk6RWjbED1g+QMz8h4ijhuRb4R8QlB/SQrrY+DK5IJZgj4yuA89qgVHJ/U=
X-Received: by 2002:a92:d3ce:: with SMTP id c14mr7706758ilh.62.1590996260521; 
 Mon, 01 Jun 2020 00:24:20 -0700 (PDT)
MIME-Version: 1.0
From: Paul Dann <pdgiddie@gmail.com>
Date: Mon, 1 Jun 2020 08:24:09 +0100
Message-ID: <CALZj-VpLECyDaBeHcowTnCcufLVaPyr7Xxii+PbkrwGn9kYU+w@mail.gmail.com>
Subject: SOF 1.5 release on FTP server
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi there,

I'm eagerly awaiting the sof-firmware 1.5 builds to land on your server:

https://www.alsa-project.org/files/pub/misc/sof/

Archlinux builds its sof-firmware package from there. SOF 1.5 was
tagged on the 27th April on Github. I'm wondering if there are plans
to release a build for this version to the same place?

Many thanks,
Paul
