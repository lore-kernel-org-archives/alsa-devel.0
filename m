Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6133C624DB
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:18:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A13506022A;
	Fri,  4 Sep 2026 04:18:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A13506022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788488303;
	bh=O3pG89wazuz3ViSBEw3G5xyKOKBQuyWz6Z06UVLjiq4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sWS6mOH+mzdQhcWnzLbuVJRJkbsaHS8Oh6VcIP2MZCNfIaKEki1dJ4VjbUXXJK9SL
	 KUz/vvhNjblme8w2tF3MxNBGoqG+iOnwpAeVR7Vh9pC1F+3khljUzNKQaGEVUWJb8s
	 kFrWpBpxPxgZR7gF8pOoGH03PrJFYjRNvAoL0+Lw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08373F8061B; Fri,  4 Sep 2026 04:17:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 882ADF80612;
	Fri,  4 Sep 2026 04:17:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E449FF805E6; Fri,  4 Sep 2026 04:17:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788488260;
	b=RPa8d08vfrALbHFA29UxdOknF7Hj215g1YyJSZBPhaIhykHWNkY1EsBB03u2h6g8HTYS
	 Qd+9xgjZYQ6T0dce/WqazXwIWfH9bIxDug30T34MjGZPDL+L1hN8q9G978O0xWb0hdvut
	 rhLnbRbaaZEX1jeF/qo8YMrDClry12pB0xYDy5LDR0OziXfVNC1OJmJeCIKnqSifb9x4x
	 kScExAkgGGOEGFzzkPBeUUKB85JPllCNPGDe8mwXSo9jve+Kyo2zAwTGOEFL8+p9fH8fr
	 AHeTScerKQaUcSwOSwbFx5DC/56nNMvQL5zEms8rktjCY4aA0agwD/+5jLt5pRqvjrg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788488260;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=O3pG89wazuz3ViSBEw3G5xyKOKBQuyWz6Z06UVLjiq4=;
	b=EArVD7d/SoapH9Xb0r2UenwYSOXyphyGWYZUoTHB15xwPgBRr3CTARwFLWqFriDrSQGP
	 EB7LuuzCZJKctqhB2kQpgrnr82A1VsdxyWjyUV3xCU5Y9clrOS9j7Mwmfp/DrWFj7crZ3
	 3JOYf587fcUonCxGjAxRpP/axfwJt4z3mGc9TPurN2wV3I35JvIAGLcq3d4aQuKgpdnWQ
	 DyMYHBVLxGl2iqfUufnrRLV4O/1xPZnNVs2c2wB1hDdUvtNCzUh/Hxc4IUSkFZQtMRtJx
	 myN27+l0FfPE3Iqf8JcBpl3YGKnvppoxv1IpBXkGoH+Dn96BpLHlSQ5MteDqxjxP1ww==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FECEF8007E
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 04:17:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FECEF8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d1fc988bbf6900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/518@alsa-project.org>
References: <alsa-project/alsa-lib/pr/518@alsa-project.org>
Subject: conf: USB-Audio: Add four more devices to the IEC958 blacklist
Date: Fri,  4 Sep 2026 04:17:40 +0200 (CEST)
Message-ID-Hash: 4JP2ZSNTTLLDFBXTBTGTJVIQGTO4WOXH
X-Message-ID-Hash: 4JP2ZSNTTLLDFBXTBTGTJVIQGTO4WOXH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4JP2ZSNTTLLDFBXTBTGTJVIQGTO4WOXH/>
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
