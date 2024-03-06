Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4289C5475B
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:19:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCF0584D;
	Wed,  6 Mar 2024 17:19:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCF0584D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709741985;
	bh=GvHVYUIICAjaOAWJhNYu3ax4WnZhZi/ldWdGTVyeb5c=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Lw6rmOBqBODkr6tuEdOc9WdYqmVpoAx+NTZKZm0zem6cQCH7pTdUCeUupEoGvlSSN
	 QA+PEjypKtp7xE78RqME996y62/pws9/uxh2jyH/7+iTDTCA6GuKbSUC88/kye0KBr
	 dToL6pFsjdQ1qUKF2Uz49X5CdO07StPymXjZUxkM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBE01F80580; Wed,  6 Mar 2024 17:19:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 419D8F8057F;
	Wed,  6 Mar 2024 17:19:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DE925F8024E; Wed,  6 Mar 2024 17:19:07 +0100 (CET)
Received: from omta040.useast.a.cloudfilter.net
 (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5AF2CF80087
	for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2024 17:19:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AF2CF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=embeddedor.com header.i=@embeddedor.com
 header.a=rsa-sha256 header.s=default header.b=w5TNgDer
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id htDQrNog9l9dRhtywrEmMi; Wed, 06 Mar 2024 16:19:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id htyvrwuKjfZ9AhtywrBszK; Wed, 06 Mar 2024 16:19:02 +0000
X-Authority-Analysis: v=2.4 cv=HKXFFJtv c=1 sm=1 tr=0 ts=65e89776
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=CEfcKhwxmaDNtT7VeCoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GvHVYUIICAjaOAWJhNYu3ax4WnZhZi/ldWdGTVyeb5c=; b=w5TNgDer9Gh3Pg1uMCPC6U4Azk
	iBJbZRsqcNsrwgzqGZS5ExHsPTxg2p+pXN1pA6U0hymRTv2UE2FBEuooD43q9C1w1ji+x2IdozLRG
	j98DSEZ2z5+aPB3tCAPRKLawdhcatSmAUhWgV4wYEgKQUbK8ILopk3IP9W/QukMhMYf6TM2SN9pLX
	VjUJdIoEnhdMLILYws+8kA+bbefw2Iy/YfFI8AaG+qWlBF0gmxdhPNwX7s9M22ErXeLYfcOKpXngW
	KduVBPEifkU0VlUISavWQr12Zk1Zd4plnZRt+swKX5eYMejgBU1jWWH6uN2LtOwGoXthGA8WbIcuk
	kHeAbxqQ==;
Received: from [201.172.172.225] (port=49378 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhtyv-001RDq-0D;
	Wed, 06 Mar 2024 10:19:01 -0600
Message-ID: <6a7854af-a183-4db2-8400-4d9eb0cc4308@embeddedor.com>
Date: Wed, 6 Mar 2024 10:18:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net
References: <cover.1709658886.git.gustavoars@kernel.org>
 <20240306011030.GA71684@workstation.local>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240306011030.GA71684@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhtyv-001RDq-0D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:49378
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: 
 MS4xfA/gknJx9hlWefn9y8a40r3oIp9VHzbwHtIq9t4MIhnjButbrLKmH5jjlK16Y3VRRzw1MLvuQRquZmTVDyIHsGr0aOZIZiuxnYqGxqzD9jhl1dIS+fsl
 F/CaI9TtRTHWgd6Kgm3WRs8GrzEx3JPMm3cvPWjgIrTT1mcv+PizRpaQ+y4uhOvNW07ykAB5z9ZrkkTbY6wApq4tbRQK9CIJxAvZrR0GncHFtCmEiJBzPyQq
Message-ID-Hash: MZXWPE7BJ5PGCLFYAVNH2NGO4R4CUP3P
X-Message-ID-Hash: MZXWPE7BJ5PGCLFYAVNH2NGO4R4CUP3P
X-MailFrom: gustavo@embeddedor.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MZXWPE7BJ5PGCLFYAVNH2NGO4R4CUP3P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


> Thanks for the improvements, however we are mostly at the end of
> development period for v6.8 kernel. Let me postpone applying the patches
> until closing the next merge window (for v6.9), since we need the term to
> evaluate the change. I mean that it goes to v6.10 kernel.

Sure, no problem.

Actually, I'll send a v2 with DEFINE_FLEX(), instead.

Thanks
--
Gustavo
