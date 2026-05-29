Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0300CCD6E50
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2026 14:52:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E35B360278;
	Fri, 29 May 2026 16:51:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E35B360278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780066324;
	bh=35ZfURTfDklEE3ulHePr9fHU83/wLTTK+oU58lUlIx0=;
	h=Date:From:To:Subject:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sQ6WaZxVBEZCXBDjydmkBx7KLi6KTaGEohZywTV3qfRGWKeCv4Bj/UU0CMI2JynFi
	 1xet0w0RntD0fMeUKfo701iDrkWC91A/olcsjBpInttn5fcwHyhovO9bRjMAr3FrXT
	 FbzNwT/+9omyuz7AWWYWAzrG1KK5aJaXYJyxA7nA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C790F805EE; Fri, 29 May 2026 16:51:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CDA7EF805F2;
	Fri, 29 May 2026 16:51:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AD26F804D6; Fri, 29 May 2026 16:51:24 +0200 (CEST)
Received: from bumble.maple.relay.mailchannels.net
 (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4426AF8003C
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2026 16:51:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4426AF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=mungewell.org header.i=@mungewell.org
 header.a=rsa-sha256 header.s=default header.b=MLlRGUUS
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 643804E3502
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2026 14:51:14 +0000 (UTC)
Received: from barmail4.idig.net (trex-green-5.trex.outbound.svc.cluster.local
 [100.101.167.230])
	(Authenticated sender: idigitalinternetinc)
	by relay.mailchannels.net (Postfix) with ESMTPA id DC1B34E34A4
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2026 14:51:13 +0000 (UTC)
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MailChannels-Auth-Id: idigitalinternetinc
X-Reaction-Industry: 2d47587562842061_1780066274142_3745684064
X-MC-Loop-Signature: 1780066274142:25783500
X-MC-Ingress-Time: 1780066274142
Received: from barmail4.idig.net (barmail4.idig.net [104.36.151.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.167.230 (trex/7.1.5);
	Fri, 29 May 2026 14:51:14 +0000
Received: from cwh28.canadianwebhosting.com (cwh28.canadianwebhosting.com
 [66.85.29.119]) by barmail4.idig.net with ESMTP id ZLc4ZsYasPoc22l0
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO) for
 <alsa-devel@alsa-project.org>; Fri, 29 May 2026 07:51:10 -0700 (PDT)
X-Barracuda-Envelope-From: simon@mungewell.org
X-Barracuda-Effective-Source-IP: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Apparent-Source-IP: 66.85.29.119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mungewell.org; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:To:From:Date:MIME-Version:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/aT9VY7zXV3uKklP/Z7HrOOOnqYw/HQTPxMDliIvvyc=; b=MLlRGUUS4udr8wforRnYpyWSaB
	x4RzL55P05rpbT+8oCuVLBF6hJUK1Yw4alAPOBdGPxBOYae7m/qyVlvLuVMziX8QzWhEfyFZcfEs5
	7quwZLN/MXGgEy5MP19O2ewRurN+2VLhnV8kYBduqTNj5oBi7CKObrrJiHrz9k9Nf7wsxZlJKF+LB
	1sUpzYMFfD8UavJ816K2MofsvVCNHZZn4d8/BsI3hhGohMUk999g3fBZHF5IEq3dkpk9ykwbneN8W
	mm47FJrMbmnbpRbfUIb8CkFkQIV2En53zJ5kXG1tphUimEDswrzdQjNOECZEQcpm2mcsB5mJqnh5+
	Ly9n37Dw==;
Received: from [::1] (port=6900 helo=cwh28.canadianwebhosting.com)
	by cwh28.canadianwebhosting.com with esmtpa (Exim 4.99.2)
	(envelope-from <simon@mungewell.org>)
	id 1wSyYL-00000006Ngg-0HMh
	for alsa-devel@alsa-project.org;
	Fri, 29 May 2026 10:51:10 -0400
MIME-Version: 1.0
Date: Fri, 29 May 2026 10:51:09 -0400
From: simon@mungewell.org
To: Alsa Devel <alsa-devel@alsa-project.org>
Subject: Re: M-Audio C600 - SPDIF weirdness
In-Reply-To: <99edd616bb6bb7d20fb8a3ef68b87921@mungewell.org>
X-ASG-Orig-Subj: Re: M-Audio C600 - SPDIF weirdness
References: <99edd616bb6bb7d20fb8a3ef68b87921@mungewell.org>
User-Agent: Roundcube Webmail/1.6.15
Message-ID: <92c943e59c174c93b0d6b35f4b374942@mungewell.org>
X-Sender: simon@mungewell.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AuthUser: simon@mungewell.org
X-Barracuda-Connect: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Start-Time: 1780066270
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://104.36.151.218:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at idig.net
X-Barracuda-Scan-Msg-Size: 1145
X-ASG-Debug-ID: 1780066270-0d2e70729510ec50001-UKjUFf
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
Message-ID-Hash: B3BHEFVBVPJE2WVPK3E7KDIG2S2QHD7Q
X-Message-ID-Hash: B3BHEFVBVPJE2WVPK3E7KDIG2S2QHD7Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B3BHEFVBVPJE2WVPK3E7KDIG2S2QHD7Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2026-05-26 22:13, simon@mungewell.org wrote:
> Hi all,
> In attempting to validate a 'live mixer' application for the C600, I 
> noticed some weirdness I can't explain. This weirdness may indicate an 
> issue with the driver.

I investigated further and came to the conclusion that this is part 
hardware limitation and part user error. I was able to recreate the same 
behavior with the Windows driver/app.

Under Windows (same as Linux) the incoming SPDIF is ONLY heard/usable 
when the clock source is set to 'SPDIF'.

There is a note in the manual that if the clock source is SPDIF and 
there is no incoming SPDIF, the interface will 'magically' switch to 
48KHz. This is actually shown in the Windows app, with a message in the 
Setup GUI.

I believe that this is the source of the clicking, when SPDIF is looped 
back (out->in). Sort of Chicken/Egg situation; interface is not clocked 
so no output, no output means no input so it 'magics' 48KHz clock, which 
causes output which is then seen as a clock input.

Bottom line, looks like no issue with Linux driver - just the hardware 
is a bit quirky.
Simon.

