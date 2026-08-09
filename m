Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C238BC5AD7B
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Aug 2026 17:41:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2F5160202;
	Sun,  9 Aug 2026 19:41:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2F5160202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786297298;
	bh=mNdmamWIMlvVu5FQ37Mbm2L9tT08A8nqDUSUPtOVlrI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kyF//Vhgy+/PcsoC+ypGe06zvSY46qI0ZNZs+v7DoSIrhBU9B7KTAon9md7uDGgP9
	 hMbY1EdJOLxH6+XXr2Iin8+oK7LGiD+KqeRNdXxwVD0YSbb7QQe2gjooIr4XpAU5Kr
	 o79xn6wI7/ps1FuAOhg4DXHnoIgjWmw5IVv/CPII=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE3BDF805F2; Sun,  9 Aug 2026 19:41:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 412E5F80600;
	Sun,  9 Aug 2026 19:41:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8EB98F8026A; Sun,  9 Aug 2026 19:40:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786297258;
	b=KkkFsfEOmP5c6BQfznkPJhh02FKmgw4AEyqqjb6ks4lnli1L6d+UNMgIg4aBXlFPyfDZ
	 fghGDtCBjq7L9zEF1VkZBe3v9cc/e6w94EHBeg4T/fZ0db8sONHsgGAitKIWiMmP7Qg5t
	 PmnuFWIVvZnf/gJmjHCp+62F7M9RpOgDQtmnTNudHgy6YzaXrcDeL96rgnBQ1EtlWLv23
	 BpYRRlUJNYZy400rbnuQI+zdfJPul61pi0rZHAzEDm5sshFgCn94vYrossqFDl/L8JgtY
	 u/PFfU6otb/qIMtfl11abdqsOb9JMXssSg7bqz8CgboY93JrFg1itTQ5ndBW1wn7olw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786297258;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=mNdmamWIMlvVu5FQ37Mbm2L9tT08A8nqDUSUPtOVlrI=;
	b=hRwv1KH2vCkViteR2gCA32jj/iAxj4+bkn+nYQlivKGS6pCdNZb9Cp9TJ6BXqwS2cf4+
	 Imzumq/CXQ1G6GqTiL+yQUPQLmaR6Sg9wbIYoFKImmFy1ltkgjBTwUfxYLFQVX05ZucMP
	 Tc3WGV7ph9TNv+tV6+jA2SrGXvV6u/I4LX0kBvzqDsu1ANe7XaYyWr1ID56QgyXpYTalt
	 5VmnWp4fictwwaDIawpLp2Oa+L6UIVFBCkYil15Vb4fFT6UuBiMgWsoOG6a6WzcowtGSD
	 uFh1R5veFlmPHPSXlbT58pUwjmMdy5QxBdo298ojYv8+PAvI7gbZZ3PYswpfrc7L7tA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D074AF80240
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 19:40:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D074AF80240
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ca33e42dde4400-webhooks-bot@alsa-project.org>
In-Reply-To: <18ca33e42db6ad00-webhooks-bot@alsa-project.org>
References: <18ca33e42db6ad00-webhooks-bot@alsa-project.org>
Subject: Dualsense Haptic Feedback broken with UCM profiles
Date: Sun,  9 Aug 2026 19:40:59 +0200 (CEST)
Message-ID-Hash: ZK5XJWFAEAGYQ22PEKQTZZBNWSFFEFKR
X-Message-ID-Hash: ZK5XJWFAEAGYQ22PEKQTZZBNWSFFEFKR
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZK5XJWFAEAGYQ22PEKQTZZBNWSFFEFKR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #828 was opened from Flippy1801:

The current UCM profiles for the Sony DualSense controller (DualSense-PS5.conf and DualSense-PS5-HiFi.conf) use SplitPCM to expose the Headphone and Speaker profiles. It completely breaks vibration in PC games running through Proton/Wine that support it.

The official Sony SDK and Windows API (WASAPI) translated through Wine require raw, exclusive access to the 4-channel audio interface (Analog Surround 4.0) to send low-level haptic data to the controller's actuators.

Because the current UCM config splits this device, PulseAudio/PipeWire no longer exposes the raw 4-channel interface to Wine. The games cannot find the haptic audio output, and advanced vibration features are completely lost.

Steps to Reproduce:
1. Connect a Dualsense controller via USB.
2. Open pavucontrol. Set the controller profile to Direct DualSense Wireless Controller.
3. Launch a game with native Dualsense support via Steam/Heroic/Lutris.
4. Result: No haptic feedback is sent to the controller.

Workaround:
If users manually delete or rename /usr/share/alsa/ucm2/USB-Audio/Sony/DualSense-PS5.conf and DualSense-PS5-HiFi.conf, PipeWire falls back to exposing the controller as an Analog Surround 4.0 Output.
Once the UCM profiles are disabled, Wine successfully routes the 4-channel haptic signal to the gamepad, and Haptics work perfectly.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/828
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
