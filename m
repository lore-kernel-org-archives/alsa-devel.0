Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BF6CD8CA8
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:31:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4AF6601B1;
	Tue,  9 Jun 2026 12:31:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4AF6601B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781001077;
	bh=Y5Gl+1dApwYWXBjQWxuFceHq9cjWaocdV2xDlKwed6c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=r3XS9uSLkjQM+21yFI5KEYIVRZeL6HUxFvv7TSMzanUbpKW2OPKQuHX4zDNg5TtPH
	 HE003Zal6HqGHU75QkIFh2pXf5JdL+XByPaeimBE2kMRRXCTW1haOu67hHIPUeh4xL
	 7MQxRqub8h77QZTfOEDn7NaO/eeC8CihEo6a0fyg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AAE55F805FC; Tue,  9 Jun 2026 12:30:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFAB6F80496;
	Tue,  9 Jun 2026 12:30:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 415CEF80496; Tue,  9 Jun 2026 12:30:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781001032;
	b=Pi5ZpQRusGo1FBH/dbrgrpLT1Q1LE36DQ7eeHnlWZlijyxrk09C/slJucGG5DT7TPDhs
	 E+OYNkY01iDIfK3zaRLbZsYQfQnw5MXQO/4ooRZjuNxdkQ0T+//UVShe2Zfj2obXXFewL
	 uiMCLh67l4J4QBZKgs2chHWjNd5VdenL9YGg6D8iClldCXDGMHlRm2AAPDEnRg5yRQ4ZO
	 A/m5ZGtBvA085/5EVjODX8wbQK/3n5LkodpKsLu5uKyRRztD8c5IkiVbaLuQabdNZ5G7z
	 3llweCFeK0ofHqj75omb3qw7ys8clYD7YDT6F9y+HBBGYNXtLfxlr0lO3xMZ331AiMA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781001032;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Y5Gl+1dApwYWXBjQWxuFceHq9cjWaocdV2xDlKwed6c=;
	b=eVYKtcoUWN8sTrvu1j2Q1TxBvB57cHhc5a8hk7k6VvOpSkfFe00rl7bnPeJVJ2yucG7Z
	 g8fjBIEeTTw6SjD0mLX0yf0RqrW/si0a2oBLAc21KYpsr0Qq5tJn6WIyzZH3e50us3WMu
	 Jo2oNo+03v4lbr/QBObqufCtCxfmOCZ9AD4JacrvskfFBeUndqeLRukphUGUiulzt5isl
	 o4S1G6EQPRSeLqfGCHmgf4HFanftqGTo4TizepbVIhKY5jAu+yp6V5jRgiBnz0y7kHpY6
	 C+h6zbek9xctCSeDhG2sAoL6RkNFKgyq6BH9bokiidLSDopPl5cGIhNl2RNeO23OHbQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E21FF8003C
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 12:30:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E21FF8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b76300673bdf00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
Subject: sof-soundwire: cleanups for codecs with multiple functions
Date: Tue,  9 Jun 2026 12:30:33 +0200 (CEST)
Message-ID-Hash: EIPUP3R7IPGICWUUJ6SCTUFPQRN2KA2Q
X-Message-ID-Hash: EIPUP3R7IPGICWUUJ6SCTUFPQRN2KA2Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EIPUP3R7IPGICWUUJ6SCTUFPQRN2KA2Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #775 was edited from perexg:

The load mechanism assumed only one multi-codec in the system, but  we saw in #774 multiple instances of those codecs (rt1320 and rt713).
    
Make the load mechanism straight:
    
- introduce file variables
- remove shadow variables
- probe multi-codecs separately and modify the file variables
- test for duplicate file inclusion (in both sof-soundwire / HiFi configs)
- merge dmic configs for rt712,rt713 to one file
    
This change also improves filters for speaker/headset/mic init includes.

Link: https://github.com/alsa-project/alsa-ucm-conf/issues/774

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/775
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/775.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
