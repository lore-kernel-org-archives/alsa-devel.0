Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5422BC282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:59:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67814206DA
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DodhsbrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67814206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3277216AA;
	Fri, 10 Jan 2020 23:58:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3277216AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578697172;
	bh=CQtKNwCr/9KQHLpaqK0OJ01sx9wezSb7yhUnQ1VlcoE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DodhsbrXz0NIoBSEilwCc76xlJC9gS1KXq3wTuwsMx+ac/leTUjRyTuIC0oExYl5c
	 g/mnxsbkr42kv7Lrtea77P2+aieiC5IoMy9Y3LrAhF58yeR6XSBRVKSK3HIWixBcoJ
	 gCqPJ2L2wEiTXaptRd1Q1ln66HbixKqn+5Q0wAF8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FC4CF80116;
	Fri, 10 Jan 2020 23:58:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22090F8011C; Fri, 10 Jan 2020 23:58:40 +0100 (CET)
Received: from fontroja.oskuro.net (fontroja.oskuro.net [78.46.213.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DBEEF8010B
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 23:58:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DBEEF8010B
Received: from serrella (unknown [154.46.47.222])
 by fontroja.oskuro.net (Postfix) with ESMTPSA id 40F4871972;
 Fri, 10 Jan 2020 23:58:36 +0100 (CET)
Message-ID: <1fbf9bffb1f13e1ea8e1212a633998b9e6380298.camel@debian.org>
From: Jordi Mallach <jordi@debian.org>
To: alsa-devel@alsa-project.org
Date: Fri, 10 Jan 2020 23:58:35 +0100
Organization: Debian Project
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.101.4 at fontroja
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-27CA1CFB 
X-CRM114-CacheID: sfid-20200110_235836_577225_5C33FFAB 
X-CRM114-Status: GOOD (   6.13  )
Cc: pkg-alsa-maintainers@lists.alioth.debian.org
Subject: [alsa-devel] ABI breakage in alsa-lib 1.2
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

[Please Cc me on replies, I'm not currently subscribed to alsa-devel]

Hello,

I'm one of the ALSA Debian maintainers, and some weeks ago I looked
into updating our ALSA packages to 1.2.1.

I quickly noticed there's been some fundamental change to libasound2,
one that appears to break ABI and should have warranted an soname bump
at least.

With the split of the snd_tplg API to the new libatopology2, libasound2
has been left missing that part of the API that was part of the
asound.h header, etc. This could have been a somewhat lesser issue if
libasound2 linked to libatopology, but unfortunately this goes in the
other direction, so the ABI and API breakage is not avoided.

I cannot update alsa-lib in this state. I could hack around and patch
it to reinstate the missing api in libasound, but this sounds like pain
and suffering for everyone involved. How should we move forward with
this?

I am sorry I only come up with this 2 months after the release when I
had identified the problem many weeks ago, I've been extremely busy.

Thanks,
Jordi
-- 
Jordi Mallach <jordi@debian.org>
Debian Project

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
