Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E046D42BBF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2024 19:33:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B32D162D;
	Tue, 12 Nov 2024 20:33:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B32D162D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1731440017;
	bh=rsruy8KlxmwIbW6DU/UstDoCMIDGTnODhQY2Le7+i40=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qrNtSFSfWaC9zDLOcs8wMd4zQcSajJ4DzOXq+bb6mOfqjMsEsuXCiOkm5KItSZa5e
	 ZTcJbWhymG4fgdS720oXnujqFzXdzrqK1mxfE0kBA0spgQWE+u+tVjJ0w9TwVMb139
	 4ZoaSgK1ECH7AagaziQkOBOFXqwJIuTrZbPqnNoE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C35BF802DB; Tue, 12 Nov 2024 20:33:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E204FF8059F;
	Tue, 12 Nov 2024 20:33:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12AF0F8058C; Tue, 12 Nov 2024 20:33:02 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 7202CF802DB
	for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2024 20:33:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7202CF802DB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1731439980438632250-webhooks-bot@alsa-project.org>
References: <1731439980438632250-webhooks-bot@alsa-project.org>
Subject: ALC4082 - ASRock X870 Steel Legend
Message-Id: <20241112193302.12AF0F8058C@alsa1.perex.cz>
Date: Tue, 12 Nov 2024 20:33:02 +0100 (CET)
Message-ID-Hash: ZUC2LFVGZ2RGP4FFDZKL7RB6BN6FU2FS
X-Message-ID-Hash: ZUC2LFVGZ2RGP4FFDZKL7RB6BN6FU2FS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZUC2LFVGZ2RGP4FFDZKL7RB6BN6FU2FS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #462 was edited from cybik:

| Following up on | Relevant PRs | Related issues |
| ------------------| ---------------- | ---------------- |
| https://github.com/alsa-project/alsa-ucm-conf/issues/334 | https://github.com/alsa-project/alsa-ucm-conf/pull/461 | #434 |

### Problem statement

The card "works", but there is one feature missing - though I hesitate to call it "critical": S/PDIF / TOSLINK support is incomplete.

While sound works "fine" (ish), it's limited to 2 channels.
* Plugging in another USB device (CM106-type, for example) gives out a plethora of configuration options (per the screenshot), though this also comes with having to select the right output
* The "USB" audio outs are output-specific, which is VERY welcome, but the S/PDIF out does not allow for any advanced selection like "Supported Codecs", and the HiFi 5.1 and 7.1 do not appear to enable any IEC958/AC3 support in the background

Is there something missing in the config files to allow for such support?

### Relevant files & the such

* [alsa-info info dump](https://github.com/user-attachments/files/17721762/alsa-info.txt)
* Screenshot of the other USB device
    * ![image](https://github.com/user-attachments/assets/906ea829-0210-49a8-ba16-ad1b5b1285ae)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/462
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
