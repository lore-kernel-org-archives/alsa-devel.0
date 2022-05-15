Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EC6C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 15 May 2022 02:08:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C837F170B;
	Sun, 15 May 2022 04:07:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C837F170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652580489;
	bh=vS6ymj725DcEJsCBOSjbzgGwhPOARYtOoYe3hjFTkUE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WZP1GaIaR9SbixNyoWoT+1syqtXNWIyenwKEGrgGenulI8OF1AvBf/O7BPxuEK174
	 95MX4qzYzZcH3dJMsoKYQu2U5aWacexC6DfaxlK7BKQ4McMHhkskVTAUD8gwzxjlSN
	 gs4DQlT5gpUcLpl2rNf0mtwj3EQxSgNjrR87VGX8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 644F0F80169;
	Sun, 15 May 2022 04:07:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0D58F8016D; Sun, 15 May 2022 04:07:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id AA42AF8012C
 for <alsa-devel@alsa-project.org>; Sun, 15 May 2022 04:07:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA42AF8012C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1652580430188743114-webhooks-bot@alsa-project.org>
References: <1652580430188743114-webhooks-bot@alsa-project.org>
Subject: chore: Unify Travis CI process to GitHub Actions
Message-Id: <20220515020716.E0D58F8016D@alsa1.perex.cz>
Date: Sun, 15 May 2022 04:07:16 +0200 (CEST)
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

alsa-project/alsa-lib pull request #226 was opened from Korilakkuma:

[Travis are now recommending removing the sudo tag](https://blog.travis-ci.com/2018-11-19-required-linux-infrastructure-migration).

Request URL   : https://github.com/alsa-project/alsa-lib/pull/226
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/226.patch
Repository URL: https://github.com/alsa-project/alsa-lib
