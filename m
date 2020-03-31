Return-Path: <SRS0=BIX5=5Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E1C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:12:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32B7206F5
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uyuCJxxZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6Svu9Yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32B7206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4354683D;
	Tue, 31 Mar 2020 15:11:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4354683D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585660345;
	bh=uvJBXe/1fKLbNAJZnngR2H1ble9LkRNQIerQekqdres=;
	h=Date:From:To:To:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyuCJxxZaZ6+P2tdi2eAkpv87u3uNy7J9z0fb+GoMZJKfiwn6SCu9cT5Lkj0clgDj
	 FPut8OUc+CJvkfW7EGkdXjx1adjaohUeZ/GBduozC5o89mW7KSQOGeOpqAuoqfiRaf
	 eUYQpKxhLJFyrxofIUjXyOBM4V1HQwDICX8eKwHA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87796F8014F;
	Tue, 31 Mar 2020 15:11:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8CC3F80157; Tue, 31 Mar 2020 15:11:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F32C7F800AA
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 15:11:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F32C7F800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="q6Svu9Yy"
Received: from localhost (unknown [137.135.114.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7390B20757;
 Tue, 31 Mar 2020 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585660285;
 bh=uvJBXe/1fKLbNAJZnngR2H1ble9LkRNQIerQekqdres=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
 b=q6Svu9YyHjBvh9xXbVSt1ZNKUMV9s4yPtHzhEQDmo2EEY+nFtAu32CJaX1zkYvBWP
 q6TLa2xLIIY7JuSWZx7WjahgHZfmEp6NocCSvpkW/gz1r9dXp0hzbVCiZbuw7Yai8B
 PiIbpwruW8khdmwTsUC7wY8ThDHr2zCMv1xcLrkg=
Date: Tue, 31 Mar 2020 13:11:24 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Thomas Hebb <tommyhebb@gmail.com>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/3] ALSA: hda/realtek - Remove now-unnecessary XPS 13
 headphone noise fixups
In-Reply-To: <b649a00edfde150cf6eebbb4390e15e0c2deb39a.1585584498.git.tommyhebb@gmail.com>
References: <b649a00edfde150cf6eebbb4390e15e0c2deb39a.1585584498.git.tommyhebb@gmail.com>
Message-Id: <20200331131125.7390B20757@mail.kernel.org>
Cc: Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 8c69729b4439 ("ALSA: hda - Fix headphone noise after Dell XPS 13 resume back from S3").

The bot has tested the following trees: v5.5.13, v5.4.28, v4.19.113, v4.14.174, v4.9.217, v4.4.217.

v5.5.13: Build OK!
v5.4.28: Build OK!
v4.19.113: Build OK!
v4.14.174: Failed to apply! Possible dependencies:
    1099f48457d0 ("ALSA: hda/realtek: Reduce the Headphone static noise on XPS 9350/9360")
    28d1d6d2f314 ("ALSA: hda - Add model string for Intel reference board quirk")
    a26d96c7802e ("ALSA: hda/realtek - Comprehensive model list for ALC259 & co")
    c0ca5eced222 ("ALSA: hda/realtek - Reduce click noise on Dell Precision 5820 headphone")
    c1350bff69d1 ("ALSA: hda - Clean up ALC299 init code")
    da911b1f5e98 ("ALSA: hda/realtek - update ALC225 depop optimize")

v4.9.217: Failed to apply! Possible dependencies:
    8551914a5e19 ("ALSA: doc: ReSTize alsa-driver-api document")
    9000d69925ac ("ALSA: doc: ReSTize HD-Audio document")
    a26d96c7802e ("ALSA: hda/realtek - Comprehensive model list for ALC259 & co")
    a4caad753f0c ("ALSA: doc: ReSTize HD-Audio-Models document")
    a79e7df97592 ("ALSA: hda - Update the list of quirk models")

v4.4.217: Failed to apply! Possible dependencies:
    34d505193bd1 ("cfg80211: basic support for PBSS network type")
    35eb8f7b1a37 ("cfg80211: Improve Connect/Associate command documentation")
    38de03d2a289 ("nl80211: add feature for BSS selection support")
    819bf593767c ("docs-rst: sphinxify 802.11 documentation")
    8551914a5e19 ("ALSA: doc: ReSTize alsa-driver-api document")
    9000d69925ac ("ALSA: doc: ReSTize HD-Audio document")
    a26d96c7802e ("ALSA: hda/realtek - Comprehensive model list for ALC259 & co")
    a4caad753f0c ("ALSA: doc: ReSTize HD-Audio-Models document")
    ba6fbacf9c07 ("cfg80211: Add option to specify previous BSSID for Connect command")
    bf1ecd210541 ("cfg80211: Allow cfg80211_connect_result() errors to be distinguished")
    e705498945ad ("cfg80211: Add option to report the bss entry in connect result")
    fa44b7ec9bc4 ("ALSA: hda - Update documentation")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
