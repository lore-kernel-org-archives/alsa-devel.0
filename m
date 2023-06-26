Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4945EB64DC
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jun 2023 03:01:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DB3E7F4;
	Mon, 26 Jun 2023 05:00:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DB3E7F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687748489;
	bh=HeWSOg5mDlPzBX2aGQUj46l2pp9LaYnSDGuI/2a0ThQ=;
	h=Subject:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=FVYso3MwtOdp8shQ17ceYCCMF3L3UrPieqRBX2ZEReh89B993rIFHw43oZsKNN+gz
	 hFL+iToztefMkCQcMHlQeljzPi0GCK9afOsNEBFX4NDman39ywEfXpnIz0S46yKEPg
	 kpnI3gQPqCB0cHtW7KUNJveliHqeU5+5tRbZRZyQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25841F8027B; Mon, 26 Jun 2023 05:00:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19606F80093;
	Mon, 26 Jun 2023 05:00:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C897F80246; Mon, 26 Jun 2023 05:00:17 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E01BF80093
	for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2023 05:00:15 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: ALC287 problem
From: ollierazdow@protonmail.com
To: alsa-devel@alsa-project.org
Date: Mon, 26 Jun 2023 03:00:15 -0000
Message-ID: <168774841592.20.9618610493758910911@mailman-web.alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: LJXGGXJO5T43VL22TN5DNMI2DOV5DZML
X-Message-ID-Hash: LJXGGXJO5T43VL22TN5DNMI2DOV5DZML
X-MailFrom: ollierazdow@protonmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LJXGGXJO5T43VL22TN5DNMI2DOV5DZML/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I have a problem with the ALC287 codec that might indicate a missing fix in the Kernel. 
There is digital noise in the output unless I run the command: sudo hda-verb /dev/snd/hwC0D0 0x1d SET_PIN_WIDGET_CONTROL 0x0

I looked through the file /sound/pci/hda/patch_realtek.c and found ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE but it does not affect my hardware. The latest Kernel I tried was 6.1.32.
I'm not familiar enough with how the file is organized to write a patch myself, but If anyone has advice about how to address it I could try.
I wanted to bring alert to this though because it seems like a missing fix.
I also posted here with a bit more detail: https://bugzilla.kernel.org/show_bug.cgi?id=217580
