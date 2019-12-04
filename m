Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCA7C43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 21:40:06 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D262077B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 21:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aC/fw9rY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N+/wtPRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D262077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4612F165F;
	Wed,  4 Dec 2019 22:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4612F165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575495604;
	bh=nKdLdWmbdf2e1I9ncoyOIYH5FXXnjZtY4NLW1MbHfO8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aC/fw9rYg4Ab3Eic/L15uGOp2o7XC+7BZaHssv2czFl1pBjqS7v93gphLcXkjNxae
	 GPPrW8TyYiqNU5w5jEmLwx+T+Qxj+OYFmyzOyp25tJ/V/fUKJ/BCQtk/yczeYx6BhB
	 QJWTLu5bll9/Zh+k/g64Jl3xmqqQ/lSX0ga88ipk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7564F801D9;
	Wed,  4 Dec 2019 22:39:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD061F801EC; Wed,  4 Dec 2019 22:39:11 +0100 (CET)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAA6FF8010F
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 22:39:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAA6FF8010F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="N+/wtPRA"
Received: by mail-qt1-x842.google.com with SMTP id b5so1289528qtt.11
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2019 13:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U+xzPoN+ba5JS/Zo2qPeqfhZxA51N4XmURT9hilULHA=;
 b=N+/wtPRAdT8/Xbr8Yd1PuE60QQgZlVGu5ZhTnO7a414GKq9RpVjaibaeobGoixpGSa
 mVCNUfRgi2/Q1XaO7QWFjci6PbOYrtoCj53k7+DexUXD6WwHRYo4WHh+ETOhoR/aM3N5
 Osx9xppvlbEEe9KdF9n147sYEptWriK8imHUhXmahZEL9Mu9w/4hcfnTVbGBMEC/mmsa
 6ef9Vy76CI0MoL+CylgFmA/SFBMosDYe4uXaBUcItsr2D9d9Jl+q1mAOn9SfJljqYWsb
 d5qgKbGQAgq3eB2Nug/P9JMJYIXfh4HDizH5ACv1L2An6gX3w1s1q26YI7NDPSF2p9mK
 pofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U+xzPoN+ba5JS/Zo2qPeqfhZxA51N4XmURT9hilULHA=;
 b=R+U9c+gees9cm53aWqBI+hF/IUcBZtzXDbkG7FXR9AE49OAk8TDQCbqb1bVPd//3+t
 p8ZbfQfg1ySlnyiJhwJBZctokZu3HK8kEjdUsIuxbXN4duwKqKrk5u2ODyW7TJnTV3FN
 Xlm/U+QKhDCxAx1Su6DIfqmNQIbNtR51XxAaiSXrzApqe1wm3GN5NLuLocl8BVGacDIj
 9Yc2RrTHs/qpdoIKMDhCeZIcRHzrSTvYkJJOiZGtaLqxDUU/fssNuF/61SfmIWDyY3Ak
 lEL+hBilU8kHCjcQ/tCkBycN3cf9gDTk47h5PcHIUSniZumrkMMoorKt2VgXKOcyEpnF
 dxHQ==
X-Gm-Message-State: APjAAAVQaHIqpyxykqr31Mf3SVVa9P63HrEnCZ+yrHpymMF0K4RnAog2
 rpK0CR33syS6q7aqLiXfVshVCyTy6nz7HG0gjXGpXA==
X-Google-Smtp-Source: APXvYqzW4fvPpjYFPPI04xvqrNGkvNKfa18SxOZWLtPFGWaWn0x+M8kiNcTKiQvNzMz6O9Jc/Rs3KDCsjQxHUrbLQJs=
X-Received: by 2002:ac8:6f75:: with SMTP id u21mr5008951qtv.52.1575495546272; 
 Wed, 04 Dec 2019 13:39:06 -0800 (PST)
MIME-Version: 1.0
References: <20191204011118.74217-1-cujomalainey@chromium.org>
 <a828597a-2faa-d672-a6a0-43fcaaa6bca1@linux.intel.com>
In-Reply-To: <a828597a-2faa-d672-a6a0-43fcaaa6bca1@linux.intel.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Wed, 4 Dec 2019 13:38:54 -0800
Message-ID: <CAOReqxiDMfgof9sUgujOzi6cQohWq1Mg-KhjQ7-KoUv5tFM9Xg@mail.gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hui Wang <hui.wang@canonical.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Allison Randal <allison@lohutok.net>, Naveen Manohar <naveen.m@intel.com>,
 Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
 Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>,
 Jon Flatley <jflat@chromium.org>, Bard liao <yung-chuan.liao@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jenny TC <jenny.tc@intel.com>
Subject: Re: [alsa-devel] [RESEND PATCH] ASoC: intel: Add Broadwell rt5650
 machine driver
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

Curtis Malainey | Software Engineer | cujomalainey@google.com | 650-898-3849


On Tue, Dec 3, 2019 at 5:32 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 12/3/19 7:11 PM, Curtis Malainey wrote:
> > From: Ben Zhang <benzh@chromium.org>
> >
> > Add machine driver for Broadwell + rt5650.
>
> Curtis, you may want to take a look at the comments posted on July 22. I
> quickly re-added the obvious ones below.
>
> We can improve this a bit and make it SOF-ready - or at least avoid
> build conflicts.
>
Ah sorry about that, I missed that email and only found the email
requesting which board this was. Yes, let's definitely make this SOF
ready. I will update the patch and send V2 later today.
> >
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
