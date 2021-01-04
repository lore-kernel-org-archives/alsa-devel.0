Return-Path: <SRS0=I7Cd=GH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A2EC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 15:05:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FD02076D
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 15:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FD02076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51BA51672;
	Mon,  4 Jan 2021 16:04:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51BA51672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609772708;
	bh=71RHjH4IQa5zuwq4wEpOk/8L9AgS+B+ZSX3ZEM397uI=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WQryaJCouP37YUMUveQW8piWSTZ13dRKXTx+0NM8OJrfGWb0toGc39aUK1zF08Wr4
	 rVt8UvTox/Gy8U3nJKKSVbm+27DK+QazmOf/VEtlZ5FTu+cajHNIEDfIVfD0ST4Mfg
	 n3xan87C77H+k6lt64a3L5Bkqhp3dEGgLMBTsuY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7079F80165;
	Mon,  4 Jan 2021 16:04:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0EDBF80166; Mon,  4 Jan 2021 16:04:15 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54EB7F8012C
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2021 16:04:08 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EA41EA0049;
 Mon,  4 Jan 2021 16:04:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EA41EA0049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1609772648; bh=cStwRWXbeRT6RBa8C4Y0c1+h/rywhLMItXvgyil81ds=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=JUQdsostteFV68gN952kg9kSNfFz0oxOwWYRFmI9Rk6tnHgbAFjIYFwN0zJ9Kcob5
 1CNOK/VlXm/joMF2JSlMN2ymGSnJyy76lWGvDYdF5xn8/lx1GJKaE0bLdJGPpncdRD
 dsYDWDflMTblWd2f5WtGCAatFiJr3QsiHO7SIyRw=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  4 Jan 2021 16:04:03 +0100 (CET)
Subject: Re: [RFC][PATCH v3 1/4] alsa: jack: implement software jack injection
 via debugfs
To: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
 tiwai@suse.de, kai.vehmanen@linux.intel.com
References: <20201228080003.19127-1-hui.wang@canonical.com>
 <20201228080003.19127-2-hui.wang@canonical.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <c847a7a4-9d2f-7991-811f-756ab7af248c@perex.cz>
Date: Mon, 4 Jan 2021 16:04:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201228080003.19127-2-hui.wang@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dne 28. 12. 20 v 9:00 Hui Wang napsal(a):
> We want to perform remote audio auto test, need the audio jack to
> change from plugout to plugin or vice versa by software ways.
> 
> Here the design is creating a sound-core root folder in the debugfs
> dir, and each sound card will create a folder cardN under sound-core,
> then the sound jack will create folders by jack_ctrl->ctrl->id.name,
> and will create 2 file nodes jackin_inject and sw_inject_enable in
> the folder, this is the layout of folder on a machine with 2 sound
> cards:
> $tree $debugfs_mount_dir/sound-core
> sound-core/
> ├── card0
> │   ├── HDMI!DP,pcm=10 Jack
> │   │   ├── jackin_inject
> │   │   └── sw_inject_enable

> +	sound_core_debugfs_root = debugfs_create_dir("sound-core", NULL);

I would just use "sound" directory name here. Why "core" suffix?

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
