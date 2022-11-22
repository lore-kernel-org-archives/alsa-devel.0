Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC64C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Nov 2022 00:37:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2F6415E2;
	Tue, 22 Nov 2022 01:36:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2F6415E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669077462;
	bh=sCuzCUDk3A3XpHAh7z9U2H/eRESzuZ4kg6tX5GKvsoU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fDjqBkYzX1HPO5y03+ZEYzTTi8Uj6HWz8aAn3lGdAqGlUNeNaz5nukztcVOMS8BpC
	 we/Pyt3qBROwTYAkYNAK4dHNT2ubKCgUF2xojjCYnmHvjsWOnnV9UHXmThThDF6iEF
	 qRxNV3do81/Uy/PzA8kD1JAZTRscbOoQRtrDzBA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A2B6F800F3;
	Tue, 22 Nov 2022 01:36:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4463EF8028D; Tue, 22 Nov 2022 01:36:50 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F7C6F800F3
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2022 01:36:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F7C6F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="tmMqxdVA"
Received: by mail-vk1-xa2d.google.com with SMTP id g16so6470685vkl.11
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2022 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jrGE74t7BLz0d/dcRthOBl5c8Ohq1A9oGT2x8kxkMNs=;
 b=tmMqxdVA24Y+ikPAZty6jiRzzqNDFC/gEEQw7i/WFFCEg1W0vVLoHz1nhfuDjxFNiB
 NIMmHcuy20gLA2b+qogNOL/rIjO9cZriF486yjpbkCGRFPd8L7AcU4lMgJKR83Gazu51
 P4SvAF86h414bqZatYMWoNgqRA/WuCdc1AnAYkA/Q6jw5vy3vYv3A8Gxn73JswvXMX5/
 4a+58CGlevLpAZ+kZkIQMY8taFt5/RwIlxKJ467MDItg4mZSqWfCPLrCxzomGV9yoZJc
 kiez7L2lug3STPuJ/fb97nJDPUp0UojB5Glj2pPhPKLSHQ/8jz4tV7huQhgcAlwKilcz
 LgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jrGE74t7BLz0d/dcRthOBl5c8Ohq1A9oGT2x8kxkMNs=;
 b=5MUKaJLvIellbyXMgz5IzgKEgaha5eqcISv3JkzGw8fJL1P16uiJKWD4i9T2AqWNXC
 BmWrvnnbBZM5iq1PqeqP4weUlQt/DhBZXLlVQCttr1wVnQhJucsRo0cOBPVxMUEGudni
 UMz8IWxSnHVdN+6LATc8SJRimPvnNoXcxho5naMKDIOWsCaRlLOPJShb8MM7VaBhS81M
 pVPPrQ/+DrBKBVGt7KFso/+SMgHj63y6P22bSi5nbNyOp0f6wMpNldxa0o5oAVodn1Jg
 NthjPnq6X9BOdkZfDjJlItIO/37+w5m+J3n16hNgKBuawpQMqh8oL1UakLJ6Pp6IXeIu
 LaHA==
X-Gm-Message-State: ANoB5pnIfbYaStPrP07xapLZ3uzzKUEO47Cgsk1Oc/u0SDHUhuCJDMKG
 g0odoxjXhSHQHbyg/+v/EFZ9Ozmr6pTqwjgAR9/u/Q==
X-Google-Smtp-Source: AA0mqf5ibT190KAJ3JtwB1cWSFMYCGXV0zyortiH+VMaXt2UAlOzerbZFfz/g8AzgqB8Bj0Y0XK5PWt/QufOpOn1O7s=
X-Received: by 2002:a1f:5086:0:b0:3b7:5ff7:cfb8 with SMTP id
 e128-20020a1f5086000000b003b75ff7cfb8mr1996498vkb.11.1669077404634; Mon, 21
 Nov 2022 16:36:44 -0800 (PST)
MIME-Version: 1.0
References: <Y3wHyJ/EcsLRHGr3@tora>
In-Reply-To: <Y3wHyJ/EcsLRHGr3@tora>
From: Curtis Malainey <cujomalainey@google.com>
Date: Mon, 21 Nov 2022 16:36:33 -0800
Message-ID: <CAOReqxj+PLCxDpMByfL2A3j-exhHjd5_pKPApnBGo_WKg7o-KA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: avs: Add missing audio amplifier for KBL
To: Alicja Michalska <ahplka19@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, upstream@semihalf.com,
 cezary.rojewski@intel.com, rad@semihalf.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 cujomalainey@chromium.org, lma@semihalf.com
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

On Mon, Nov 21, 2022 at 3:20 PM Alicja Michalska <ahplka19@gmail.com> wrote:
>
> KBL platform is missing the definition of 'max98357a' audio amplifier.
> This amplifier is used on many KBL Chromebooks, for instance variant
> 'nami' of 'Google/poppy' baseboard.

Nami isn't a production device, it was a design, I think you mean "Nautilus"

>         },
> +       {
> +               .id = "MX98357A",
> +               .drv_name = "avs_max98357a",
> +               .mach_params = {
> +                       .i2s_link_mask = AVS_SSP(0),
> +               },
> +               .tplg_filename = "max98357a-tplg.bin",
> +       },

Cezary/Lukasz did we check nautilus? From what I can see in coreboot
it should need this.
