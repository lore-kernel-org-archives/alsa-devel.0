Return-Path: <SRS0=kuM/=QB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F693C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Nov 2021 20:58:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB54361152
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Nov 2021 20:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB54361152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34EDC1666;
	Sun, 14 Nov 2021 21:57:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34EDC1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636923485;
	bh=51YDEvWUJEMpJgVDfpsYhbxdah57+kRY1YlkNRhZ65Y=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mkuURhwQH6QGDn+v0oduSP6YxE/KwbPYXwc5OL952xfnGVySGSVx6Crg5SwYBlcIQ
	 RwmcxJMvfK+d63/9cBdfJ8mH054YZLC1sLhmCeSE3ZqudNJrR2ecBWu9wVNw/SQU53
	 0lg0T+QwcA2jNAfLdco0aNIxIuje9B3zqDlK3zuI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEC51F8026D;
	Sun, 14 Nov 2021 21:57:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0906F80272; Sun, 14 Nov 2021 21:57:10 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38ECCF80134
 for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2021 21:57:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38ECCF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="nDQ/Swpt"
Received: by mail-ed1-x534.google.com with SMTP id m20so16733055edc.5
 for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2021 12:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=dzepfwt3zv07T7etZDRv8AvJcJBQF9+61Ogm4HPtYSc=;
 b=nDQ/SwptlgGF+aQar1+eRBGIK5x+8rg0P0R3yiD7lQTzBT7dE80ldY1yK4WcCoevz+
 Iixyd7t2J84JSTDd1NIuOErIg3JZW9yeQv6pJ/9L3/5v1tBw7EdrnZBRR3CfHy/CI/aL
 MH2CMAqRUZKciMTJToVTIPNE437clyoitXUz0LkMTHnzw51ksl0Y5uPhorWccoUazcZQ
 VYLgLT+NLHRpTvBkYhb0cBEbJ7Dw++BDPPmcjzwzOSYs0Trf0f0AfLuLjvep8VwNZVvB
 AclHm2G85KjMoWgXHv5pjidl1Gwvbd4gYdhTb4qKJS4i7D3fdLDmMIjUHyopfl4CrtNQ
 /MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=dzepfwt3zv07T7etZDRv8AvJcJBQF9+61Ogm4HPtYSc=;
 b=AUFns1N8MaLg8eQx0+XVMQ41FAZmDaVPiD/E/I9nl54AeTZcZ7/mhfqYZ6sqQRvYyl
 TpMpWFicld6Ggzd5ko86oEDUKec57bD+I6BiD8PhEWagHXogcWwGt7LYpuRsHxaUPjk9
 nipotzuGJYoc7Nc2k1EE0Ew177PTZDCbS0JBJGrCbdoEeXL6WriDV5rE0LGsv6HI9fWj
 evuqIDmUtznoZy7YQ2IpJjMWB8aYBiZK8pzJh7Dmnwp3GpnmdJ1AO7A0ZnZPn+7jQSFe
 ZOhQgQ+zSiRIAcdSYTRejin8cBKI5gY5YV8l6aqN5XuXBRtfjuj3qPfsSJPZ35fz+eYN
 NwLA==
X-Gm-Message-State: AOAM533+WoEcoitciJ0+/PwrytF/KXe/zVonRHIqiXqYWantzmJiMKaE
 rubfm4i+7AStAWfOHgGOOKxTtr409siFxbIl1iSYmRO018A=
X-Google-Smtp-Source: ABdhPJyKenMD0CsgJ84Kpi7goraExVpf1ZKKjsv1Mbfq3VsfmOnDLmSBWPKG1zbYfC+e5vHN9UxPQRPMtC+WS500ISg=
X-Received: by 2002:a17:907:2454:: with SMTP id
 yw20mr9025309ejb.428.1636923422768; 
 Sun, 14 Nov 2021 12:57:02 -0800 (PST)
MIME-Version: 1.0
From: Lucas <jaffa225man@gmail.com>
Date: Sun, 14 Nov 2021 14:56:51 -0600
Message-ID: <CAOsVg8oASKrYST0CR_C5GAd4wcBjKcZkbBSrVdV51oPBTHqqdQ@mail.gmail.com>
Subject: Token to create an account on the wiki
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

I was hoping to add some Edirol/Roland devices to the wiki.  Signing
up at https://alsa-project.org/main/index.php?title=Special:UserLogin&type=signup&returnto=Matrix:Vendor-Roland+Edirol
says ask the mailing list for a token.

Thanks,

  Lucas
