Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CB0C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 23:19:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2762164D;
	Tue, 10 May 2022 01:19:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2762164D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652138391;
	bh=Kj/+sZtPKnrN+Ix0z7khNl6calBdyVKhDy8XxD5GY+4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NOICbzCiUJza1FtjZ7xPh8heLyK/cTh7upOmVhGnPIONojiCN2SD/bixssNGpgUk9
	 vPqhPEZnKljqCE1VUOJbfrwtiLFz99mi/4c4akMebl+4epUSQKOD91KLvfxdwfFFdt
	 Y4jNdFNfzCu9xmKGSRKBMpo5JfMk/JsxWRnuzc6g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78B93F80237;
	Tue, 10 May 2022 01:19:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9075F8025D; Tue, 10 May 2022 01:18:58 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C9E8EF800D3
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2022 01:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9E8EF800D3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1652138332134727001-webhooks-bot@alsa-project.org>
References: <1652138332134727001-webhooks-bot@alsa-project.org>
Subject: Parallel build failure in rate/ (probably rate-lav/, pph/ too)
Message-Id: <20220509231858.D9075F8025D@alsa1.perex.cz>
Date: Tue, 10 May 2022 01:18:58 +0200 (CEST)
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

alsa-project/alsa-plugins issue #44 was opened from thesamesam:

Originally reported downstream in [Gentoo](https://bugs.gentoo.org/835920) by a user.

It looks like in `rate/Makefile.am` (and I think ditto for `rate-lav/Makefile.am`, `pph/Makefile.am`), with high parallelism (`make -jN install`, for large N), `$(DESTDIR)@ALSA_PLUGIN_DIR@` may not have been created yet. All of these dirs override `install-exec-hook`.

For other subdirs, like `jack/Makefile.am`, there's no problem, because the implementation of `install-exec-hook` for those is set by `install-hooks.am` which handles `mkdir -p` before symlinking/installing.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/44
Repository URL: https://github.com/alsa-project/alsa-plugins
