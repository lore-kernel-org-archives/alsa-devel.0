Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDAAC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jan 2022 16:47:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D13DA1B53;
	Wed, 12 Jan 2022 17:47:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D13DA1B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642006077;
	bh=7Pd6vsKfJgIUVZqRFQffxc1x7NGjwxkh1nlNdQ7lAAk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CeDFkZX5NC1aGx01iOD7/N7iybKwEeTHkBR0IUz54VyNfwd6Ba7rTvOkNWSACpEiw
	 gb1zUAv1Ds/tgR2kZgpVXHYiy22GYy/yO4B2gK2O40mVVMoui5qG0M85b0i3U/fUi2
	 Hf5r4uGRb5XKjMqfYC0fmXjW41kiGR2BDrdfPI4k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6E81F8051F;
	Wed, 12 Jan 2022 17:45:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79770F8026A; Wed, 12 Jan 2022 11:42:52 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90517F800B9
 for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2022 11:42:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90517F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="p6aMaiUf"
Received: by mail-lf1-x136.google.com with SMTP id k21so6763362lfu.0
 for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2022 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:user-agent:references
 :mime-version:content-disposition:in-reply-to;
 bh=3j1Wm1WQHCFUig/uDRHfmIv5SpKzeQw7chJmfSgR5q4=;
 b=p6aMaiUfS2aFhdIKJPAp2V+Fqmt1X+rIAr9B+Tw4cAQ4NP8x/Zj5ahuADz0UcFv0hP
 oq2c9SNmQC7m6l64shXc+g4y4P8vo7bPa6k/ZcjdN+c1Rvt2BfNrtPRdWPo+0NMBSVFw
 /siyfCx6ycstGXvnNgUw2BdK7jtXToYPEXpVpYmiBwDXvp0Oi4T/Y34Q+hiblZ6n7s5N
 B255jnSuCK76xNMMNWVTROkQ9RVT05pZmf6wM9a97+UwkESi5aVwdl3QIm4l2p5Uh+Mt
 W7lczBqwp0ifCOR/QdpdKYlMRVu1++T+dPXB+VPkQfU94vsND7zDkkTq63qN7qbNYo8l
 Odiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
 :references:mime-version:content-disposition:in-reply-to;
 bh=3j1Wm1WQHCFUig/uDRHfmIv5SpKzeQw7chJmfSgR5q4=;
 b=ogyRcjttTQv54OCyspCVElXSf/+g3dEwX4C+opjEryo4yt5+8F0NSYz77l6J3Ggr9l
 9JFFIuhfUeGUkUYfkB/4AH1Tn4Tcco9iPeTBWerfEPL0pIvnf4mxLZGcrlg/SjliMUhu
 ICEAS9rxViASGVWCCSnpRzZIpJf8nrR/j5d1QydLo+4sGak8xUhG715f2csIf/1adjvW
 5+AIDczbLnzIGOK4DgskVEA2qb07lqsqEKJb9i6ybpcSJZ8wCjn//ptZhi8gajYp3ndT
 trDB61Th0plceEk2LK1pFYsu6OGvq9szrGeEr8DjSQUD2kiMEDi06H9Uh8mKuP14rJOy
 4PPA==
X-Gm-Message-State: AOAM5308ymtl1GPNglCyRpcwBm7Df8znx7VTlGlo66NypabcfQ/nKEr2
 aEPMlFRgDLD7ER9IMolAeKQ=
X-Google-Smtp-Source: ABdhPJzuABYWWIrH4rMkTpYkDL8tqn5CpBW1tgufB/0QrijxkPTAcuh6r5G5g8hpT6v3go9dhN08Ig==
X-Received: by 2002:a2e:9245:: with SMTP id v5mr6203793ljg.149.1641984168048; 
 Wed, 12 Jan 2022 02:42:48 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru.
 [95.31.14.149])
 by smtp.gmail.com with ESMTPSA id r6sm1604322lfm.114.2022.01.12.02.42.47
 (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
 Wed, 12 Jan 2022 02:42:47 -0800 (PST)
Date: Wed, 12 Jan 2022 13:48:27 +0300
From: Alexander Sergeyev <sergeev917@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855 G8
Message-ID: <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
User-Agent: mtt
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
 <20220111195229.a77wrpjclqwrx4bx@localhost.localdomain>
 <s5ho84h9tit.wl-tiwai@suse.de>
 <20220112101249.ya73jvpmqmeh4ggg@localhost.localdomain>
 <s5hilup9s87.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <s5hilup9s87.wl-tiwai@suse.de>
X-Mailman-Approved-At: Wed, 12 Jan 2022 17:45:04 +0100
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, Jeremy Szu <jeremy.szu@canonical.com>,
 Huacai Chen <chenhuacai@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 tiwai@suse.com, Hui Wang <hui.wang@canonical.com>,
 PeiSen Hou <pshou@realtek.com>, Jian-Hong Pan <jhp@endlessos.org>
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

On Wed, Jan 12, 2022 at 11:13:44AM +0100, Takashi Iwai wrote:
>Sounds like some timing issue, then. It's pretty hard to debug, unfortunately.

I can imagine. Is it possible that initcall_debug logs could help? Or is it 
timing issues within the same module?

>You may try to get the codec proc dump with COEF by passing 
>snd_hda_codec.dump_coef=1 module option for both working and non-working 
>cases.
>You can unbind and re-bind the PCI (HD-audio controller) device via sysfs.

I'll try both options later today when able, thank you!
