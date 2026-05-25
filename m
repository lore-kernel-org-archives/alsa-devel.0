Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9667ECD5BC9
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 15:43:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE96D6018E;
	Mon, 25 May 2026 17:42:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE96D6018E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779723789;
	bh=Vz4FGFzasD1ntJ+q7rrUON9RuNwWFA0Yk5uHdTpu/EI=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=agDyT0d4UzoZXrfuOv9HSmT1HSuh3ysVA52VT181RZJMhh13JauQE15gq0kz/NnpX
	 XbeRYmeiRvxQmC2xmGWTJJWmrYwSU6sKbkWjO5pj4tfiyml1/Fr2a/zBJTKcuyFMcK
	 l+6BW1F7TD9widYE/R352VeoXB1nd/PKeJoE6Vbg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53DF0F805F4; Mon, 25 May 2026 17:42:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DE9CF805F3;
	Mon, 25 May 2026 17:42:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5714EF80557; Mon, 25 May 2026 17:42:30 +0200 (CEST)
Received: from seashell.cherry.relay.mailchannels.net
 (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3719EF800C1
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 17:42:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3719EF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=mungewell.org header.i=@mungewell.org
 header.a=rsa-sha256 header.s=default header.b=PKGqKBh4
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A26ED4C1EA1
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 15:42:20 +0000 (UTC)
Received: from barmail5.idig.net
 (100-101-154-23.trex-nlb.outbound.svc.cluster.local [100.101.154.23])
	(Authenticated sender: idigitalinternetinc)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2B78C4C24C2
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 15:42:20 +0000 (UTC)
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MailChannels-Auth-Id: idigitalinternetinc
X-Plucky-Shrill: 0070fc00429b9ad6_1779723740377_1968930350
X-MC-Loop-Signature: 1779723740377:272878986
X-MC-Ingress-Time: 1779723740377
Received: from barmail5.idig.net (barmail5.idig.net [104.36.151.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.154.23 (trex/7.1.5);
	Mon, 25 May 2026 15:42:20 +0000
Received: from cwh28.canadianwebhosting.com (cwh28.canadianwebhosting.com
 [66.85.29.119]) by barmail5.idig.net with ESMTP id nAAK5wGh6dsBOh8n
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO) for
 <alsa-devel@alsa-project.org>; Mon, 25 May 2026 08:42:19 -0700 (PDT)
X-Barracuda-Envelope-From: simon@mungewell.org
X-Barracuda-Effective-Source-IP: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Apparent-Source-IP: 66.85.29.119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mungewell.org; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Se0YQa8SN6IxYjb8WnnXYlNF7Byq19Bc7GK8IbF3CYI=; b=PKGqKBh4eaptO5IYgrUi93pl37
	7ii+Aix+9tWjJ6rJwLTS6llByMFyxwda+WR4+vWRDL8ivV8Q87uSwW7c+CG5I5/298fD5J/7lKH/5
	E6YjPlh95VYj0zoXMuF9uPHmNBIqtVXWnP1Du94eeHuwVVn0lOglIJFw9a+5M5YkzS1yWjIrl16Ir
	8oFzXYZd7kQ/kaMcI+4Pk1kNvsvUmXsc3H6Crs3Xj3CHV3VaHrDFr+KG1KXqnRzdov6G5uFzH6RSD
	h2buoPIk8JKF/ddl7XSrlUzfX4pg0cS7Zlqlz0jlrc01DEjMg0wi3WqxM5PRrFkZycjl1sNCTzuwQ
	y8krVlTA==;
Received: from [::1] (port=33490 helo=cwh28.canadianwebhosting.com)
	by cwh28.canadianwebhosting.com with esmtpa (Exim 4.99.2)
	(envelope-from <simon@mungewell.org>)
	id 1wRXRb-00000005y24-0nRx
	for alsa-devel@alsa-project.org;
	Mon, 25 May 2026 11:42:19 -0400
MIME-Version: 1.0
Date: Mon, 25 May 2026 11:42:18 -0400
From: simon@mungewell.org
To: Alsa Devel <alsa-devel@alsa-project.org>
Subject: MOTU Firewire driver - Measuring used (or available) Isochronous
 Bandwidth
User-Agent: Roundcube Webmail/1.6.15
X-ASG-Orig-Subj: MOTU Firewire driver - Measuring used (or available)
 Isochronous
 Bandwidth
Message-ID: <3d06586868283fb927ae0905accaa25d@mungewell.org>
X-Sender: simon@mungewell.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AuthUser: simon@mungewell.org
X-Barracuda-Connect: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Start-Time: 1779723739
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://104.36.151.219:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at idig.net
X-Barracuda-Scan-Msg-Size: 547
X-Barracuda-BRTS-Status: 0
X-ASG-Debug-ID: 1779723739-13d5ac78de10adc0001-UKjUFf
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
Message-ID-Hash: D5O2735YZCIPAC42D56MBEBD6HOGOA3C
X-Message-ID-Hash: D5O2735YZCIPAC42D56MBEBD6HOGOA3C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D5O2735YZCIPAC42D56MBEBD6HOGOA3C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I am looking at improving the Linux driver for an old MOTU interface 
(896 mk1), as the Windows driver supports disabling the ADAT 
input/output for the purpose of saving bandwidth. I think I have found 
the appropriate controls, but would like to confirm that these do 
in-fact save bandwidth.

Q. how can I measure the used (or alternatively available) bandwidth 
under Linux?

I believe that the different connections should have a peak bandwidth 
of:

4/6 pin - 400Mbps half duplex
9 pin - 800Mbps full duplex

Cheers,
Simon.
