Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5700C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:18:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1046420720
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DaxMiGsd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="F0I0EHL/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="lFEsqQQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1046420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73FE416CB;
	Fri,  3 Jul 2020 12:17:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73FE416CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593771507;
	bh=P/6OmDH/rRtalsKmvi+KoSn9jFMJmZFeY5KR1gn6SY0=;
	h=Subject:From:To:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DaxMiGsdqq9di0eIeT3Q36X4/q3X4fR959HC3gGU3wLjtzZtvS8dXX2VHuL0rMZ4w
	 geum0UkNUHZzygMm99+MGS9vRvAZ2EcBv/LigCS++TSlzST2qWfoGjqBfWIV5wh6b3
	 zBchC3thpTlz8+hRzemRxPJlNg3m7uJ603Y+fQ6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00EBEF8020C;
	Fri,  3 Jul 2020 12:17:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2797F80217; Fri,  3 Jul 2020 12:17:35 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 495DAF800E2
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 12:17:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 495DAF800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="F0I0EHL/"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="lFEsqQQl"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 31E62A1F47DC6
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 12:17:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1593771444; bh=P/6OmDH/rRtalsKmvi+KoSn9jFMJmZFeY5KR1gn6SY0=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=F0I0EHL/gjom6C4MmlYSga4LKfYbnh5cEAJVmaQ0WnQRtTlOIhjsN2Bt0RxmLbTwZ
 KsFO/mO1ZT8xNM3KcEIG9utG9/FnbhcYlWt29mpotdS5Q5aU6FdIX3N5A6jzBF4Y7d
 giUIsk7Vn/zCUG0D/VYBMwwhwuTO2Ud9RrQl/h/s=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AkPSon_8iJci for <alsa-devel@alsa-project.org>;
 Fri,  3 Jul 2020 12:17:19 +0200 (CEST)
Received: from [192.168.105.151] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id DF489A1F4395E
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 12:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1593771438; bh=P/6OmDH/rRtalsKmvi+KoSn9jFMJmZFeY5KR1gn6SY0=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=lFEsqQQlWmCDZZKc/TdeqWYeCMjnRd1z5CPkHFcG0z8asH+3YeDsW2ZrpPl4n/hFe
 Z3jsWCMqIrtjT8CsG1pMuuJRbVzyzYixk69Sf5AABrhCOKcGuZYaiivi1Tabs21ebW
 j9FgAiBMHuxZnsUX4TZP2/+7hLv7yz+vh8JTzUpA=
Subject: Re: Ignored USB-audio implicit feedback in kernel 5.8rc3
From: Pavel Hofman <pavel.hofman@ivitera.com>
To: alsa-devel@alsa-project.org
References: <5be78c36-bca0-da9c-43ec-2e2a538948a8@ivitera.com>
 <51a129ba-d74f-bfe3-933c-4805bc87804a@ivitera.com>
 <5bd5efb4-66f0-955c-783e-57aff997028a@ivitera.com>
Message-ID: <a9002e0a-2a89-12c3-77c6-f2b9d51db8f2@ivitera.com>
Date: Fri, 3 Jul 2020 12:17:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5bd5efb4-66f0-955c-783e-57aff997028a@ivitera.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


Dne 02. 07. 20 v 13:28 Pavel Hofman napsal(a):
> 
> 
> Please is the requirement that EP OUT + EP IN implicit feedback data
> must be in the same interface really necessary? If such a requirement
> was dropped, IMO many devices could be removed from the existing
> set_sync_ep_implicit_fb_quirk and many devices would work out of the
> box, 

I am still thinking about the single-interface requirement. If both
endpoints were to be part of a single interface, could they use
different altsettings for different sample lengths for capture and
playback? E.g. to save USB bandwidth when the capture is used only for
implicit feedback - capturing at 16bits, playback at 32bits.

In the quirked XMOS devices the common clock for both directions is
defined by the clock feature, the altsettings for each direction (in
separate interfaces) are used for setting sample length.

Thank you very much for any insight into the issue. IMO not having to
add quirks before a device starts working would be advantageous for all
involved.

Best regards,

Pavel.

