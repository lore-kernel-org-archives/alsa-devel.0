Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0479FC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Dec 2021 05:13:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53073229A;
	Wed,  8 Dec 2021 06:12:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53073229A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638940406;
	bh=Y2XYOM99+N7oI1sod6GUOfcp6Zh0AWdcn+ZmtdLOQ4w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aN5ukclld8iDGoYgCw8t2LWs5+6XZEwHWM48QYPTsyqYUX4iGLtfC7sPgPROM0CDX
	 fF0CFh07N7JtyZRgd6BKfhqxBJX7WQ3rIy/g7Cp44FL0WxV3HgNuhfYn9udq58rmRx
	 YzTqPsQ5IsZStkhyjZwyYS90qe8PQ++Jdkr3ajNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB285F804CC;
	Wed,  8 Dec 2021 06:12:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F117DF804E5; Wed,  8 Dec 2021 06:12:33 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 20A67F80103
 for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2021 06:12:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20A67F80103
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1638940336042325020-webhooks-bot@alsa-project.org>
References: <1638940336042325020-webhooks-bot@alsa-project.org>
Subject: topology: Add option to pass include path for conditional includes
Message-Id: <20211208051233.F117DF804E5@alsa1.perex.cz>
Date: Wed,  8 Dec 2021 06:12:33 +0100 (CET)
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

alsa-project/alsa-utils pull request #125 was opened from ranj063:

The include path passed with -I option will override the relative
include path based on the source file.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/125
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/125.patch
Repository URL: https://github.com/alsa-project/alsa-utils
