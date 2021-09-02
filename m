Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20ACC432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 15:23:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136736101A
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 15:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 136736101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D9BD17C7;
	Thu,  2 Sep 2021 17:23:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D9BD17C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630596237;
	bh=E6Wz1P4l5WGvp2F88PDrqzDok5byjhfP+LkT31ypJ2w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n5fd1uqggtlFfYxzjc+aA3aQis0MZMbsRN6pZ2I886yS9SMNwGGoNgWMfEOIOxGD/
	 oBYCoBNqe7jjoKvNleBeEpbzzXiIgBhTsyhmVucdQ8/mL1I+e1ktze2PZqhY3SCPO8
	 OMovCtc4rB1z3qZ9Mjdy2YEk+U9uKk3QrkjHPsyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6895EF804E2;
	Thu,  2 Sep 2021 17:22:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8019F80269; Thu,  2 Sep 2021 17:16:23 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1D08F8020D
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 17:16:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1D08F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qwE320N5"
Received: by mail-ej1-x635.google.com with SMTP id i21so5224280ejd.2
 for <alsa-devel@alsa-project.org>; Thu, 02 Sep 2021 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=s4DzLI53lYMtZaqfXhMaCm/bYg8peNwO+6H09pZqkys=;
 b=qwE320N5vyznN3Gu7Q26QdV3Fw+hHr+p/bz3aAAIp7Sjpwoy2WgQ1r5xaDh+LngkfA
 NUSGe7bzzl1OUHYP5hfb0ESvxzAf01jnk9rr/OwUNc13XFwNlk/vyoB1G+fFiXT8Lw6h
 ORT6HZhxTWbywtLEsvzHRrHVX5GHazMRINqAFhWM0DgSNjt9wGz8Skz+qvwdgzNGb+9+
 D3p3h0vK1cKs8UZYdvHZbj7xY1SN4aogy48DuINBSZHWAUJrrjJ8SQxNTSbmXWCFGleF
 TCBIA8VQQyTy7ZJfU1f3gItDn9B+lsi08TfmOynN325qVsVtAL8dZpai1T5fkk1jvk36
 cJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=s4DzLI53lYMtZaqfXhMaCm/bYg8peNwO+6H09pZqkys=;
 b=uL1GFxPyMRR5LGHpQ38o09q4Ur5zbcgZPOCmaUxQcV4Ta7XYecIKS99gWGYzEQxNY0
 PWfh6XOs2crxtB4o89PcukLcP1uLqykftNW8GBpcl9ibGXSzomosn0V72hpKkEGGtG38
 uObux6GglsOcuhn3rLgvkF0/Rqnw6n95+b7I/kZzDOSQ9zrkkfIKjy4Z2aaSh4jug1sl
 wPKEVwRc208nMRTBgdV6TMtPEwLYA4MovhxAYOreLMAn1VNZWIoZVGU9NloWKms9qs+x
 Rt9PUVmYMYXnGViNDGOr3C63cQIbf3cNw9y1a/JXjUaC7bYxNZ561eqyJSclpFe40zR2
 O7Dw==
X-Gm-Message-State: AOAM530WfixVU20EABq51RE7tEMjpt8Ip9cGzRXhej53fsFf1939yG89
 rC+c0RlkFI/E/6D87QU8Jhg=
X-Google-Smtp-Source: ABdhPJz1s6GNbWTftm7CobRsJqR+q3SP4zM3JUCjWymuszgjCJmWH/xfnx2WIsqZFdJ3EAR4F7ko2A==
X-Received: by 2002:a17:906:8489:: with SMTP id
 m9mr4244252ejx.396.1630595776655; 
 Thu, 02 Sep 2021 08:16:16 -0700 (PDT)
Received: from agape.jhs ([5.171.80.234])
 by smtp.gmail.com with ESMTPSA id n13sm1347598edq.91.2021.09.02.08.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Sep 2021 08:16:16 -0700 (PDT)
Date: Thu, 2 Sep 2021 17:16:11 +0200
From: Fabio Aiuto <fabioaiuto83@gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: config issue with SoundWire mockup device support
Message-ID: <20210902151610.GC1422@agape.jhs>
References: <20210902143632.GA1422@agape.jhs>
 <10bb39d4-2560-4ceb-bf20-fe5a124142cb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bb39d4-2560-4ceb-bf20-fe5a124142cb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 02 Sep 2021 17:22:13 +0200
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, lgirdwood@gmail.com, tiwai@suse.com,
 Nathan Chancellor <nathan@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 broonie@kernel.org, linux-kernel@vger.kernel.org
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

Hi Pierre,

On Thu, Sep 02, 2021 at 10:02:05AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 9/2/21 9:36 AM, Fabio Aiuto wrote:
> > Dear Pierre and all sound developers,
> > 
> > I work for some tests on a Lenovo ideapad Miix 300-10IBY,
> > with fedora 34 workstation intalled on.
> > After having pulled the last changes from staging tree I get
> > the following issue by typing:
> > 
> > $ make olddefconfig
> > 
> > WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
> >   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
> > 	&& EXPERT [=n] && SOUNDWIRE [=y]
> >   Selected by [m]:
> >   - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=m] && SOUND [=m] && !UML
> > 	&& SND [=m] && SND_SOC [=m] && SND_SOC_INTEL_MACH [=y]
> > 	&& SND_SOC_SOF_INTEL_SOUNDWIRE [=m] && I2C [=y] && ACPI [=y]
> > 	&& GPIOLIB [=y] && (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])
> > 	&& (SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES [=y] || COMPILE_TEST [=n])
> > 	&& SOUNDWIRE [=y] && SND_HDA_CODEC_HDMI [=m] && SND_SOC_SOF_HDA_AUDIO_CODEC [=y]
> 
> It's a known issue that was reported and fixed by Nathan Chancellor:
> 
> [PATCH v2] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
> 
> https://lore.kernel.org/alsa-devel/20210802212409.3207648-1-nathan@kernel.org/
> 
> I'll ack the missing patch, thanks for reporting this.
> 

you are welcome,

thanks for fast reply,

fabio
