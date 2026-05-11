Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1C3CD484E
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 22:15:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 865AF601A3;
	Tue, 12 May 2026 00:15:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 865AF601A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778537712;
	bh=GUyHyIJrbaU1INDAaJL7XDBJ8+iDjqw4CoywJY5a1cU=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=RNhOiJA43CpJoN654xQq+A4aO1dDUBFERBBLB6N0xDcIp4rI46UyWDxNf3ZzzVwCj
	 l7B8cl9A2hE2mCazZPS1Lcr7W+GuXli/+j2zsVt1FyyuLJHaQlDz7E3srnoUp4Vl+1
	 d6hPPVUMwVjb9qb6q3hOdb5Q72uFdt6f6yYvavXo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2144BF805A1; Tue, 12 May 2026 00:14:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E52CF805F2;
	Tue, 12 May 2026 00:14:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEA77F804CC; Tue, 12 May 2026 00:14:31 +0200 (CEST)
Received: from cross.elm.relay.mailchannels.net
 (cross.elm.relay.mailchannels.net [23.83.212.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DDF9FF8001F
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2026 00:14:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDF9FF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=mungewell.org header.i=@mungewell.org
 header.a=rsa-sha256 header.s=default header.b=jh/dBTVo
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6C870461579
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 22:14:22 +0000 (UTC)
Received: from barmail5.idig.net (trex-green-4.trex.outbound.svc.cluster.local
 [100.98.10.134])
	(Authenticated sender: idigitalinternetinc)
	by relay.mailchannels.net (Postfix) with ESMTPA id 279784614FB
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 22:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778537662;
	b=tFjrdWOQhyYKo9swVbM477O3uRN7gqswRFA1vKQ8W9zPbGAri7+E1sm8CYrt76SANG4wib
	a6VKBBphf/aMpi62PN35jE2O/jL9fmYdXIIQEVOtpAFZ1kYHUb64XkxJSpCxqzIflLti05
	J5JS0kaYYDscf1m6rDMO5ELLSKuY7iWQ+wAZJiszqoTbFxIFohw5pHlXuHkjxRvkzlkLwc
	ANH6kYP+5novjCscAC31rZuNAIHyROJSVmT5QzftAw+5kbErOWVWHxpe7IrHd77pgPJott
	78z4oNuLD5Kc7zJOgkVHPeuKB7823PJdwqBVNNrisvsTYyiKK5gC4Iezbyhnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778537662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=39ZaNMbV/PS7bykzuCrNeJFj+3lGqOFqmgcQ0ckZPtM=;
	b=CsBdfPSqBcpcBLoUVxQiN/fXgPULesNzaAB509UzkxUk6KQ6HJSBZ4/chpYG4LPH5FluCA
	S5anv5dDIXNLYgvNdAJ7MVIpUNpNg4Xd6gncFjexkpSvUk6i3PXemo7+KpPO61QsQa4adw
	OZhZEYH6dkNQ8H0dOCiAqqh+jlZ426xKHH1m/CMkukwd/u+7EAB1ykG4b2eCstkBdZu8a2
	nEGMMwa5GAUek63gyLDctYcrTgXLCInGAjWOXY3uGxyRfsqF7OBSxT9GBpYSXK+BbPLi+M
	ZyDbpWRv6ZMfV3SFSUGL2Wx9o4nuvGtEr1fMSUI4GYjPFi8yss5Y+RDr6Kx4JA==
ARC-Authentication-Results: i=1;
	rspamd-5c5444c55f-rpcwz;
	auth=pass smtp.auth=idigitalinternetinc smtp.mailfrom=simon@mungewell.org
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MailChannels-Auth-Id: idigitalinternetinc
X-Reign-Name: 7f406e1d01c145d3_1778537662354_1567400613
X-MC-Loop-Signature: 1778537662354:1766443213
X-MC-Ingress-Time: 1778537662353
Received: from barmail5.idig.net (barmail5.idig.net [104.36.151.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.10.134 (trex/7.1.5);
	Mon, 11 May 2026 22:14:22 +0000
Received: from cwh28.canadianwebhosting.com (cwh28.canadianwebhosting.com
 [66.85.29.119]) by barmail5.idig.net with ESMTP id LRLDYDUnFskLmoBJ
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Mon, 11 May 2026 15:14:21 -0700 (PDT)
X-Barracuda-Envelope-From: simon@mungewell.org
X-Barracuda-Effective-Source-IP: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Apparent-Source-IP: 66.85.29.119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mungewell.org; s=default; h=Content-Type:Message-ID:Subject:Cc:To:From:Date
	:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=39ZaNMbV/PS7bykzuCrNeJFj+3lGqOFqmgcQ0ckZPtM=; b=jh/dBTVoeslIY8ESrawEIc/mUT
	XMreqmjVnokhiYT16ThhzPVbEyuJqiVic7pGUPl+im4/LjzenQPHVZcDnF/iSepxj1wuAwG9Vd5sJ
	WVaW1/qQJTI95NDtoeVVPgNwKEQskQeWkLMKjfMAdCPMlpfzz46UTkKmYZlqECUDdAaddKeoHmUm8
	xoEnsqElyftqZ4YiBqOZpU/6H7GOzQxlqAzRIgDpiQTkfQiu8/fcN7z7nXtlUFBldS34IKjGlObbC
	me3DT7x16O471kWM2OMqr3oZvaJDo3JjYtEeKD8POYQoPgJ5Uz2nMLif2Hj9gz8kXt+GAAYPPuMqo
	KhldualQ==;
Received: from [::1] (port=35524 helo=cwh28.canadianwebhosting.com)
	by cwh28.canadianwebhosting.com with esmtpa (Exim 4.99.2)
	(envelope-from <simon@mungewell.org>)
	id 1wMYtJ-0000000F2ZU-1XWs;
	Mon, 11 May 2026 18:14:20 -0400
MIME-Version: 1.0
Date: Mon, 11 May 2026 18:14:19 -0400
From: simon@mungewell.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
Subject: snd-firewire-ctl-services: Digidesign Digi-002R - missing control for
 'Optical mode'
User-Agent: Roundcube Webmail/1.6.15
X-ASG-Orig-Subj: snd-firewire-ctl-services: Digidesign Digi-002R - missing
 control for
 'Optical mode'
Message-ID: <f33030cd26a3f65960481e437788a125@mungewell.org>
X-Sender: simon@mungewell.org
Content-Type: multipart/mixed;
 boundary="=_c6d04e9cac18143d47848fa05b7960a5"
X-AuthUser: simon@mungewell.org
X-Barracuda-Connect: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Start-Time: 1778537661
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://104.36.151.219:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at idig.net
X-Barracuda-Scan-Msg-Size: 588
X-Barracuda-BRTS-Status: 0
X-ASG-Debug-ID: 1778537661-13d5ac29ecd2320001-UKjUFf
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No,
 SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=8.0
 KILL_LEVEL=4.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ----------------------
 --------------------------------------------------
	 0.00 NO_REAL_NAME           From: does not include a real name
Message-ID-Hash: PEZSXH6AVRJMGUIAA57AE34IG3OTGDKO
X-Message-ID-Hash: PEZSXH6AVRJMGUIAA57AE34IG3OTGDKO
X-MailFrom: simon@mungewell.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PEZSXH6AVRJMGUIAA57AE34IG3OTGDKO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--=_c6d04e9cac18143d47848fa05b7960a5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

I have noticed that 'snd-firewire-ctl-services' does not provide a 
control for switching the mode of the Optical connections, which can be 
either ADAT or S/PDIF. The Windows/Mac drivers let the user select the 
mode.

It is mentioned in the kernel source, but seemingly not exposed to the 
user:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/firewire/digi00x/digi00x-proc.c?h=v7.1-rc3#n34

Note, when 'Optical S/PDIF' is selected, the 'RCA S/PDIF' connectors are 
disabled.

I have the 002-Rack interface, and can assist with testing,
Simon.
--=_c6d04e9cac18143d47848fa05b7960a5
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=digi_002r_contents.txt
Content-Disposition: attachment;
 filename=digi_002r_contents.txt;
 size=1160

bnVtaWQ9MSxpZmFjZT1NSVhFUixuYW1lPSdjbG9jay1zb3VyY2UnCiAgOyB0eXBlPUVOVU1FUkFU
RUQsYWNjZXNzPXJ3LS0tLS0tLHZhbHVlcz0xLGl0ZW1zPTMKICA7IEl0ZW0gIzAgJ0ludGVybmFs
JwogIDsgSXRlbSAjMSAnUy9QRElGJwogIDsgSXRlbSAjMiAnQURBVCcKICA6IHZhbHVlcz0wCm51
bWlkPTMsaWZhY2U9TUlYRVIsbmFtZT0nZXh0ZXJuYWwtY2xvY2stcmF0ZScKICA7IHR5cGU9RU5V
TUVSQVRFRCxhY2Nlc3M9cnctLWwtLS0sdmFsdWVzPTEsaXRlbXM9NQogIDsgSXRlbSAjMCAnTi9B
JwogIDsgSXRlbSAjMSAnNDQxMDAnCiAgOyBJdGVtICMyICc0ODAwMCcKICA7IEl0ZW0gIzMgJzg4
MjAwJwogIDsgSXRlbSAjNCAnOTYwMDAnCiAgOiB2YWx1ZXM9MApudW1pZD0yLGlmYWNlPU1JWEVS
LG5hbWU9J2xvY2FsLWNsb2NrLXJhdGUnCiAgOyB0eXBlPUVOVU1FUkFURUQsYWNjZXNzPXJ3LS0t
LS0tLHZhbHVlcz0xLGl0ZW1zPTQKICA7IEl0ZW0gIzAgJzQ0MTAwJwogIDsgSXRlbSAjMSAnNDgw
MDAnCiAgOyBJdGVtICMyICc4ODIwMCcKICA7IEl0ZW0gIzMgJzk2MDAwJwogIDogdmFsdWVzPTEK
bnVtaWQ9NyxpZmFjZT1NSVhFUixuYW1lPSdtZXRlcmluZycKICA7IHR5cGU9Qk9PTEVBTixhY2Nl
c3M9cnctLS0tLS0sdmFsdWVzPTEKICA6IHZhbHVlcz1vZmYKbnVtaWQ9NCxpZmFjZT1NSVhFUixu
YW1lPSdtb25pdG9yLWVuYWJsZScKICA7IHR5cGU9Qk9PTEVBTixhY2Nlc3M9cnctLS0tLS0sdmFs
dWVzPTEKICA6IHZhbHVlcz1vZmYKbnVtaWQ9NSxpZmFjZT1NSVhFUixuYW1lPSdtb25pdG9yLXNv
dXJjZS1nYWluJwogIDsgdHlwZT1JTlRFR0VSLGFjY2Vzcz1ydy0tLVJXLSx2YWx1ZXM9MTgsbWlu
PTAsbWF4PTEyOCxzdGVwPTEKICA6IHZhbHVlcz0wLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAs
MCwwLDAsMAogIHwgZEJtaW5tYXgtbWluPS00OC4wMGRCLG1heD0wLjAwZEIKbnVtaWQ9NixpZmFj
ZT1NSVhFUixuYW1lPSdtb25pdG9yLXNvdXJjZS1nYWluJyxpbmRleD0xCiAgOyB0eXBlPUlOVEVH
RVIsYWNjZXNzPXJ3LS0tUlctLHZhbHVlcz0xOCxtaW49MCxtYXg9MTI4LHN0ZXA9MQogIDogdmFs
dWVzPTAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwCiAgfCBkQm1pbm1heC1taW49
LTQ4LjAwZEIsbWF4PTAuMDBkQgo=
--=_c6d04e9cac18143d47848fa05b7960a5--
