Return-Path: <SRS0=lXbg=XL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E5C49ED7
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 11:57:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D670E2067B
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 11:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MP7kmAyg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idhpsif2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D670E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0423B1614;
	Mon, 16 Sep 2019 13:56:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0423B1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568635018;
	bh=ylW5nVRAiE0eDyyy3bmUS4+JSpTex8OjNxCn6xwHDy8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MP7kmAygS5/Q0ZjDvC6zD97K+E+e/uTqavdhQtyFbsJVaaG0BKmAJqNMh22XTCxTD
	 p7u2rABbmk8Lsf3NQrTk7f0BbmUE0hVEt6WmSxJwtQcB2HImO6Iv9wEuaDTn67pVQe
	 xNsYaw6wLdrqJlvLjuXbLyaw4iGOdjauWRRXvPVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B446F804FF;
	Mon, 16 Sep 2019 13:56:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8704F80137; Mon, 16 Sep 2019 13:56:05 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E69CF80137
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 13:55:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E69CF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="idhpsif2"
Received: by mail-qk1-x736.google.com with SMTP id h126so28332567qke.10
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 04:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z+WPoazhEU/wFQlA0EXFLbyMbDxsg6F96J1jF69XxQc=;
 b=idhpsif2GTDekOX2OLxzj7kxiWhi2SInifnrd0p80R8HwflSdTVnAg/923m6cQsMrF
 4N7kFFuV3cAceHKhdAyGPYvJaaFs+v4O35SYjK3g0ys1nz8+6wiiwoS2LlF1rMW4pM4/
 WB8UEtiU19heKM97Ic2YXVr96pk1VbqrSoHlakw3sCTrtE6pv2m4Zuy8uyH3LdkLeEPG
 w/+TLKeUdS7VHWIQGqWf5L+gNcPf4FBQZh0KMH6gIaBScpyUbDy1oW1bV3sO53/dnPWc
 ijlxXZaIMDCIxDCEU74yH4EGROtkMmfdHhNOttT2xvU5ttIO/s2poD6YKQfjDvvVlmr3
 h3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z+WPoazhEU/wFQlA0EXFLbyMbDxsg6F96J1jF69XxQc=;
 b=aZZY0A1HiqZt0Cnj/VhpLwMXrosGSIKpsXPG5szAxve+OfXEU8rtQ808H/jqDrNRzp
 r1Mj7w4M78aP8UiU+fTPOHIbNoeAEfQOtkrAk91euW+DoDsqElXXSUrL5BQixSPnRr+U
 BdDuuQ0ixif3heaM8rYLcsz72L+swhAsLHMwqqZrC2LkfwJxGfabV8xFBV0ciUdXT2jb
 jY7KP8xr/6rQ4KICxQHuEeWEYyDAhLWABMQZBQT/xDzSSmHRzdN7h6ndgRd0ijMBD0S3
 mfwUUa4dIYlh90MJlEubR3l3II3qxVtpFavv6pjHyAaTYJI2+CaK5kD/OIdlJW+mYGVX
 5ooQ==
X-Gm-Message-State: APjAAAUSnLOW3TEPcnDfk6pMazCPgfIEAX1/QjnUh6DGQMlMrMwrWrq0
 EMJMfEfrXnQ3cpyzifvamrIzff1bZ/XQ4eK3FVs=
X-Google-Smtp-Source: APXvYqzeTKGHv1hJCu6zYUnIyJBdQ5BSqt7vE2S43tq9yYsMc34KcKI05NjaJK6lpOfk83kR2DzzY1duT5JpfC7TGTM=
X-Received: by 2002:ae9:ee10:: with SMTP id i16mr1342911qkg.35.1568634957598; 
 Mon, 16 Sep 2019 04:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <1000767908.8406503.1568280868516@mail.yahoo.com>
 <CAGvk5PpTPppjz70oND=TkVm05VzQDp7RvRDH+8JXrDMrAS8LPg@mail.gmail.com>
 <961122733.10516996.1568629558023@mail.yahoo.com>
In-Reply-To: <961122733.10516996.1568629558023@mail.yahoo.com>
From: Pavel Hofman <pavhofman@gmail.com>
Date: Mon, 16 Sep 2019 13:55:45 +0200
Message-ID: <CA+SWvNyeawE8WayvWJL=NWydxcxouY82oOE=FFHvh_Ru=q1btQ@mail.gmail.com>
To: htl10@users.sourceforge.net
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: Re: [alsa-devel] alsa compliance test: H340 (USB audio) playback /
 capture rate asymmetry bug?
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

This topic seems quite similar to my thread about measuring average
throughput for asynchronous feedback
https://www.spinics.net/lists/alsa-devel/msg96781.html . I perfectly
understand the motivation :-)

Perhaps that inexpensive headset is not really async playback, but standard
adaptive, reporting incorrect USB header? Then capture (async = internal
clock) would differ from playback (adaptive = USB controller clock).

Regards,

Pavel.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
