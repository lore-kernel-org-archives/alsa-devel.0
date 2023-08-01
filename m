Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1B1C0015E
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Aug 2023 04:30:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54B04820;
	Tue,  1 Aug 2023 06:30:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54B04820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690864252;
	bh=HgwNk8i424sdyrzIQQMCoZUVZOhQhaYc1sTQcIylMTk=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GvVQ59zblqi/amlONtNtrKZ6cjzrPtbATcD+ZNuLfa9eR36kBzmYnFJQAV3hch7dg
	 e+8xHN52QDbU7FeKS3QdN/jt0gR8dYcMeXrQnFVfsQE5YUFiBGsMo43Rkmi72X0mxo
	 kyTrN8BOVOC+NAH/LYkrc+Dr3LnLVDza13Vhilv8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04359F8025A; Tue,  1 Aug 2023 06:29:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76E1FF8025A;
	Tue,  1 Aug 2023 06:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09452F801D5; Tue,  1 Aug 2023 06:28:41 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 099C1F80087
	for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2023 06:28:39 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/7] usb: Add USB MIDI 2.0 Gadget Function Driver
From: "Symbolic Debugger" <happy.debugging@gmail.com>
To: alsa-devel@alsa-project.org
Date: Tue, 01 Aug 2023 04:28:39 -0000
Message-ID: 
 <169086411982.22.10844351304855044996@mailman-web.alsa-project.org>
In-Reply-To: 
 <169080763901.22.11665243983550346032@mailman-web.alsa-project.org>
References: 
 <169080763901.22.11665243983550346032@mailman-web.alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: 2NS4OIOWOSM5BLMZF7EANEAQGWALSAO6
X-Message-ID-Hash: 2NS4OIOWOSM5BLMZF7EANEAQGWALSAO6
X-MailFrom: happy.debugging@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T3NVHZ7MS3XIMLOLOHQMIG7BRG56KDA4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Never mind. Got the notice about 6.6 . Looking forward to see it in 6.5 next or the next merge window.
