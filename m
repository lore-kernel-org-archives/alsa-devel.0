Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8607C55162
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Aug 2026 21:03:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2F8E601FD;
	Sun,  2 Aug 2026 23:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2F8E601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785704585;
	bh=Ir+JRFB+CvsA+pl3DswjeNk3k3VQ60OgsQuOnO5U6Vc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=f4wi1iOScsprBxf3v/QLbZlx9C3YKc1lI7gvxMFk8h8VuYxxROAcVch1KhvzRuhvK
	 RkZn9JY7LzNNIX+y9QNZ0xhbDWmI2WNb+zc3BvUyrfjtUcyK/W+I5Mo8lJgBEEmqZS
	 h+39QQO/DSUrQQ4KTkHj1m+oEKEaTlmIJ93YkWVY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8D73F805F8; Sun,  2 Aug 2026 23:02:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 26A09F805F8;
	Sun,  2 Aug 2026 23:02:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBAADF804F3; Sun,  2 Aug 2026 23:02:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785704542;
	b=VU7dNKwbqmpMyDG/W6t46qD5/oF7YjXicFiftxzUhe/dzfEvyXzPMu3BBzbHbo/sG3+s
	 7tpffYhewH0mvy11JQkgQkXTrAVLI9KTCLIEY4B/xRMbfh2IeUFp8GIOjkCedU6OEpxSb
	 r0ZYdUfsHuwLW724OyVNsrjePaqFg8CpXh1XjHK+qm5l5mTuLAcZRkd+S8jjH6uJd6Rmn
	 2Nb3owLS3hrw3tsRYH3YeYwN77qgrOsPq+et6niswj3IfPoR3RwQwMRt3T9+RlqnXJnqG
	 adSZiQrYgFBbfS6CJfEtakcTYqJOJhoQ2vu0GCJRQzItDRknGewnR5PeUdONDzVJf3A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785704542;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Ir+JRFB+CvsA+pl3DswjeNk3k3VQ60OgsQuOnO5U6Vc=;
	b=IJLmRXD8Cy3K6PufVeHaozzjjDFmQNpGyyySGgsgriQVo+uXuoZuc3v4rcUkrkVgFzfY
	 kxPoyZMlYumAMh8B6MH3Lvrt1tqNFJBnQ01dGWOi1i28ISE139XQnvJdJYzF+GLHiJ+mp
	 MTk+gxG1Vp/JtgHRm1aFz8wSK82yIw4HlcOr/43uvagHEnMQuFW+7QPiQejaNtqW9Srxn
	 xyUBQ+AxCErsZvvtDcs+9VHmuAy+4L6fR0B0VmRYK8LYP7j/JIKHLPd7kfa1vMDAINOjG
	 YNHnfY2POiFrmLUZBrHRPT8ypnsQDwUw/D5yDBmEyX9wbDTnP8qlxZtfSKG8kH8u4ag==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FA9BF8024C
	for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2026 23:02:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FA9BF8024C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c818d17ea7ee00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/518@alsa-project.org>
References: <alsa-project/alsa-lib/pr/518@alsa-project.org>
Subject: conf: USB-Audio: Add three more devices to the IEC958 blacklist
Date: Sun,  2 Aug 2026 23:02:22 +0200 (CEST)
Message-ID-Hash: CQ6WT73EKWB2M47NOVRKKTNUANZDY4EW
X-Message-ID-Hash: CQ6WT73EKWB2M47NOVRKKTNUANZDY4EW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CQ6WT73EKWB2M47NOVRKKTNUANZDY4EW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #518 was opened from tonymitchell:

None of these devices has an S/PDIF connector, but each shows up in
GNOME Settings with a non-existent digital profile. Add them to the
list to prevent them from being opened.

  Razer BlackShark V3 Xbox          (USB ID 1532:0a58)
  Logitech BRIO                     (USB ID 046d:085e, capture only)
  Plantronics Blackwire 5220 Series (USB ID 047f:c053)

Signed-off-by: Tony Mitchell <tony.mitchell@live.ca>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/518
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/518.patch
Repository URL: https://github.com/alsa-project/alsa-lib
