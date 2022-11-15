Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C508C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Nov 2022 16:47:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A0E71655;
	Tue, 15 Nov 2022 17:46:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A0E71655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668530842;
	bh=M8RSzU3qPg2K0E35aAMCMo+kkoPlsqVjtWAa7z0Ijco=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hnip1ZEObBRG4oPT+pbIkQHKxN21PDAmdmhpCKuF5cUZDOjMpJWclys1KNecAMY7f
	 9kotSpi4V+NafucBcJXYf5V8F+eHHGbCtvLADhTgCfR0MjwwpupGJuk2OACF99hH1T
	 lVM5PPYZGnCfYyILDuNwgi6y9Qj5z85F4v34Mc+0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02C7CF8016D;
	Tue, 15 Nov 2022 17:46:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C627F80171; Tue, 15 Nov 2022 17:46:31 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8E9D9F800AA
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2022 17:46:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E9D9F800AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1668530788114762068-webhooks-bot@alsa-project.org>
References: <1668530788114762068-webhooks-bot@alsa-project.org>
Subject: HDA ALC1220 DualCodec no optical out
Message-Id: <20221115164631.2C627F80171@alsa1.perex.cz>
Date: Tue, 15 Nov 2022 17:46:31 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #239 was edited from Almoped:

With current pipewire and alsa-ucm 1.2.8 I am unable to select profiles which has iec958 output, actually I am unable to select any card profile at all in pavucontrol. This is possibly because all the electrical output jacks are disconnected and optical out does not have jackdetect. Or maybe DualCodecs/HiFi.conf does not configure optical out.

If I remove alsa/ucm2/HDA/DualCodecs/HiFi.conf it uses alsa-card-profile/mixer/profile-sets/default.conf, goes on a probing mission I get a working optical out and the possibility to select an array of other card profiles in pavucontrol.
Can anyone recommend a better way to solve this?



I've attached pactl list cards output with working and nonworking optical out.

[pactl_no_optical.txt](https://github.com/alsa-project/alsa-ucm-conf/files/9952236/pactl_no_optical.txt)
[pactl_working_optical.txt](https://github.com/alsa-project/alsa-ucm-conf/files/9952238/pactl_working_optical.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/239
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
