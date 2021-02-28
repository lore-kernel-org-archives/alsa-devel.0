Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D27C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:49:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB6664DBA
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB6664DBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helmpcb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21E7216C5;
	Mon,  1 Mar 2021 14:48:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21E7216C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614606580;
	bh=xd+fbJdpQirIRJLJt4qOqF9CVnuBBdqg9PBjZk+nnXw=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FUz6ohuqKukNe4KWVMYLE8jhQkegxtO+YmpQsj6Ud2+7P1bXSlqopP33SJsW9jg3R
	 uua2SNHzcANV51WpKfQ98o3U1+jLq5qGA9qdJsgChHRw5yX4lW32UXzW0AoVRX53pw
	 6b0dgn1p4yXHSMUI/V1bLIN1utsKnS2Kjp9VevkI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82849F80549;
	Mon,  1 Mar 2021 14:43:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55702F8025B; Sun, 28 Feb 2021 20:23:11 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5FA0F8010A
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2021 20:23:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5FA0F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=helmpcb-com.20150623.gappssmtp.com
 header.i=@helmpcb-com.20150623.gappssmtp.com header.b="rRSHeNrk"
Received: by mail-lj1-x232.google.com with SMTP id e2so9688094ljo.7
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2021 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=helmpcb-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=N23p4qZjU4Y60wv7dtAT8z4vK20H44YQT1lWPBFmCMY=;
 b=rRSHeNrknAEsXeEFeIbT6XOSCXmuWCKS27e9SX53ZsSlJIvdzZ6YPRPWXfpTIvYtk/
 JFeO5cNcCOvnIDqDibKF8HEdvOIXQ5yQJb9uEuYOhHUOoFzpfVYP/NJ1NTYOWXvM28cn
 lR5CqfO3yENDFRwmcI/0xNxGekN+fHu+0A7SGw2JpDZTpD3SClECWNX+A1ApAiOfYxKT
 CMjeih7c8ohV+JcqPfaUuVACH2bGoWXdds3K9HIN6cFJWhw+8zOqdwoRqoXbfxDeTgk8
 ki/H8rCxskNFIRuJEm5X+oTVeI0z2Vl3aPOhTPr/NoQ6aSZdLwdaAxnOPqi1KzRtB/8/
 aH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=N23p4qZjU4Y60wv7dtAT8z4vK20H44YQT1lWPBFmCMY=;
 b=RD3R7hg5hUGwBnpL3CJiqbXtyYYzKZM3B3kHnnuS02Z+c3JpynQrrosjBkqn75SO1x
 I7g9Jyfx8+C9DRxqYHyl8eQVR2zyIlvvYJVIhFxheXja/YD2PmfUv86qknXJsMC3SIr9
 /pam3yUnH8wfbJoIl+wZuifoQe9E1VTSxfQqYt4Wb1h5krpqIhpWblA65SGJM36+1mBU
 s9YpH1LOOqzVLXLQuQcN93aMJgheIPQsYHMXWK/uR+xl7ss3yDwoLfw4KpUeCOGxsjjL
 bZlteqTI+m7zhcy7PCbg6iHOframNI/dckkImOsXCCTJ2RsNAKS5mRknrQX6VkvYdLi/
 EVYw==
X-Gm-Message-State: AOAM530aQbqe7qgqvgM8MbxpsAUzN5x+4rDi3NTNX7IS2Umlv07iwDNW
 y3N1m4KWEPekbL07WxOiPWzEHtR/Uj+pKByxn7gJiwc+sAC5Rg==
X-Google-Smtp-Source: ABdhPJxr3amjR5dKDGfJAh99ZIufkiz6Si5cUzrSHHe4s11HEVrvrXeEIRDpU8pppMApKz74AUuSHpIiRu3zYHmFeS8=
X-Received: by 2002:a2e:a413:: with SMTP id p19mr7367708ljn.213.1614540187234; 
 Sun, 28 Feb 2021 11:23:07 -0800 (PST)
MIME-Version: 1.0
From: Amr Bekhit <amr@helmpcb.com>
Date: Sun, 28 Feb 2021 22:22:56 +0300
Message-ID: <CAHmAUHKpOd53mJ_skCWgkbhdUc-FD3sWea2diN2E5K9BwY8HSw@mail.gmail.com>
Subject: Turning an external amplifier on or off when audio is played
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Mon, 01 Mar 2021 14:43:22 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

I'm working with an embedded system that uses the SGTL5000 to play audio.
We have an amplifier connected to the DAC output, which we can turn off
using a GPIO pin. I'd like to automatically enable the amplifier before
playing a sound and disable it after playback has completed. Are there any
hooks that would allow me to do that in userspace? If not, is there
something in kernel-space that would allow me to accomplish this?

Thanks,

Amr
