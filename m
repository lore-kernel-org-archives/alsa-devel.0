Return-Path: <SRS0=qlOX=OW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6212C433EF
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Oct 2021 01:14:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D1D61AF7
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Oct 2021 01:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66D1D61AF7
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D440D16E7;
	Sat,  2 Oct 2021 03:13:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D440D16E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633137249;
	bh=K9GZonOvlNSqx1rqsfWVJuafIBs/em0kcsSh1U/XXM4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfjKtjXAk077YiZzbD5mm9givN/BtVNR1y6IshK3IHXHCYgCbBfMAAwewIYgiswdJ
	 YAZxvOlrCLLMX++e2665lmUH7cVlPaqUcN/dHxxs4g4wuRA4/3jwO1HgHIQun/OsDv
	 gKPUQHyPjYwkxNLWe0CJdpVyTKDehLDkNGAqm5Lc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ED86F80227;
	Sat,  2 Oct 2021 03:13:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2338CF800EF; Sat,  2 Oct 2021 03:13:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D514FF800EF
 for <alsa-devel@alsa-project.org>; Sat,  2 Oct 2021 03:13:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D514FF800EF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1633137188020005941-webhooks-bot@alsa-project.org>
References: <1633137188020005941-webhooks-bot@alsa-project.org>
Subject: Scripts to save and reload ALSA settings on shutdown/reboot doesn't
 work for Baytrail atom
Message-Id: <20211002011318.2338CF800EF@alsa1.perex.cz>
Date: Sat,  2 Oct 2021 03:13:18 +0200 (CEST)
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

alsa-project/alsa-utils issue #113 was opened from Pic-master:

Issue persists across various distributions.  
"best" workaround I've found is to save a copy of asound.state to user home directory, and run alsactl --file /home/asound.state restore at boot.  Janky work around that only works for one user.  Chased the issue as far as I could.
Running sudo alsactl restore also works, but must be done after each reboot (also had to manually "sudo alsactl store" first)

Currently on GalliumOS 3.0
Acer CB-131 N15Q10

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/113
Repository URL: https://github.com/alsa-project/alsa-utils
