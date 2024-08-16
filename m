Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62385C3DA4A
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Aug 2024 19:34:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F00DE2C00;
	Fri, 16 Aug 2024 21:34:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F00DE2C00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723836882;
	bh=PPUDLNnUS7NmibQ8p+tlGE3GGqDftp8F7ZQdqSEsWGE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sla9ueycwGAyBreYjh+G/pEGiVLQsodjfjiUy5GDycqD01TzgZTCqVEb9TFLV1zXZ
	 TsllhYm9kLXc3m6stVl5GGDzLu/dLwpuV7x9KswTfTIwwvNFt64Y0w8VqodBhvK3Zb
	 lzgQb72yFd87ojKaK1r6vzl7j37hAGqQ58Xro3+k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71E70F805AB; Fri, 16 Aug 2024 21:34:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5B7EF805B1;
	Fri, 16 Aug 2024 21:34:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA197F80423; Fri, 16 Aug 2024 21:33:58 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A235F80107
	for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2024 21:33:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A235F80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1723836834548673868-webhooks-bot@alsa-project.org>
References: <1723836834548673868-webhooks-bot@alsa-project.org>
Subject: ASUS Maximus Z790 Hero (ALC4082) - USB Audio 5.1 speakers assigned
 incorrectly and subwoofer not working
Message-Id: <20240816193358.CA197F80423@alsa1.perex.cz>
Date: Fri, 16 Aug 2024 21:33:58 +0200 (CEST)
Message-ID-Hash: EBPMH5GTEW2R7IDMTAIFFY2SXDS6DLZO
X-Message-ID-Hash: EBPMH5GTEW2R7IDMTAIFFY2SXDS6DLZO
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EBPMH5GTEW2R7IDMTAIFFY2SXDS6DLZO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #437 was opened from Gess79:

I hope I'm correct to post this here. Still new to things Linux.

**Situation**
OS: Kubuntu 24.04
Mainboard = ASUS ROG Maximus Z790 Hero
USB Audio = 0b05:1a53 ASUSTek Computer, Inc. USB Audio
Speakers = Logitech Z906 Surround
Kernel = 6.8.0-40-generic
Alsa version = 1.2.9

**Issue**
The speakers seem to be assigned incorrectly and the subwoofer isn't working. I'm testing the speakers through pulseaudio as follows:

![image](https://github.com/user-attachments/assets/8bf65600-63ad-46cc-af68-d51ab6d4a7e6)

I'm listing the results below in three categories:
- The icon clicked within pulseaudio
- The soundfile played
- The speaker the sound is actually output to

_Icon clicked - Soundfile played - Physical speaker output_
Front Left - Front Left - Front Left
Front Center - Front Center - Rear Left
Front Right - Front Right - Front Right
Rear Left - Rear Left - Front Center
Subwoofer - Rear Center - Rear Right
Rear Right - (nothing) - (nothing)

I've had a lengthy discussion on Reddit but I couldn't find a fix for it so far: https://www.reddit.com/r/linux4noobs/comments/1980uv1/comment/kieqsor/

I'm happy to provide all information necessary to pinpoint the issue and fix it.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/437
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
