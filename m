Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124EC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 18:44:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFF964EE8
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 18:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFF964EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=base.nu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D269A84D;
	Fri,  5 Feb 2021 19:43:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D269A84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612550675;
	bh=nY/yvnnt76Msr5Ch8d/0nhUQuyrU8fZu5RLtkm30bXE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UHvi7bs7yTZho8ULHmV9+jm/x8oaC5Dn9+TwZnn6AL7PWnNsLTXaN+97eTjDWLH44
	 W62lpDmp3vXssB58FvPyplylZbY/lEUczF1ntSkw+dX4mV+41PDUTAz0IxP6Agb8O9
	 6CNzANQmc/9DgPG8U0/dF8HJEsC2kJOgg2xGp3nY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13697F8015A;
	Fri,  5 Feb 2021 19:43:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D017F80139; Fri,  5 Feb 2021 19:43:42 +0100 (CET)
Received: from hellmouth.base.nu (hellmouth.base.nu [192.248.168.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CA88F800C0
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 19:43:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CA88F800C0
Received: from baphomet.hell (<unknown> [192.168.179.1])
 by hellmouth.base.nu (OpenSMTPD) with ESMTP id 1a660542;
 Fri, 5 Feb 2021 18:43:36 +0000 (UTC)
Received: from baphomet.hell (localhost [127.0.0.1])
 by baphomet.hell (OpenSMTPD) with ESMTP id 1a5da29b;
 Fri, 5 Feb 2021 18:43:36 +0000 (GMT)
Received: from localhost.localdomain ([192.168.178.2])
 by baphomet.hell with ESMTPSA id rnn3BtiRHWC5gQEAnQSWfg
 (envelope-from <livvy@base.nu>); Fri, 05 Feb 2021 18:43:35 +0000
From: Olivia Mackintosh <livvy@base.nu>
To: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v4 0/1] Add DJM-750 and simplify
Date: Fri,  5 Feb 2021 18:42:55 +0000
Message-Id: <20210205184256.10201-1-livvy@base.nu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <s5h35yb5xip.wl-tiwai@suse.de>
References: <s5h35yb5xip.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Olivia Mackintosh <livvy@base.nu>,
 Fabian Lesniak <fabian@lesniak-it.de>
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

Hi Takashi,

Thank you for your feedback, it's very helpful. Attached is an updated
patch which should hopefully be correct this time =)

Kindest regards,
Olivia

Olivia Mackintosh (1):
  ALSA: usb-audio: Add DJM750 to Pioneer mixer quirk

 sound/usb/mixer_quirks.c | 336 +++++++++++++++++++++++++--------------
 1 file changed, 216 insertions(+), 120 deletions(-)

-- 
2.30.0

