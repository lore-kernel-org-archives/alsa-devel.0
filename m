Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0BCC10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:26:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A3520753
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S0nBltHB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jEevfKwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A3520753
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B5A016ED;
	Wed, 18 Mar 2020 18:25:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B5A016ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584552403;
	bh=pdAdtCwYZs56MlwbHhTb/BuUqJsvNui7EdPn/d8vBv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S0nBltHBssFlsnJZ1dKvbhG20UEg3YZw0soDafiCoClg9iqW8Or3ujsEMiAIIHfjE
	 BxcLqNuxpcTGA/wyFb5XdnIe3m0mfMOvlFKoyFy5v9guqWE1bqAc7zCn0TmSh/pIYB
	 YMrPPwDDcw8TZ6R8APmA1TKaMxTu5K2AyFC60mDI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81448F80132;
	Wed, 18 Mar 2020 18:25:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E356EF80139; Wed, 18 Mar 2020 18:25:50 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4B11F800C0
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 18:25:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4B11F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="jEevfKwi"
Received: by mail-qv1-xf2b.google.com with SMTP id a10so13319276qvq.8
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iZfCb3kZa36OPF49liT2U/izzWzPnj+9urYBYIzCtKs=;
 b=jEevfKwioxud5uIuySF8xm4MyQSvxahhaZmCH7sr8MzPGowmdataR2eDlL3uS7ZISX
 TEXdZC51crFWxATZdgcd80GxtKGFQh9V0Zeq8nFIWAAHj7SSA+JeGBnFR7Y8keQ9Xmyn
 QiBIzTgyje4fI/HBPpVlfZkDbMBv92TFTLYhHUEgVbeU6BEaTCX5r+D1aWJRPDGX88UL
 WBJBaeqPHKser8J7i4qhRiU9GiAzoxqQtUX2F+fgEwxFN75m9L4An4LTyHVevJCHygwO
 jLGKE5nz7CfjBbkSHt3yipmVRGLdHsjof3EpZy5xHgQiZ0+VJRHUdmvQ3wgy6ydKb4m3
 5kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iZfCb3kZa36OPF49liT2U/izzWzPnj+9urYBYIzCtKs=;
 b=XzW29Et9AhQIRExDawi07daJR2Dk1hPkCKbaNOPfrf1TGFAg515ykfuRCwjsLl75Wu
 cyxETzQT+4TWzbqw94xb6//gpW90V+DS3QJHrtaqAwFhX46YWhN/hgBPIv63nz3Qa82Q
 p7N5mhvMuIGOIU8PmZZ0VmhENu76TkYVT7sxwnGun5gckLlztuTTRpR1y9aY6GbnjUh5
 xpBrqGTFZAR+um+BnNnZMMGEK0B39rRJzqdH652DKyqTwcrvnqfvBO6F43LzIL7oR2kG
 Y44qCRVfVdNeTR3sm/a3GuG7ei9M5hGlodJgWNWzyDfDx8lNMdbMquOrjLikX6jB6h8T
 J/QA==
X-Gm-Message-State: ANhLgQ1ieJE92WxNiNV8jBCo5Yx17XmBPcmqWNj3Dofk8KtLzzg9Cdwy
 AaQ14VqcnFHRmowEEADwm5Hpk/TgrQO7XSyvdykn1g==
X-Google-Smtp-Source: ADFU+vtUqiPpFIKRV8FrhJQSs9q7MTkXt59wQHVNiMNRZvwAel2Xi+R+Bsqj4hGE2SbMwj1d+wHhCVUUeDLrwGA1G14=
X-Received: by 2002:ad4:4442:: with SMTP id l2mr5348176qvt.198.1584552344292; 
 Wed, 18 Mar 2020 10:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <d974b46b-2899-03c2-0e98-88237f23f1e2@linux.intel.com>
 <20200318171912.GA6203@light.dominikbrodowski.net>
In-Reply-To: <20200318171912.GA6203@light.dominikbrodowski.net>
From: Curtis Malainey <cujomalainey@google.com>
Date: Wed, 18 Mar 2020 10:25:32 -0700
Message-ID: <CAOReqxjmUCGX18y_XW_sjcU2xWha_+wJ7L+SuzJ5ZrOddCfZkw@mail.gmail.com>
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To: Dominik Brodowski <linux@dominikbrodowski.net>,
 Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Keyon Jie <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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

+Ross Zwisler <zwisler@google.com>
Do we have any BDW boards that use the rt286 codec? I can't recall any.
Also I never saw this issue, did you?

On Wed, Mar 18, 2020 at 10:20 AM Dominik Brodowski <
linux@dominikbrodowski.net> wrote:

> On Wed, Mar 18, 2020 at 12:08:24PM -0500, Pierre-Louis Bossart wrote:
> > On 3/18/20 11:20 AM, Dominik Brodowski wrote:
> > > On Wed, Mar 18, 2020 at 10:13:54AM -0500, Pierre-Louis Bossart wrote:
> > > >
> > > >
> > > > > > > While 5.5.x works fine, mainline as of ac309e7744be
> (v5.6-rc6+) causes me
> > > > > > > some sound-related trouble: after boot, the sound works fine
> -- but once I
> > > > > > > suspend and resume my broadwell-based XPS13, I need to switch
> to headphone
> > > > > > > and back to speaker to hear something. But what I hear isn't
> music but
> > > > > > > garbled output.
> > > >
> > > > It's my understanding that the use of the haswell driver is opt-in
> for Dell
> > > > XPS13 9343. When we run the SOF driver on this device, we have to
> explicitly
> > > > bypass an ACPI quirk that forces HDAudio to be used:
> > > >
> > > >
> https://github.com/thesofproject/linux/commit/944b6a2d620a556424ed4195c8428485fcb6c2bd
> > > >
> > > > Have you tried to run in plain vanilla HDAudio mode?
> > >
> > > I had (see 18d78b64fddc), but not any more in years (and I'd like to
> keep
> > > using I2S, which has worked flawlessly in these years).
> >
> > ok. I don't think Intel folks have this device available, or it's used
> for
> > other things, but if you want to bisect on you may want to use [1] to
> solve
> > DRM issues. I used it to make Broadwell/Samus work again with SOF.
> >
> > [1]
> https://gitlab.freedesktop.org/drm/intel/uploads/ef10c6c27fdc53d114f827bb72b078aa/0001-drm-i915-psr-Force-PSR-probe-only-after-full-initial.patch.txt
> >
> > An alternate path would be to switch to SOF. It's still viewed as a
> > developer option but Broadwell/Samus work reliably for me and we have a
> > Broadwell-rt286 platform used for CI.
>
> What do you mean with SOF? And no other ideas on the root cause than a
> tedious bisect?
>
> Thanks,
>         Dominik
>
