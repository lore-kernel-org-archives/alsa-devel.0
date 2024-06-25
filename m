Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D525C2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:29:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C754299A;
	Mon,  1 Jul 2024 14:29:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C754299A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719836996;
	bh=aU9yu3jhd+Ijxy3kvT2inHaHF4UAcqPAbxmU2Ulra/I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=EbgprgfRhDoZ1zH/4d0IqCwNeUaH4IOwfyFY8ld1ws44gKheMgzhAv2Px7F1917Xv
	 utzW/hsvHqleqLEcRAGmiEs0zfFv3rvejYJvfFm29di+rrlGwmERLNE219pQtNGOKo
	 KQZgfCz2mlKb1d5v45DwoSGIcXSo22hbg1PksC3k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29569F80CBF; Mon,  1 Jul 2024 14:21:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D45AF89878;
	Mon,  1 Jul 2024 14:21:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1E02F80495; Tue, 25 Jun 2024 10:13:25 +0200 (CEST)
Received: from mail78-66.sinamail.sina.com.cn (mail78-66.sinamail.sina.com.cn
 [219.142.78.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 69B00F80154
	for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2024 10:13:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69B00F80154
Received: from unknown (HELO zy-virtual-machine.localdomain)([116.227.101.59])
	by sina.net (10.75.30.239) with ESMTP
	id 667A7C0800028DC6; Tue, 25 Jun 2024 16:12:59 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 5AAC5B7976A443A092514045171235A9
X-SMAIL-UIID: 5AAC5B7976A443A092514045171235A9-20240625-161259
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH 2/4] ASoC: codecs: ES8326: codec can't enter suspend issue
Date: Tue, 25 Jun 2024 16:12:56 +0800
Message-Id: <20240625081256.2941-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: JUNAOLE5SGL2YU64EZNR46R4URZG7T4Y
X-Message-ID-Hash: JUNAOLE5SGL2YU64EZNR46R4URZG7T4Y
X-Mailman-Approved-At: Mon, 01 Jul 2024 12:21:44 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JUNAOLE5SGL2YU64EZNR46R4URZG7T4Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> > When widgets "MICBIAS1" and "MICBIAS2" are active, the codec cannot 
> > enter suspend mode. So we removed these two widgets.We replaced 
> > enable_micbias and disable_micbias with regmap_update_bits to make 
> > sure the codec can enter suspend mode.
> 
> Should mark the widgets with snd_soc_dapm_ignore_suspend() to allow the device to suspend with the widgets enabled.

Thanks for your advice. But unfortunately codec didn't enter suspend after marking 
the widgets with snd_soc_dapm_ignore_suspend(). We will modify the trigger conditions 
for enable_micbias and disable_micbias to solve this issue
