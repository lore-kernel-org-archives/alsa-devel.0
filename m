Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50B0C47074
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jan 2024 09:23:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D79CEE6;
	Thu,  4 Jan 2024 10:23:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D79CEE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704360230;
	bh=kWAKk3nloB2r8KYY+fac/aEI7U47DszvlPld13tJ92g=;
	h=Date:Subject:From:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BX+8tGPhsdxQ+wHfl6VsZYou/Y2wMkrMmEYJR1d+WjGsCRk3UaTnLQy/Ux6YT4QV5
	 ifrPoktQrTUqyaxvQx+sGwhYNHK7lMX2f7JWy1lTXDTSUt/vu+PfKoSE0WOr+blWYb
	 0pvuNOIIBB3JUrf0c9sJ8yUNStt8k8gLybx/7SWo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 361FBF805F3; Thu,  4 Jan 2024 10:22:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88298F805F4;
	Thu,  4 Jan 2024 10:22:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEE3FF80224; Tue,  2 Jan 2024 23:56:48 +0100 (CET)
Received: from mail-200162.simplelogin.co (mail-200162.simplelogin.co
 [176.119.200.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1AB84F80051
	for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2024 23:56:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AB84F80051
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=willian.wang header.i=@willian.wang header.a=rsa-sha256
 header.s=dkim header.b=hDZ6dqAk
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1704236204;
	cv=none;
 b=OMmlGsH4M3jv2+97BrEzzp7GCvekezXXgFE0r/Izy1uMSHpmZaSgvX705J7cVovTridDano7CJfF9n0lEXqXKHftwxnw5suRGQ45Y2qRzMfvmnPen4ufycSSNKFX8eD6NBdZsd2PRmE7HrO7q9ZzunvRrtrm1IkQ6n6w+NBpgeieSdbdVS2JLQ90em8SI8vrUyJ2kxvYpBktnLuUeFFtgvL0Gem2Nmh8z4tjqwX5cmvI3tQh5yofbtrkItwszJE8+99UQlW/kKcnrpNFhcw/z23gJ4aLHUwgSzOmG2JeUnQmxfY+O71THPu59mAc3mFH6OCI+DnSKyTN/Rwv7fJoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1704236204; c=relaxed/simple;
	bh=kWAKk3nloB2r8KYY+fac/aEI7U47DszvlPld13tJ92g=;
	h=DKIM-Signature:MIME-Version:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:From:To:Cc:Message-ID:X-SimpleLogin-Type:
	 X-SimpleLogin-EmailLog-ID:X-SimpleLogin-Want-Signing;
 b=VtCjrdRzw47QARSaHBSSElyHVWoiZVBXYu10psgZOlDaX0yOOCvIlA/dvPlnH4AUcVQA+3fSdU/QkPRp6sIHVAtlDjRY6bbOETloce0I3ONghOFscVbn1KprEFZ0VMhujUOj0HAaSMZ24Pm8vROKt32Ac2+FUeg+O07yJVOOZqQnm9mNTBycYdy9qiWPIUjaSJIlXcd2QEOhZ/b+sS9eN8EkTijHvceKcqVv+UmdtXU8Bd3Ca97L0kCDWtH1EixtxhuoYsHVNndlL66nfJ+/gg/oPnbJeJbly8minW3t+RhPLco/tkQz0SDIuK0JhQ1LpUtJazMS5ZnfrdiCfJBVQg==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willian.wang;
	s=dkim; t=1704236204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kWAKk3nloB2r8KYY+fac/aEI7U47DszvlPld13tJ92g=;
	b=hDZ6dqAkxJrIRdTQHVYPkGWrlfTSbj0zhH9W05oJHKmpOW4YEhOBm6d8HpNEUMOgcPXTjc
	RdmQ2YAI9kFA4pdohowWN+V+LbxnHJYzexEcq95AJkXdtv+rj1qlcPyGtK5BT1As3k4Grh
	uKDPcGdeia3V2W9ELwg6SbspVvqbgRI=
MIME-Version: 1.0
Date: Tue, 2 Jan 2024 19:56:03 -0300
Subject: Re: Oops in hdac_hda_dev_probe (6.7-rc7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
From: Willian Wang <kernel@willian.wang>
To: peter.ujfalusi@linux.intel.com
Cc: 
 tiwai@suse.com,regressions@lists.linux.dev,tiwai@suse.de,ranjani.sridharan@linux.intel.com,pierre-louis.bossart@linux.intel.com,perex@perex.cz,linux-sound@vger.kernel.org,linux-kernel@vger.kernel.org,kai.vehmanen@linux.intel.com,lgirdwood@gmail.com,broonie@kernel.org,alsa-devel@alsa-project.org,linux@dominikbrodowski.net
Message-ID: <170423620368.7.11626876748388238508.241693435@willian.wang>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 241693440
X-SimpleLogin-Want-Signing: yes
X-MailFrom: 
 sl.lmysyibsgqytmojtgq2dalbageydknbqge3f2.m6ihuhbe7z2vi@willian.wang
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: QJI5MNOUABZQFTDS3ZIVDM7ETSQJKRV5
X-Message-ID-Hash: QJI5MNOUABZQFTDS3ZIVDM7ETSQJKRV5
X-Mailman-Approved-At: Thu, 04 Jan 2024 09:22:39 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QJI5MNOUABZQFTDS3ZIVDM7ETSQJKRV5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi, just tested the patch and both sound and resume-from-suspend are
working like 6.6 again =F0=9F=91=8D

