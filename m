Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C2DC624DB
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:18:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FD676020B;
	Fri,  4 Sep 2026 04:17:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FD676020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788488285;
	bh=O3pG89wazuz3ViSBEw3G5xyKOKBQuyWz6Z06UVLjiq4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Um4qFIs4QWjdkqDu1GARkxppe8BH/u9akG+We9cWieBORXBL0lldGyVH5w6RTdBqQ
	 dx6b608L6pEFIFCGQn7FvYZWaSO4Hg/ah37tYmpPQJS21OuxryD464IqH7tNujIA/9
	 UHe10LTj6Vgz8Gm3NrrmGWM2jFbVVBZkNdj5CbPk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7879F805FF; Fri,  4 Sep 2026 04:17:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E92E6F805F5;
	Fri,  4 Sep 2026 04:17:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE788F8049C; Fri,  4 Sep 2026 04:17:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788488237;
	b=LZ6QLvc7+Qo3DrDHs/5bI2qiPNurAPw9dYd7vBS0rz3XobNQbYyQpJcyA7xqP26spEGq
	 K0J0SgTugoVn3epFZj6RXLQutmPTODhcDASEcp6xt+3eTgjA4T0DQp8BeFUoMjzVC+GGa
	 c4O8IZskzGsA0y/8wC1swCkzse0ShkhIWdvnpuGWPeIQa5t/s+5fH7ZomY3fdRIMp63NN
	 qZ/dg083WSqsh7hXK+JhpDI5DjufSwu0Udqvltbcm3ApC60NUsb6fDmFShYqKuYNm2oZT
	 KBNbfKptJK+6ISfBfFBPwvnNbr6TYkh0QpAJjl0Lk50Hn9N3xZsfWQhyLV4HAGwBhbQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788488237;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=O3pG89wazuz3ViSBEw3G5xyKOKBQuyWz6Z06UVLjiq4=;
	b=RyJ5szqJDn2kK8Sw3geWL3tZt3bS8h5dpICAFksAaTn6z9IvPSlmRAOsJtdyah4SqZP+
	 MeWI/5O2lTFg1qjFS5uWBBEeiC4S3w+9NGY6wctVLVO8TnYVeAj6nyE24YLpi8zizyfV9
	 94ZXYpcoOHq6525FTuA9M6FXhxo6f+Br7kuGMy1J7AqeLMlw6XamVf3H2IJPuRFIJlBhi
	 auWauKfTu1JD/foZIqoLE0KuX7CKXD+ApsVR50l1lnFTJu4RWam3/uaovrKvtRSE2N0uY
	 8KUQ6WSxLmqH6NppFOW9D+y7NLHaN5t7nCCnM9RR9SB/FJbOY8T3Jj505K7uEKCe1wA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 41914F8007E
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 04:17:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41914F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d1fc932396c000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/518@alsa-project.org>
References: <alsa-project/alsa-lib/pr/518@alsa-project.org>
Subject: conf: USB-Audio: Add three more devices to the IEC958 blacklist
Date: Fri,  4 Sep 2026 04:17:18 +0200 (CEST)
Message-ID-Hash: RQKRE2FP7UZA3XUXGXIRE3WPBPMJCSAC
X-Message-ID-Hash: RQKRE2FP7UZA3XUXGXIRE3WPBPMJCSAC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RQKRE2FP7UZA3XUXGXIRE3WPBPMJCSAC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #518 was edited from tonymitchell:

None of these devices has an S/PDIF connector, but each shows up in
GNOME Settings with a non-existent digital profile. Add them to the
list to prevent them from being opened.

  Razer BlackShark V3 Xbox          (USB ID 1532:0a58)
  Logitech BRIO                     (USB ID 046d:085e, capture only)
  Plantronics Blackwire 5220 Series (USB ID 047f:c053)
  Poly Voyager Focus 2 UC / BT700 (USB ID 047f:02e6)

Signed-off-by: Tony Mitchell <tony.mitchell@live.ca>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/518
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/518.patch
Repository URL: https://github.com/alsa-project/alsa-lib
