Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD88C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Dec 2022 10:51:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 870861721;
	Wed, 14 Dec 2022 11:50:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 870861721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671015065;
	bh=iRpltuw76wO62OZ5Cj68y8XAN3wOPoHx/Yv0HbVU8ms=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WtCbf3mPlGk9RDGoFtAgws9Z93ambKEK4VONGeUQNCEJ3ZSN2inCc/Fvs4JgWlIyj
	 ldfnhqC7n5PHf1PJcX+H9+MhPyTt2N0JF2YqE6tK+ZuQvYxJrhByl+YRS/NbgkzyXD
	 hOVhM6CxzQP3OIC7dNDQvObrJHlLx/qGrx3ZZa/M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C57FF804D7;
	Wed, 14 Dec 2022 11:50:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CCEDF804D7; Wed, 14 Dec 2022 11:50:13 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DDAE7F801D5
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2022 11:50:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDAE7F801D5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1671015011092863083-webhooks-bot@alsa-project.org>
References: <1671015011092863083-webhooks-bot@alsa-project.org>
Subject: ucm2: add profile for the Samsung Galaxy Note II (Midas)
Message-Id: <20221214105013.8CCEDF804D7@alsa1.perex.cz>
Date: Wed, 14 Dec 2022 11:50:13 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-ucm-conf pull request #250 was opened from FrostI7Alex:

Might need few changes in the future, but for now - it works.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/250
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/250.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
