Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8B4C4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Dec 2022 23:51:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA29D23F3;
	Sat, 10 Dec 2022 00:50:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA29D23F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670629904;
	bh=6ADqzSk5+6eO2WYnoBg2WWluUV1JBAFlhL7jg4fVFXE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txPubm9kPFZ0mawhPfuykG3ZgmDADTXd0Eva424CkGWqDopYJWclYlxL1iHagbMEb
	 KetCZ4xFeRawpjlnmiA2oLDUs6/M0/HXwh2Ohez/2HKDMIcxkycef3SHomA8gMTESL
	 zOvodop8H57TAl67ki7L44ME85y2hnbvX2bUPDWg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86600F8024C;
	Sat, 10 Dec 2022 00:50:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13E84F8024D; Sat, 10 Dec 2022 00:50:53 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 91604F8016E
 for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2022 00:50:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91604F8016E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1670629851068506956-webhooks-bot@alsa-project.org>
References: <1670629851068506956-webhooks-bot@alsa-project.org>
Subject: Sound is pitched and slowed down when going through the sound card of
 a mixer controller
Message-Id: <20221209235053.13E84F8024D@alsa1.perex.cz>
Date: Sat, 10 Dec 2022 00:50:53 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-firmware issue #7 was opened from mYnDstrEAm:

First of all I'm not sure if that's a bug in ALSA and if so if this is the right repo to file it.

When I connect my mixer to my Debian11/KDE machine the sound is slowed and pitched down. Sometimes it takes days or weeks until this effect occurs, most of the time everything works well and I don't know what causes this to occur.

**See https://unix.stackexchange.com/questions/572895/linux-sound-is-pitched-and-slowed-down-when-going-through-the-sound-card-of-a-mi (and comments below)**

`aplay -l` says the driver is module-alsa-card.c. The track is still pitched down when played with `aplay`.

I'm not sure if the sound really is slowed down or if it was changed in a slightly different way in the past (had this bug for years now), but right now when I use my mixer rather than internal audio, the sound is lower in pitch. Let me know if there's something I could check like something in some logs.

Issue URL     : https://github.com/alsa-project/alsa-firmware/issues/7
Repository URL: https://github.com/alsa-project/alsa-firmware
