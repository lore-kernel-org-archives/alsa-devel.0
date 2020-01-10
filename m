Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E08C282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 18:34:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BC7206DA
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 18:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tpvaoAEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BC7206DA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D5B316B0;
	Fri, 10 Jan 2020 19:33:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D5B316B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578681254;
	bh=CukM4UTVG/4d0w3pTbgTXtAdnmKNiVeJd68mAGhqq5k=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tpvaoAENo5JbQlRmzDLilZBkN/YCDz2oZ8MvirPuw3NRUJQsCy4r6BDwTnpPu54/h
	 CNoNKxT0lHim4ZyQJF+Qlyb+YtrN4udr5T+rgmbetEUHF62/YhlXc0OPNUavwXs6kf
	 5lnS2Eyv+MfDJ+c5v5wuzbidBc0aUL80jp/rMc5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFDE3F8011C;
	Fri, 10 Jan 2020 19:33:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88490F80130; Fri, 10 Jan 2020 19:33:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CCCBCF800E4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 19:33:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCCBCF800E4
MIME-Version: 1.0
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1578681198128108978-webhooks-bot@alsa-project.org>
References: <1578681198128108978-webhooks-bot@alsa-project.org>
Message-Id: <20200110183321.88490F80130@alsa1.perex.cz>
Date: Fri, 10 Jan 2020 19:33:21 +0100 (CET)
Subject: [alsa-devel] When storing settings which contain a [ or ],
	the setting is not quoted.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #22 was edited from Bertware:

I am using a Raspberry Pi 1 B+ with a Hifiberry DAC+ADC Pro HAT.
This HAT contains a PCM5122 Stereo DAC and an ADC.

 Now to the issue: The ADC has parameters such as `VINR1[SE]` and `VINR2[SE] + VINR1[SE]`. When using `alsactl store` or`alsactl restore`, restoring will fail due to an invalid file.

`ALSA lib conf.c:1887:(_snd_config_load_with_include) _toplevel_:354:30:Unexpected char`

This error points to the parameter `VINR1[SE]`, which is not surrounded by quotes. The other parameters, which also contain other special characters such as spaces, are surrounded by quotes.

An excerpt of the file is included below. This clearly illustrates which names were encapsulated between quotes.

```

control.28 {
                iface MIXER
                name 'ADC Right Capture Source'
                value VINR1[SE]
                comment {
                        access 'read write'
                        type ENUMERATED
                        count 1
                        item.0 'No Select'
                        item.1 VINR1[SE]
                        item.2 VINR2[SE]
                        item.3 'VINR2[SE] + VINR1[SE]'
                        item.4 VINR3[SE]
                        item.5 'VINR3[SE] + VINR1[SE]'
                        item.6 'VINR3[SE] + VINR2[SE]'
                        item.7 'VINR3[SE] + VINR2[SE] + VINR1[SE]'
                        item.8 VINR4[SE]
                        item.9 'VINR4[SE] + VINR1[SE]'
                        item.10 'VINR4[SE] + VINR2[SE]'
                        item.11 'VINR4[SE] + VINR2[SE] + VINR1[SE]'
                        item.12 'VINR4[SE] + VINR3[SE]'
                        item.13 'VINR4[SE] + VINR3[SE] + VINR1[SE]'
                        item.14 'VINR4[SE] + VINR3[SE] + VINR2[SE]'
                        item.15 'VINR4[SE] + VINR3[SE] + VINR2[SE] + VINR1[SE]'
                        item.16 '{VIN2P, VIN2M}[DIFF]'
                        item.17 '{VIN3P, VIN3M}[DIFF]'
                        item.18 '{VIN2P, VIN2M}[DIFF] + {VIN3P, VIN3M}[DIFF]'
                }
        }
```

Creation of the output data and writing it to a file is handled by the save_state method in alsactl: https://github.com/alsa-project/alsa-utils/blob/master/alsactl/state.c#L1539
This code in turn calls snd_config_save in the alsa-lib project: https://github.com/alsa-project/alsa-lib/blob/b20b400e2f598c86abaf697d66396cecd49b3e14/src/conf.c#L3080
Then further to string_print: https://github.com/alsa-project/alsa-lib/blob/b20b400e2f598c86abaf697d66396cecd49b3e14/src/conf.c#L1508
And then in this loop which decides which characters need to be quoted: https://github.com/alsa-project/alsa-lib/blob/b20b400e2f598c86abaf697d66396cecd49b3e14/src/conf.c#L1523

*Proposed solution*
The characters `[` and `]` should be a reason to put text between quotes.
These characters should be added to the switch statement in print_string here:
https://github.com/alsa-project/alsa-lib/blob/b20b400e2f598c86abaf697d66396cecd49b3e14/src/conf.c#L1535

Regards,
Bert

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/22
Repository URL: https://github.com/alsa-project/alsa-lib
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
