Return-Path: <SRS0=XrcS=NS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B9CC432BE
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Aug 2021 04:31:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B5060EAF
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Aug 2021 04:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72B5060EAF
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CB2716C0;
	Fri, 27 Aug 2021 06:30:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CB2716C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630038693;
	bh=rNchozNuilrT3olVmGaUMKW4IELn8N8SXq+zhL2DOuI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQwKDb4LhCW7saJ0uBZ/ogS0J6wRQ7+6++IJwHU4x8tUpiGhUNRX1zf2alt9pMtW6
	 iuJJzlD/tWobQrKdJURtOJRFwvLF9ed0yRbNxrSOaY8xckr4NTqWjn4G3rXhiGWOtK
	 Iistb8OCg20wBi0QSa/YtXna3RILJSV/6eT24ivQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF801F80107;
	Fri, 27 Aug 2021 06:30:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 923C2F80129; Fri, 27 Aug 2021 06:30:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 33209F80054
 for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2021 06:30:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33209F80054
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1630038628002897024-webhooks-bot@alsa-project.org>
References: <1630038628002897024-webhooks-bot@alsa-project.org>
Subject: No cards found in 1.2.5
Message-Id: <20210827043035.923C2F80129@alsa1.perex.cz>
Date: Fri, 27 Aug 2021 06:30:35 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #111 was opened from Tooniis:

On 1.2.4:
```
$ alsaucm listcards
  0: HDA-Intel
  1: SOF
  2: bdw-rt5677
  3: broadwell-rt286
  4: broxton-rt298
  5: bytcht-cx2072x
  6: bytcht-es8316
  7: bytcr-rt5640
  8: bytcr-rt5651
  9: cht-bsw-rt5672
  10: chtmax98090
  11: chtnau8824
    chtnau8824 internal card
  12: chtrt5645
    Intel SoC Audio Device
  13: chtrt5650
    Intel SoC Audio Device
  14: hda-dsp
  15: kblrt5660
  16: skylake-rt286
  17: sof-hda-dsp
  18: sof-soundwire
```
On 1.2.5:
```
$ alsaucm listcards
  list is empty
```
My card's config (snd-soc-apq8096, using DB820c config) isn't being loaded on 1.2.5 as a result and I get no sound. Note that in both cases above, alsa-ucm-conf and alsa-lib are of the same version; as mixing versions causes some other errors (lack of conf.virt.d on alsa-lib 1.2.5 alsa-ucm-conf 1.2.4, and invalid syntax 4 on alsa-lib 1.2.4 with alsa-ucm-conf 1.2.5)

Using Arch Linux ARM.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/111
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
