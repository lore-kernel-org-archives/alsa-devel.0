Return-Path: <SRS0=vz66=XD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C52C4332F
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:07:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369A6218AE
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S9TnZ4Vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369A6218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=novotny.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 424EE165E;
	Sun,  8 Sep 2019 08:06:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 424EE165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567922836;
	bh=MiMpt+B45gEcbfWz/Mpz/OONGAdRWtx8Sk2vGg59Z84=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S9TnZ4Vt1VO+ZL05cQXdTp8AAdQQt2upSsD0TgNPK0o8dGWTN35neT8juqx5+aGIi
	 uvHgWQxC+GNFoenuxN3PM5ZJe6KOPleH0ZCQGqqqUaHfVESEcjjaK3KaM7Pt5qfFjc
	 93Z3En65fqKD+0hTfOqBBJJWLc1clT5lAAdi9UcA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4F07F80393;
	Sun,  8 Sep 2019 08:05:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8403EF80394; Fri,  6 Sep 2019 16:51:13 +0200 (CEST)
Received: from hosting.pavoucek.net (hosting.pavoucek.net [46.28.107.168])
 by alsa1.perex.cz (Postfix) with ESMTP id 67ADFF80214
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 16:51:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67ADFF80214
Received: from tomas.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz
 [176.74.132.138]) (Authenticated sender: tomas@novotny.cz)
 by hosting.pavoucek.net (Postfix) with ESMTPSA id 4B03E102F9E;
 Fri,  6 Sep 2019 16:51:09 +0200 (CEST)
Date: Fri, 6 Sep 2019 16:51:09 +0200
From: Tomas Novotny <tomas@novotny.cz>
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Message-ID: <20190906165109.53c5a306@tomas.local.tbs-biometrics.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 08 Sep 2019 08:05:28 +0200
Subject: [alsa-devel] omap-mcbsp: TX Buffer Overflow
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

Hi,

we have AM3703 based board similar to BeagleBoard. I'm hitting this error
after upgrade to latest LTS 4.19.71 (upgraded from 4.1):

omap-mcbsp 49022000.mcbsp: TX Buffer Overflow!

This appears during or after playing of short (~2s) ding-dong wav. That error
exists for longer time, because handling of tx buffer overflow irq was
introduced in 2016: 4e85e7776eba ("ASoC: omap-mcbsp: Enable TX/RX under and
overflow interrupts"). I've cherry-picked it to 4.1 and I see the error there also.
The sound seems clear and ok to me, but we are using low quality speaker.

There are two workarounds to get rid of the message:
1) Change 'dma_op_mode' sysfs attribute from 'element' to 'threshold'. I
found that just by coincidence when checking sysfs attributes.
2) Compile kernel with CONFIG_VIDEO_OMAP3=y. Found on Logic PD forum [1].

Does anybody have any idea what's going wrong? Or why these (somehow)
unrelated workarounds help?

Thanks,

Tomas

[1] https://support.logicpd.com/TDGForum/tabid/124/aft/2277/Default.aspx
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
