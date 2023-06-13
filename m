Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F98C7EE2E
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jun 2023 03:23:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF1CD822;
	Tue, 13 Jun 2023 05:23:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF1CD822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686626632;
	bh=RAWjhW0C55yVr6LJRKgKnnT0lel+2nLimHBqXczB4hQ=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SYyHe7fKhgIcp7/VfuFBPXab2gVaaHSZEOkUWmI8D8Cl9pXXVaLVkqBEKv9dO2V7Z
	 siv3kmJRTvZshF5JVaDkl66g25JvDTWgTp+NdyDrBVeHw3VVUrTYo44cU3VZnI2oHz
	 sSJCDjW78rRvkp/m2eHRnIYsTHx2AUeaYNPCjRy0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF23DF80093; Tue, 13 Jun 2023 05:23:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A5DFF80093;
	Tue, 13 Jun 2023 05:23:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 836D3F80093; Tue, 13 Jun 2023 05:22:53 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 527C6F80132
	for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2023 05:22:53 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 36/36] ALSA: docs: Add MIDI 2.0 documentation
From: happy.debugging@gmail.com
To: alsa-devel@alsa-project.org
Date: Tue, 13 Jun 2023 03:22:53 -0000
Message-ID: <168662657328.22.5766111725128743822@mailman-web.alsa-project.org>
In-Reply-To: <20230519093114.28813-37-tiwai@suse.de>
References: <20230519093114.28813-37-tiwai@suse.de>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: GPFF6W2QU4KONLV5S3STHWEOP7TFGOYP
X-Message-ID-Hash: GPFF6W2QU4KONLV5S3STHWEOP7TFGOYP
X-MailFrom: happy.debugging@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GPFF6W2QU4KONLV5S3STHWEOP7TFGOYP/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Endpoint Product ID is a string field and supposed to be unique. It's copied from `iSerialNumber` of the device for USB MIDI.
MIDI.ORG published an updated UMP specification today, dated June 15, 2023. Section 7.1.5 Adds the concept of Product Instance ID. Instead of returning the VID/PID, could this ID be returnedserial instead in the  port data if it is available from the device ?
