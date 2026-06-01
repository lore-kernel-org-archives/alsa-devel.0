Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB0FCD5BD1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:34:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9F676021D;
	Mon,  1 Jun 2026 15:34:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9F676021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780320882;
	bh=i7SuN5cHDnQX3dKtL5ibNM8kLpE7QUnMgEjKdc/T4mY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kE8vLQ3eicENGq/uXto9HpGjO9ncSlYs9tEv17TIHdT8T++ArmEjLarJ8sfeIUt0b
	 V8xSltkuGBaUOwQ07iVHi9Vg0dGnIOjucJcaT9+kQTz9u43BOZEybKWZ4CQkN7Osyb
	 V2enPkgHnnRrqxZO6aRrTML0VDjIM3dihw5u8k/g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A1BFF805EC; Mon,  1 Jun 2026 15:34:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E92B6F805F6;
	Mon,  1 Jun 2026 15:34:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97809F805E2; Mon,  1 Jun 2026 15:34:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E51ECF805C2
	for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2026 15:34:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E51ECF805C2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b4f85f35715d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/771@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/771@alsa-project.org>
Subject: ucm2: USB-Audio: add Creative Sound Blaster G8 support
Date: Mon,  1 Jun 2026 15:34:02 +0200 (CEST)
Message-ID-Hash: 6WGA2QA4XXLAIZ5VNA6HI44BZ7QOUL7U
X-Message-ID-Hash: 6WGA2QA4XXLAIZ5VNA6HI44BZ7QOUL7U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6WGA2QA4XXLAIZ5VNA6HI44BZ7QOUL7U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #771 was edited from romain-pereira:

Add UCM2 configuration for the Creative Sound Blaster G8 (USB 041e:329b).

Devices (HiFi verb):
- Headphones: playback via Speaker DAC (hw:${CardId},0, -64 to 0 dB)

- External Mic, Line In, S/PDIF In, What U Hear: capture via hardware mux (PCM Capture Source), mutually exclusive via ConflictingDevice

BootSequence disables hardware monitoring paths (Line In/S/PDIF In Playback Switch are on by default in firmware) and sets External Mic as the default capture source.

Direct verb provided via common/directm.conf macro.

[alsa-info.txt](https://github.com/user-attachments/files/28466909/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/771
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/771.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
