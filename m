Return-Path: <SRS0=4A4t=HB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7E5C433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Jan 2021 14:38:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423F564E0F
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Jan 2021 14:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423F564E0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0FA715E4;
	Sat, 30 Jan 2021 15:37:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0FA715E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612017477;
	bh=TAs+Ko98HuoLDbiVScFyi8XcwxAD5kbUQywichfnuGU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VdTGKw/W1p3DnxUpwkHRyATUqcYY84fI1WZEaTx/8oYJNYIkEBxQOsW+n58PChWDz
	 Nkk1G8ZYeXqqIQ+KXtaR54XaqhYRp/fDU76SEKZwOsuKANHja79zZhR9t7iWPPkA1r
	 r+/fNWy0faxHTXtMxXphdxCSrdGvp8o70AZVb2iI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35D36F80158;
	Sat, 30 Jan 2021 15:37:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 541D6F8015B; Sat, 30 Jan 2021 15:37:05 +0100 (CET)
Received: from muru.com (muru.com [72.249.23.125])
 by alsa1.perex.cz (Postfix) with ESMTP id E866BF800BE
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2021 15:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E866BF800BE
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 7768D804D;
 Sat, 30 Jan 2021 14:36:59 +0000 (UTC)
Date: Sat, 30 Jan 2021 16:36:48 +0200
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv1] ASoC: cpcap: fix microphone timeslot mask
Message-ID: <YBVvALhY2oM/AMmz@atomide.com>
References: <YAqOSg2z24NpjKDh@mwanda> <20210123172945.3958622-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123172945.3958622-1-sre@kernel.org>
Cc: alsa-devel@alsa-project.org, Merlijn Wajer <merlijn@wizzup.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

* Sebastian Reichel <sre@kernel.org> [210123 17:30]:
> This is compile tested only, since I currently do not have
> my Droid 4 ready for running some tests. Maybe Tony, Pavel or
> Merlijn can give it a go using e.g. arecord.

I just tried recording with arecord -D plughw:CARD=Audio,DEV=1 | hd
but only see the header and no data.. DEV=0 won't produce anything,
maybe I have the alsamixer settings wrong. Let me know if you want
me to try something else.

I do have the pending voice call patches applied on top, voice calls
work just fine with your patch. So as it looks correct to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>

