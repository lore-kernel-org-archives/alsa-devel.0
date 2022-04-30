Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3237C433F5
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Apr 2022 16:48:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47BAE1F1;
	Sat, 30 Apr 2022 18:47:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47BAE1F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651337315;
	bh=RyTvpy+xpNHSun3RlClaAqDovG8MWonIQwmp4Qj6ER4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U3ebZUTPgL82LsptkqMmzLZzhKoRZmuHjdat2GyE5OZZJkTMafQmNQJVpfS4qDIAl
	 KOxVsH/URP95UwlHBi3VRk7KAacIHg8rvX/EtbedX8QPrnq1XZqeqAlqvtd0nMXGzZ
	 iRmiOA1VcdSZtEpo6j1yY0byp3w2vBvNws6yhs7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB51AF800E9;
	Sat, 30 Apr 2022 18:47:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F859F8012A; Sat, 30 Apr 2022 18:47:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7E6CCF80125
 for <alsa-devel@alsa-project.org>; Sat, 30 Apr 2022 18:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E6CCF80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1651337257584858894-webhooks-bot@alsa-project.org>
References: <1651337257584858894-webhooks-bot@alsa-project.org>
Subject: how can i swich between sound card without reboot in archlinux
Message-Id: <20220430164742.2F859F8012A@alsa1.perex.cz>
Date: Sat, 30 Apr 2022 18:47:42 +0200 (CEST)
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

alsa-project/alsa-utils issue #144 was opened from EN-KS:

currently there is no sound output when i try to plugin a usb 2.4G wireless headset in and then F6 to select the usb sound card unless I leave the usb adapter on the machine and reboot. the usb sound card was detected tho, Is this what it suppose to be? or any procedure that I missed?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/144
Repository URL: https://github.com/alsa-project/alsa-utils
