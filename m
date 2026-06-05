Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA93CD6E74
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:49:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0927A60263;
	Fri,  5 Jun 2026 11:49:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0927A60263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780652967;
	bh=+hXCekjk1RvII+6TW8PVnd1pkt0ROZcePF/FpYads60=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vAmpfC5cu1Vbze07irAgIUVJkYwWL7vw2mw5+98X2RfNT98WDBFRX/yEe0mPaUwqZ
	 rZ53eoUeztAsicmloUAZBnL+ikOFCHWqGks5F24YokmgwXMhqiDIioQpCmXtzD2Xtx
	 go1aK4pPz4qSlYm/IVYjnHwFOKmo6y8ISMOcRbzk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4CF0FF80588; Fri,  5 Jun 2026 11:48:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CDD2F80588;
	Fri,  5 Jun 2026 11:48:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5815F8047D; Fri,  5 Jun 2026 11:48:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780652927;
	b=X0Es6heCbOhKiUY5GilHw4EH7QAk6xeOPcHLHiB7MTwbg46N5Dhs2QtM1j5HTlrVRRZ3
	 pvlcBBiomox2FW+Rc4hEz8e1Bgna98+SKKi24Nsk79BUVXYmkJQmGfxwa8eloN+d4BRVT
	 6bW4FuLgtclXd6X4bafAKYbWBOmarJ/CeoGY/dzPK7KDpodPysXFISVPpiRI+p4XklJJW
	 Qc5OTslKu7LovssnxeDT8qUFELDfVJRXQgsubJvo1o3N1+YbV/wIipsMIhXeKu+yAzYXF
	 Ty9IOdgPR7BqgFHwcPZeyaC8B/c1RjFucvPg4Z0dTCenMiv6kG8kL6k6gc3fGho91eQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780652927;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=+hXCekjk1RvII+6TW8PVnd1pkt0ROZcePF/FpYads60=;
	b=NJpptliCagmv3GmzBmomjVQtypmrLHtEDXXB4BxOox3PhnH7XvltWsYyGbbHl7yTO/pJ
	 eIcR9x0k37QuMYc8jDoYbYtXPHmQSucomrRxEWM9efe7So6AN+c0Pm7b9Fuy16xY/TK9W
	 kVGQLxvKz3QdEGn3EGpcYzw++NEzCp+xAq1W0eT88FMY6n3LY6DwPYAg9LhpDgmHd49Om
	 6IEUrISMGST0RVt0H7agobCxPk6sx46khE4+yIq5AC/qJCPhUopHPf7XRxfnvxuI/CLWl
	 684O79sHnNGrOewFrA3c5lTttiXfD3Y8V9re75N19RbS5lpYyjOrZD+WTv9EtAkX5Aw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DD7F2F800D0
	for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2026 11:48:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD7F2F800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b62666f4d07c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
Subject: sof-soundwire: cleanups for codecs with multiple functions
Date: Fri,  5 Jun 2026 11:48:48 +0200 (CEST)
Message-ID-Hash: URNVKAWQZVNVX4U26H4P4RMPZ54MXD7X
X-Message-ID-Hash: URNVKAWQZVNVX4U26H4P4RMPZ54MXD7X
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/URNVKAWQZVNVX4U26H4P4RMPZ54MXD7X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #775 was edited from perexg:

RT712 - move rt712-dmic to rt712 config (included in If.multi_init and from HiFi.conf)

RT713 - move rt713-dmic to rt713 config (included in If.multi_init and from HiFi.conf)

RT713,RT712,RT722 - do not include files for individual devices when multi codec is detected.

Declare 'MultiHeadsetShadow' variable to be consistent with other shadow variables (Speaker, Mic). Use it for RT712 and RT713 (Headphones/Headset devices).

Link: https://github.com/alsa-project/alsa-ucm-conf/issues/774

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/775
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/775.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
