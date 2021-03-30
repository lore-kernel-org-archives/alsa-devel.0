Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB9CC433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 22:47:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0314619D0
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 22:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0314619D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05E0E1684;
	Wed, 31 Mar 2021 00:46:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05E0E1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617144463;
	bh=7A1LJddtJGWDBghRM/PUZq+eknKas2UqE/3hgPStmTc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sA8Bp8fWKepQkl6Vuc7Pnhw93EeWN1wKDcVwv7sI6v545n6kO3virkeRv+8CDN00r
	 TS+8Al8/9HBj9SW7nICfEBvfYTCpFOtsPJy/x86Qy0kWrL6vnV8OqH+zt0Rg8YyYVK
	 G5FIeZrktF7UjFiB1czfzKuTuArFHnuvfj0l/EUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C582F8026F;
	Wed, 31 Mar 2021 00:46:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59FF3F8027B; Wed, 31 Mar 2021 00:46:49 +0200 (CEST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB016F80141
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 00:46:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB016F80141
Received: by mail-ot1-f54.google.com with SMTP id
 w21-20020a9d63950000b02901ce7b8c45b4so17123660otk.5
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 15:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aGzeEH5mBTJMAUFMUyumPvxqBcopNYVaqYyCfVRg1PE=;
 b=HfGQ0qioyrpTEqA925UaQmgD11eRthvEtHly2p5v+Ef6YGC1OgTu2SNPXhVd+NOQa8
 LQPI5N8s+6C5Wv5TCkY6/XmOFU9gN8qJFhcsF2TfaX9Ms03EzlTw7GDvkgFi3SiRFBAy
 pmAlJmeBgl/BucIAe3crv3TdQnQKGG/jPBFkYTZXQiNu8VN4jy15nih52wq79JTu+NFA
 n/K3DrXZvmvwgqLEUfhBLn27aSutgghu8uP33Q7MFSdX9mbvksgknNlBSvJfjBrrL0tP
 6J4M9B/CLzvMDCHMyhbXKIzIKPM0i5BkpAoQjdeHjZCSQqZ5QWt0KB62GGU1JPdzZbNx
 W09Q==
X-Gm-Message-State: AOAM531PEbkdVdIwG5WGDYxDg9N56Se3Grikr7h6lOXy+U18VnDN49SB
 gau6PnlVqtztogjqmieehg==
X-Google-Smtp-Source: ABdhPJzcaM6kUVKoGLiXQ246HIWyIy+Xp/TRzyneLWkFrzP2NKiKBct6ibzozzNzngKcnVWjng9qdw==
X-Received: by 2002:a9d:65cf:: with SMTP id z15mr150593oth.310.1617144400277; 
 Tue, 30 Mar 2021 15:46:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p3sm80707oif.53.2021.03.30.15.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 15:46:39 -0700 (PDT)
Received: (nullmailer pid 852063 invoked by uid 1000);
 Tue, 30 Mar 2021 22:46:38 -0000
Date: Tue, 30 Mar 2021 17:46:38 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: ak5558: Add compatible string for
 ak5552
Message-ID: <20210330224638.GA852033@robh.at.kernel.org>
References: <1617085972-6094-1-git-send-email-shengjiu.wang@nxp.com>
 <1617085972-6094-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617085972-6094-2-git-send-email-shengjiu.wang@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org
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

On Tue, 30 Mar 2021 14:32:52 +0800, Shengjiu Wang wrote:
> Add compatible string "asahi-kasei,ak5552" for ak5552
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
