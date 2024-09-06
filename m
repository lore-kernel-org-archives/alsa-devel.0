Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAFBFA3744
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2024 11:10:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F27FDDEC;
	Fri, 13 Sep 2024 13:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F27FDDEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726225837;
	bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dTquEpiyDpVWm46SNsR1gOB5VL0j0sDEJGE/7plr3iryiByUiLES9sh7fU48jR4h7
	 /vXVxlCz5KOwHgr13qyxLfMsKb1789XzMPmSXUp2+cT+KUx6ITyQVD3di1INmT1JuK
	 WKVCxegKb2M1SgrCWzICP2JUBaOhvHUM+GHKuVeg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90F67F80604; Fri, 13 Sep 2024 13:09:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DECA6F80601;
	Fri, 13 Sep 2024 13:09:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25DB2F8016C; Fri,  6 Sep 2024 19:50:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E2E2F80107
	for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2024 19:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E2E2F80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=xyH61qf0
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42ca580f4c8so115e9.0
        for <alsa-devel@alsa-project.org>;
 Fri, 06 Sep 2024 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725645017; x=1726249817;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=xyH61qf0esSCsuO7T2D+TNi63UB1vQ5x+v1pmz35hPDlHZX7YGnHXdS93wZjlEljbv
         VyCMFI7JiEPdHoewPtGuDOT8q95dG4ifsZzgW8cUTwVehnuC3cylon/C6B28MQ0wxffP
         1/DIEPbKlhiwcYZ/ikk9gq7TmuAzqoV0ubC7HoP0UAsfduOolwLBR2szC9KAaMHqq5fR
         hn5Ikn7IazYEtaJijBi/2vW8VQ1vZCVVbdk+thz0CqPXZK2pcceLKPM+fmCOKniTU8EG
         pokqAiw3LHMsVTOPPM/pEoaLx3986SqQJdiWk2cyvMUUuYG5Olz5J+D0p2KORra7lv5g
         E7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725645017; x=1726249817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pTQd0fZYBkXrGiqthFq6aif50hU5SrlRnRwWPYwCpJd3TlsywZ/UIVf8viT7eu7h0Q
         9+WMi4P6+pPQ2P1ZnP43fHKpZV+9TLc9S7ewQr4CNWoFmBNgp5pLTDpwBFTWrK3E0e5G
         9r1uRMDnxGCwKTBb/KzVHWTCVLAeGiYJI8fHSBVrOn3+HMy9gfFJoLsIor0w6c4U0miJ
         yfxgODq886VmoB4+BhRTvFr9R2KVo1PRfJpWPWYHeGquubcdacTjOt8HMdAIZJ8a52p7
         zTLNFWMw7p9mdcRhCoMH6xr8KXH/h49Dj8SKxd3L4yKEumiIhJ2VCpBqZaXuX55hkwgf
         NINA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyS7forzuCpKbZIisqdWEVIZsDZNBS0MJNx2w86d2NwW+3ydvIHyyARKUbl7m3WZNFvFIFGptlV2iT@alsa-project.org
X-Gm-Message-State: AOJu0YymNHi/xLRGmLHCEl6wjaYbfFCw+aP2asX4ey+MJuG63Pv6O70M
	Z6evEG7Q6iCmCZrt5b3AgR3oiWsADQUMxxnZMk3Fobc6HMdkOwC+Iiq3JkfzAO1Q6AmKox1a/2v
	ASZryiMZsxhM9TLa4W3rhZkfnraouZNez9Zs=
X-Gm-Gg: ASbGncv/6ZfBYlosvopGR1IF2uOFJdlh1NZGXZ0rUwNprrbcoQds+Kkvh19ZAx8Gda0
	vXOt1PTzDS8ZjvoWwKloO9OB+ZRw8MVgp8ffM9ec5kusK+sDW4iwJtHiBSw==
X-Google-Smtp-Source: 
 AGHT+IHOlcv7vqlkgAnGOoFg/Cdu9KrQD+OEz5m6AJTBmUsgUHU751o/ZDkQMZfiOBrlPwGBZScRBDsy3iuUbw5u8dk=
X-Received: by 2002:a05:600c:254:b0:424:a2ae:8d1d with SMTP id
 5b1f17b1804b1-42cacd3ab7cmr25915e9.2.1725645016574; Fri, 06 Sep 2024 10:50:16
 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAFs7P=jk=wfo0nbHzqd1NrGX3NKpOezD4-u=nAMqzq7mq4Lidg@mail.gmail.com>
 <CAFs7P=jPqv2Zr6Fnw584TKhj5joBRt7X7gMidE4MiK1ABAMiRQ@mail.gmail.com>
In-Reply-To: 
 <CAFs7P=jPqv2Zr6Fnw584TKhj5joBRt7X7gMidE4MiK1ABAMiRQ@mail.gmail.com>
From: Joshua Pius <joshuapius@google.com>
Date: Fri, 6 Sep 2024 13:49:39 -0400
Message-ID: 
 <CAFs7P=jfzE6V4EMdVZ73ShdWLavv41kU_NdK-=CO+Cv8dfGBGw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: Add logitech Audio profile quirk
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: joshuapius@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ILFDGOUVVO4MDGWJWYEUPEHBZGH7NQQE
X-Message-ID-Hash: ILFDGOUVVO4MDGWJWYEUPEHBZGH7NQQE
X-Mailman-Approved-At: Fri, 13 Sep 2024 11:09:29 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ILFDGOUVVO4MDGWJWYEUPEHBZGH7NQQE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


