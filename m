Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57014C55186
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:16:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76D820724
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Flb9BwSl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLqeK807"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76D820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C870167F;
	Fri, 24 Apr 2020 11:16:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C870167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587719811;
	bh=GiWyPt7yzmACBp+FM5CBU27WrasEL3zEd6YMjPXRRYw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Flb9BwSlF6WA8f97LFkBebtVTJw6FyxZdE0YQKjB6VzxrmQGHnTlCxd5fZbtmb0YV
	 gGe08T0gXciHE2npgZK2GUowpn/Nw+SIswNFdKUGycd0gNg90MC/icQJdzeuOTyF68
	 xY2ap11+m55WrtLaWeqAYgNV/OUqqHMNdcqNIKao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1A88F80116;
	Fri, 24 Apr 2020 11:16:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8AEAF80142; Fri, 24 Apr 2020 11:15:58 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4958F80116
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 11:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4958F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hLqeK807"
Received: by mail-pj1-x1043.google.com with SMTP id e6so3692121pjt.4
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GiWyPt7yzmACBp+FM5CBU27WrasEL3zEd6YMjPXRRYw=;
 b=hLqeK807AIl6oploSr0Ba6ECKM0p7TJKe7Ek3q2RmBD0GalqEqtMmRgxnkTlqcmdzV
 ImxmiB17WCsKRZzUUwf15tdxBIvx8kVfKqvsamdbhlDfruuX1a/rIrojrXzb7AmzvZnw
 L/qkKYRqVsQM5Y6gA907HSjwfpLGR5zddHhtKDXluMyl6xz5DNoWeedHM8EwIj+zJRct
 YGRYb5B6VaHlc00x4WiOwUXXe0lfY6iZ6Zs2FtKP23Al/RAc2TlBD5WToZDRaVsNd0VF
 8JosDlT9ZgqC9CyuqWcb0/7Dh8Wv8VY7VpWPMCNx0aa4cmIudmY0/WbW+98c0jYN39hH
 APeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GiWyPt7yzmACBp+FM5CBU27WrasEL3zEd6YMjPXRRYw=;
 b=eyB5v0lWPOyfJjL9VO9K/lqqab4M6Rz+e6OFxTJ3VQfMQHtj+hmXC+fMN/dKRMHypx
 3f1rMeiwnADkSwnH/opt11b/CuQ3NnikHxMkN3rooM5akUZoldaKl+PBVf0I84SDz/67
 dJzxa1T3jmV/XJlupXQhXkzTP9K015NA8IKUWgchlDCx5bGBX1jJRqBGPlIVsXyXP7wg
 dtbUWWbG2uk/vUTHLIrWgr5WGYTOb/Tc3pC0/ZEwd42IxNy40f+TL3J2b4JL3L2kmXgv
 Z6+LdPXQGpX+bUGEKrX+sISeKjLjC1EUwQ67Vj+mM/Hf0mJnCqRWQl2Z5pTKqo5zR0si
 VgrQ==
X-Gm-Message-State: AGi0PuaJBwb81t2Ks2BctSms4ot0uO9TZ/H7C0CR2r/+ENaKUBPqQCMj
 Kir6geZ8b6LCfDoQl5oj0NI=
X-Google-Smtp-Source: APiQypJMf2vN0y0/aXmoENydAS7xfN3ytEgap8oA8faei9WM71d4PxRiV+783Qla1nkRQ/PT8Su4cw==
X-Received: by 2002:a17:902:8218:: with SMTP id
 x24mr8335621pln.192.1587719748506; 
 Fri, 24 Apr 2020 02:15:48 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 u13sm4301584pjb.45.2020.04.24.02.15.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2020 02:15:48 -0700 (PDT)
Date: Fri, 24 Apr 2020 02:15:33 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Remove the tasklet
Message-ID: <20200424091533.GA8856@Asurada>
References: <1587711246-27226-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587711246-27226-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Fri, Apr 24, 2020 at 02:54:06PM +0800, Shengjiu Wang wrote:
> Remove tasklet for it may cause the reset operation
> can't be handled immediately, then there will be
> endless xrun interrupt.

The reset routine is really long and expensive, so not sure
if it'd be good to do it completely inside HW ISR. Have you
tried to clear xEIE bits to disable xrun interrupts, before
scheduling the tasklet? If that does not solve the problem,
we may go for this change.
