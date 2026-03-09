Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3854EF3719
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:41:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2730460258;
	Mon,  9 Mar 2026 09:40:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2730460258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773045662;
	bh=0bd4k97VFgTK8uYp9F+D5B/Q9aR8UnsUhyoNiDCLt7k=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ePsGm4J/JE/8a5bMXNlV96y648EQLfhPxKaATCXKdhPdPuTIrpRwVzMZu/fSb9Fje
	 Y60EozKzgUV5NdCLuly9+xAEtmcZMCkU0QFPcUwvMcOBg6/Sb5LxjD5OacLrx+dCdy
	 gN+2sNsHNxb3El+MJoFz71p91UHKWmRF+nojyVtI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9EAAF805EC; Mon,  9 Mar 2026 09:40:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0741CF805E9;
	Mon,  9 Mar 2026 09:40:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 531F6F8001E; Mon,  9 Mar 2026 09:40:20 +0100 (CET)
Received: from mailman (unknown [10.254.200.5])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DFD7F8001E
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2026 09:40:20 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [alsa-devel] MOTU Midi Express XT
From: dcj64832@laoia.com
To: alsa-devel@alsa-project.org
Date: Mon, 09 Mar 2026 08:40:20 -0000
Message-ID: <177304562008.20.15846015012980139598@mailman>
In-Reply-To: 
 <176733414601.20.12467795621587134001@mailman-web.alsa-project.org>
References: 
 <176733414601.20.12467795621587134001@mailman-web.alsa-project.org>
User-Agent: HyperKitty on http://mailman.alsa-project.org/
Message-ID-Hash: 4WZQOM45SNSAQQPUAB44ED7JJLXJ2A6R
X-Message-ID-Hash: 4WZQOM45SNSAQQPUAB44ED7JJLXJ2A6R
X-MailFrom: dcj64832@laoia.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4WZQOM45SNSAQQPUAB44ED7JJLXJ2A6R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This thread on the MOTU Midi Express XT is such a treasure trove of insights! I appreciate how you delved into specific driver challenges; it’s vital for enhancing MIDI workflows. Any thoughts on implementing better error handling? 
https://drivemad3.io
