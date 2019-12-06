Return-Path: <SRS0=9ZFY=Z4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38308C43603
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Dec 2019 01:47:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A964C2075C
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Dec 2019 01:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EWwLEm+w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RJjJ3wcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A964C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2BAE1662;
	Fri,  6 Dec 2019 02:46:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2BAE1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575596845;
	bh=BHWvHzt2DwUSL+wyLBEKUUnmJ1Q1rWUjpNz1CUcSLag=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EWwLEm+whXA9IBFniu0gnqUy5cF81XLmp0fcypR8zmA7P3rfcrl0Ic2O1V5yB0vzW
	 eWhcd1/T3+vLkEMZXjkO8jFD+IOrtiPJOTNuBkKXxCHeOHarNWQtRhhSE61V1l+oPt
	 RCDuD8WeL48HKmLvYRrz08Y/L2XtYEu3Sa8mP90Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65841F8015A;
	Fri,  6 Dec 2019 02:46:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D1D0F801F8; Fri,  6 Dec 2019 02:46:33 +0100 (CET)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 688BBF800F6
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2019 02:46:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 688BBF800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="RJjJ3wcj"
Received: by mail-qt1-x842.google.com with SMTP id k11so5599485qtm.3
 for <alsa-devel@alsa-project.org>; Thu, 05 Dec 2019 17:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OWbR15S2RfRqJyFwqLxBwXeFj+8GFIYqLV64PVIuJyM=;
 b=RJjJ3wcj14dVHpVkD5y/VdYzM098tUTqND4K28eHNEvwqzNgDGlLTtMxMg+mgKaX/4
 7OF3LV5xDPeoHfeAjJgLpOYgRqmQfbIp3dXN0n2VIOrTsCcKcU2lTqY4hgBXCQw0J9qB
 5YYmz3wH/uXzQ4bzWY7fIZi1zrLpd1byzeYLWojHxkKd0bvMDfcdP0PYUGqC5ChpELXY
 H0p/tylfLIbnOywoplsQbXpyfBtYCglWp1q95slxGueeo6Jdiv4yA0h7bxIrHt71hAvx
 uDgCD4YBNXUNR2u4Cgl1Nyxs5NjKrDDHoabHUsjCOBvwQvRJ2HscveVyfpHjJfAz7fBN
 +/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OWbR15S2RfRqJyFwqLxBwXeFj+8GFIYqLV64PVIuJyM=;
 b=flwnNaLjbsQmj2lQqziL7tV8d1NIdTXZjv8Rc8K/RTstJRCYLSBIZU03j8yp7/rd4X
 ipcC9MzNqdLjxQ3NbvmKVw7CauAEp1lVyPbBdlkZ012YnhuaDYDCMrjI2Udf5LuJ+YJV
 p0EHphLG2oKPy3s1uyyjhKTLD7ziqbW3nQOcVx2MEd/K3aBxKZhT7xA26K1YGaqNanBQ
 opSjtdc79KcSpzfDmBoOzxSLc3WUot2NqBSzT3ERkkWygbKnPGtDhIvDuC7sJUOe8wMK
 WcKTBjD0Lb4EgUfP6+6opftfgtoqrQfvaVq51kJpFD86KJ62QuVLv1Ku4OkFQrnKavgJ
 T9vQ==
X-Gm-Message-State: APjAAAWad8FNpUWsgptWY+ZAc8hE3xHYyMJ68jshj9Df5zklxrzQN0Cc
 BdWM7tpse8d/HqicXs++sl4rcoRaacCrBn479UggLg==
X-Google-Smtp-Source: APXvYqwtg2K3Mzf77oJxzFBZgf+wjezo+Lbx4VT1iUQsHrH76010514gsaMvd+kVmMBWdRWQNgfWL1295KVZqcbNHME=
X-Received: by 2002:ac8:6f75:: with SMTP id u21mr10913214qtv.52.1575596787983; 
 Thu, 05 Dec 2019 17:46:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOReqxjFaWhYCzzyZ90Pc5EvzUky6kCYqakz2XBwSOii9d3maA@mail.gmail.com>
 <6b310509-212e-b887-5e3a-483a740d2d1c@ab3.no>
 <CAOReqxj3P4Kvf5YwTXoEzHd9hURBOP4ySEjURsO7LjK+vbpQTw@mail.gmail.com>
 <2f0297fa-4aab-b463-4652-208ee77b6cb8@perex.cz>
 <5985f899-82d0-cbb9-9981-1eb9aa5a935d@linux.intel.com>
In-Reply-To: <5985f899-82d0-cbb9-9981-1eb9aa5a935d@linux.intel.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Thu, 5 Dec 2019 17:46:17 -0800
Message-ID: <CAOReqxg2=e0b44Uxj2gfc+4aqKn6OBo6rCX4oGZLBvvpXci8HA@mail.gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 =?UTF-8?Q?Mads_L=C3=B8nsethagen?= <mads@ab3.no>,
 Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] Headset button mapping in the kernel
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

On Tue, Dec 3, 2019 at 4:34 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
>
> >> It appears some have started landing
> >> upstream ae09a4783b9caf9307f303ef039f8297ce0371fe ("ASoC: Intel: Headset
> >> button support in kabylake machine driver") but it would be great if
> >> we had
> >> a way for userspace to configure these buttons similar to how we handle
> >> UCMs.
> >
> > The question why you need to change this settings in the user space. I
> > think that the device tree was designed exactly to describe this hw
> > platform specific settings. Another possibility is to use the kernel
> > module option to configure the settings from the user space. But it's
> > just an idea. You are probably looking for an interface which can be
> > used when the driver is running.
>
> I am also unclear on the ask.
> We've cleaned-up all machine drivers so that the mapping is identical,
> except for the cases where the codec inverts the buttons.
> Are you saying you do an additional remapping of those buttons in
> userpace? If yes, why not fix the machine driver? The mapping is
> typically based on measured impedance, not really something userspace
> should really know about.
This is something we were under the impression upstream did not want.
Dylan can you clarify our stance here? If we can just add the changes
to the kernel then this would be a no-op.
> Or is this a case where the ChromeOS kernel has not yet seen the
> upstream patches?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
