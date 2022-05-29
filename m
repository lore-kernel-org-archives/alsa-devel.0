Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884B5C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 29 May 2022 08:51:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 117931906;
	Sun, 29 May 2022 10:50:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 117931906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653814265;
	bh=Hp6fnkTzd6ZDpsUPSRPEqCkmsLJ7ijpe8djn0ebwgdU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L38BBzmtk6REUOVRaUs3Ieb1BPm7dPbWMmyEN9a5QsA75w0NxOIMu9cXTH9ep0xhh
	 AHuM8OfmcxcF5+Qvp+U5iWH4AwS4kOVjQ/dqYl/ykfecl6I74BCALCOWHGKI7QQsBU
	 ew8WSUi05aHvHmMulMedZxqx8wcbjaRcNd+rp1Ms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99345F80245;
	Sun, 29 May 2022 10:50:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86E12F8024C; Sun, 29 May 2022 10:50:13 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 20F97F800DE
 for <alsa-devel@alsa-project.org>; Sun, 29 May 2022 10:50:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20F97F800DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1653814208597048044-webhooks-bot@alsa-project.org>
References: <1653814208597048044-webhooks-bot@alsa-project.org>
Subject: ucm2 - splitting 10 channel interface into mix of mono and stereo
 channels
Message-Id: <20220529085013.86E12F8024C@alsa1.perex.cz>
Date: Sun, 29 May 2022 10:50:13 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #161 was opened from smangels:

Hi,
I've pushed a PR for the Behringer Flow8 digital mixer configured to be in "streaming" mode. Now that I've managed to wrap my head around the configuration, I would like to continue with the so called "recording" mode (different ID in `lsusb`). Thus I wonder whether UCM2 syntax allows me to split a 10 channel interface into a mix of mono and stereo channels (mic - mono, master, stereo)?

Regards,
Sebastian Mangelsen

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/161
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
