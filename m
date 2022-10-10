Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFCDC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Oct 2022 12:10:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04FDC2996;
	Mon, 10 Oct 2022 14:09:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04FDC2996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665403812;
	bh=s3/QDNXgZ/2K+FUTKrf/gZ9xIJimRqklF88lgaVEM+w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t6fZO2XTA8sZqpjCnjqVWqSvvdFs7J+t+tQzppgoidf3AYHtFX9Opnd4OYr6F1LKd
	 PjNJ3KAvTK2NTrZLs7JowaM88/89U6tBpYyZP4mTmB4v/grxx8b9+NCpyvbceClCvL
	 eHEwFXAB+eFI7fdh9HgLgCWKPVNvpK1r876t2NV4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7CCAF801D5;
	Mon, 10 Oct 2022 14:09:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6495EF801D5; Mon, 10 Oct 2022 14:09:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 96BF4F80155
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 14:09:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96BF4F80155
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1665403753918127060-webhooks-bot@alsa-project.org>
References: <1665403753918127060-webhooks-bot@alsa-project.org>
Subject: Mute PC Speaker by default
Message-Id: <20221010120920.6495EF801D5@alsa1.perex.cz>
Date: Mon, 10 Oct 2022 14:09:20 +0200 (CEST)
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

alsa-project/alsa-utils issue #172 was opened from lnussel:

SUSE has a [preset](https://build.opensuse.org/package/view_file/openSUSE:Factory/alsa-utils/01beep.conf) to mute the PC speaker by default  as it can be quite annoying (https://bugzilla.suse.com/show_bug.cgi?id=767270). Would it make sense to include that upstream?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/172
Repository URL: https://github.com/alsa-project/alsa-utils
