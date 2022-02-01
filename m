Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9E7C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Feb 2022 13:09:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82729179A;
	Tue,  1 Feb 2022 14:08:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82729179A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643720983;
	bh=Vof91qAUHXkI9pb/nmUgVUIUgu+1lfrk9A3Q1cNGRMc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W+DW9M92KuwpHcY68T3DYNOhUutJ4tcsHuf8yOLGoTe9BkKM3E0xw0+91Z/flVPSs
	 5ffNIdrRfbaUbPpk4QfuKFbI7B3Ma48XL1OIpm8y6C0VUx/ITuiqGlXZLIO0VMEIut
	 Cn4+hF6LvNkODR3WuQvN+XrQBSY+IAaWrhbOWUbY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5008F80089;
	Tue,  1 Feb 2022 14:08:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4455F80311; Tue,  1 Feb 2022 14:08:51 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EC74F8012C
 for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2022 14:08:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EC74F8012C
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:2:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Jp4xl6bCLz9sVN;
 Tue,  1 Feb 2022 14:08:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date: Tue, 1 Feb 2022 13:08:41 +0000 (GMT)
From: kernel@killick.email
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Message-ID: <2007706461.4742.1643720921053@office.mailbox.org>
In-Reply-To: <1714301478.3702.1643720488652@office.mailbox.org>
References: <1714301478.3702.1643720488652@office.mailbox.org>
Subject: No speaker output ALC294 Asus Zephyrus S17 GX701LWS
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

I am having no speaker output on the attached device. Headphones work through jack, but just not the internal speakers. Attached alsa-info. If you need any further information please let me know.
