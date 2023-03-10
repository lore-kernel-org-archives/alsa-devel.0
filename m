Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD47C6FA99
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Mar 2023 04:10:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E11E1739;
	Fri, 10 Mar 2023 05:09:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E11E1739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678421440;
	bh=S3U51keiGSFd6hGDtZItogYKV6CIJ+KLSGfIL3fmtD4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=M3u6VPDS7TrDDeDTh4Hbb4Qhv91ndFuzvMZMjb5gIjp+uaqLn8+jk6dWSVJXWDWQD
	 KiirrShk2Y6Eem5cEai6nbdcMh+GZu9CPrjuhArroNyk/w2fKMWGtJTm8lIxA+Efsj
	 vjQEFkTKC2uimrng02lglNb4qDsRiXQyH3+s6pko=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 801ADF8042F;
	Fri, 10 Mar 2023 05:09:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F2F4F8042F; Fri, 10 Mar 2023 05:09:23 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id C28B1F8007E
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2023 05:09:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C28B1F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1678421352939694881-webhooks-bot@alsa-project.org>
References: <1678421352939694881-webhooks-bot@alsa-project.org>
Subject: ALC4080 on ASUS ROG Strix X670E-F Gaming WiFi
Message-Id: <20230310040923.3F2F4F8042F@alsa1.perex.cz>
Date: Fri, 10 Mar 2023 05:09:23 +0100 (CET)
Message-ID-Hash: YWTCDU6MWVWV2W5YFXWKVBHRTDRHDYT4
X-Message-ID-Hash: YWTCDU6MWVWV2W5YFXWKVBHRTDRHDYT4
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YWTCDU6MWVWV2W5YFXWKVBHRTDRHDYT4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #288 was opened from ryanseipp:

`alsa-info` upload here: https://alsa-project.org/db/?f=65f72b36c74700eb82930324f24ec27807c441f2

```sh
$ udevadm info -a -p /sys/class/sound/card3 | grep idVendor -m1
    ATTRS{idVendor}=="0b05"
$ udevadm info -a -p /sys/class/sound/card3 | grep idProduct -m1
    ATTRS{idProduct}=="1a52"
```

Updated `If.realtek-alc4080` to have the following `Regex`:
```
                Regex "USB((0414:a00e)|(0b05:(1996|1a(16|2[07]|52)))|(0db0:(005a|151f|1feb|419c|82c7|a073|a47c|b202|d6e7)))"
```
Rebooted.

S/PDIF output now is able to be properly configured to output sound, whereas before it was not.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/288
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
