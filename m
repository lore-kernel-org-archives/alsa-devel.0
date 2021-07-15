Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79581C07E96
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 10:21:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271DA613BF
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 10:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271DA613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B80E0167A;
	Thu, 15 Jul 2021 12:20:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B80E0167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626344503;
	bh=S6OpDW7TNRZsWByKnuGvp/DSf4/S1UDpN91AYdX/VnU=;
	h=From:Subject:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oAAUh8M7W7aZXd1zCf1jsbm0z+AYZL9FAEj1Vp5zy/5yAZH6XcpH935klxUHuS7lg
	 LUY1ADt5tFghljlc6FeOI2ZfxeoPK+7T46YKaKkh2pCeaVMuDltKNU4he4n2+xjbif
	 u5X6dYCggo31cnj8OGwJteVldiCNpB6iZrA1WpzA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54B09F8020C;
	Thu, 15 Jul 2021 12:20:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0E52F80217; Thu, 15 Jul 2021 12:20:51 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52546F800D3
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 12:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52546F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="FeWcPG1l"
Received: by mail-pj1-x102d.google.com with SMTP id
 o3-20020a17090a6783b0290173ce472b8aso5854144pjj.2
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=0c0M98GqS4QoBfMDYa+Mw0Q7vATtc9/MXR1xed72h1w=;
 b=FeWcPG1lAYUu3WIf0My0cXXHp16Gs9Q3sHWaTxutlzafsprsG8h4gVOQ0UUweX5VdV
 gTqX3rL7qKqBPbstco9HX8aHLksw35RmNhgfLP/hmdSnrwCesuDBV2Ax+LYgKvozJySQ
 ESN3cC5mtY9+PRLHBZcZwyIXj5Lz+S+GOPgtOTbEJqeG2cj4gkW60ZPicGw01TkPrSMX
 E5z5tDYTjytU0+cD5i6sylaUFk3ap1YJ0PUFYkqHEFdKsWBIBWqhHtfIvPBLC9gGg8Hb
 /AR9EmlULP4YWPUX1YX9mLcpMH/clry/La2LCRavG9ZxddkZlKo33mfyMYT0YA58wKXD
 ooqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=0c0M98GqS4QoBfMDYa+Mw0Q7vATtc9/MXR1xed72h1w=;
 b=H5yQ0jwAZok8lb9lXBl8uwEE4BSwLhIiMPiHNqxAiFmNGTYK4Rg+os6DHTf3BouBqL
 UGPtWpxd8TPrOeML8vaXfGgEX7WlPvdKvDX//ZzyaTn5rm8Km0h7qw5MwBbKBnyuaFeQ
 wrCO1tYyWW/5ufkZm/P/44BX2CYkv5dUzQSNQsgnsX2aRv418nHR4BCEPXTiDJyHi4F8
 9CA8Bpe1eTa5+mZLfekLFGPUVLKq/gGre1XlqnDNCvfTkmua9xlAO58vwRBH3Y4ra66b
 FTnU9U5AgqbK0s9Of6MKA1r4aXJE9xF3L1/sImZYomWvleA7Z6dG/lf0r1ifLeGm5b8h
 fziQ==
X-Gm-Message-State: AOAM5338m42B8P096px9K1au/+XpZ17KFN3Kyx27Xdk89RmNSveTiRjt
 TIkx7ov1M7AvcKE5J0IuUsg=
X-Google-Smtp-Source: ABdhPJy2jKC1wIy3IY6eyCK9pnNyhDoZsiaiRN1V/ykXH1UDW2vRdqDFOIduaSOB8r28siVHMLekpA==
X-Received: by 2002:a17:902:d50a:b029:12b:59a9:9586 with SMTP id
 b10-20020a170902d50ab029012b59a99586mr759156plg.62.1626344440114; 
 Thu, 15 Jul 2021 03:20:40 -0700 (PDT)
Received: from [10.162.0.18] ([45.135.186.83])
 by smtp.gmail.com with ESMTPSA id p40sm6079690pfw.79.2021.07.15.03.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 03:20:39 -0700 (PDT)
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] ALSA: sb16: possible ABBA deadlock in snd_sb_csp_stop() and
 snd_sb_csp_load()
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 "linux-kernel@vger.kernel.org >> linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <7b0fcdaf-cd4f-4728-2eae-48c151a92e10@gmail.com>
Date: Thu, 15 Jul 2021 18:20:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Hello,

I find there is a possible ABBA deadlock in the SB16 driver in Linux 5.10:

In snd_sb_csp_stop():
876:     spin_lock_irqsave(&p->chip->mixer_lock, flags);
882:     spin_lock(&p->chip->reg_lock);

In snd_sb_csp_load():
614:     spin_lock_irqsave(&p->chip->reg_lock, flags);
653:     spin_lock(&p->chip->mixer_lock);

When snd_sb_csp_stop() and snd_sb_csp_load() are concurrently executed, 
the deadlock can occur.

I check the code and find a possible case of such concurrent execution:

#CPU1:
snd_sb16_playback_close
   snd_sb16_csp_playback_close (csp->ops.csp_stop(csp))
     snd_sb_csp_stop

#CPU2:
snd_sb_csp_ioctl
   snd_sb_csp_riff_load
     snd_sb_csp_load_user
       snd_sb_csp_load

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks


Best wishes,
Jia-Ju Bai
