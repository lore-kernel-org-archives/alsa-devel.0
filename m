Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316CEC5AD5A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:27:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A6136022C;
	Wed, 12 Aug 2026 11:26:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A6136022C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526819;
	bh=5TL97s5C5g7hjPQZj5TBzDgdZMrRUoP7lY7Bix0I0pE=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ercGBpMST8UrsGAdYlmceMFgNaI3uCWRNJFLwD38jceZtEpk0rsbjjy17QIl55Iws
	 zdWN6O3VTtJzpj+ih6BZXdBIMdhAUOx7SLu7pD5FKKa4FoQt2spdlGP8MwfKBKTD8Z
	 3DbJ1uJANPPT+kjdPnHnQC5Mi2/X3x7MEqgY5Tp8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AF86F80609; Wed, 12 Aug 2026 11:25:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 294DAF80600;
	Wed, 12 Aug 2026 11:25:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10EE6F8026A; Sun,  9 Aug 2026 00:47:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=15.204.3.4
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786229253;
	b=Dwk5NJWb6ax8LM61Ou/1frnmFV2JK0EttSsWhOYd9ySncUtUI1tdYqH20Q0FnbOl4Vtn
	 /ggDtOW0ZBPpBxRsM0P2kjs7jz9eU8EsiArTjgg6/PABOI0ulUTH5HwCXzMjWm36qc67Y
	 10yLtuNPzdDepAPK0aW9h8H7mva/1S5Rwi8LqByOoueyeu5PIao2LljSnJBXQbXhkuave
	 SvjIP3AgkgCBW23CMtfzsyccWOPp4KGGwM3S5pLiLgkUcHL2meBYgFlRR5Zf+BdB0xdx5
	 ufbvOCnQGXrBWcrNDmu4EXze1cQoyv76HLjru3qyAeI2zVKXpbKbUm9dKjHN97iPP4w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786229253;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5TL97s5C5g7hjPQZj5TBzDgdZMrRUoP7lY7Bix0I0pE=;
	b=bv9+cvQRsRRrKhLSq22ZsYw7FNvEI4Wmgb7NWVXLRBCca8rc8tgKr3tY3OHJmV3wzsOE
	 aPs282tPQ75lyPdbZwlQNlnC+zQqJEzKTqYPwClqZZBHtrLA8uDCNphelf1VWX/ChM6FN
	 4q7piPIDrNGXBifM2cOXZhLXxfIPUTyLlaW+9F5UCofVC9FtCaCgRWVA2243xYogwSYZs
	 QQTgVwAS1OBDb0WKeIfDABB+LUGqg9cGHqxkgd5CaN5qh7OrOi2BaMJm4W5LV7D12dkxs
	 8C+4Z/hsDU+FUxd00aZpGyXN+qCkJyk4ubZmUKmWqs6Q8Xc9wcBBN3C4RvdT8ndwX9A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=oxsus-vadesecure.net header.i=@oxsus-vadesecure.net
 header.a=rsa-sha256 header.s=dkim-202410-rsa2048 header.b=QUTKkt2c;
	arc=none smtp.remote-ip=15.204.3.4
Received: from mta-231a.oxsus-vadesecure.net (mta-231a.oxsus-vadesecure.net
 [15.204.3.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F0ACEF80153
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 00:47:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0ACEF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=oxsus-vadesecure.net header.i=@oxsus-vadesecure.net
 header.a=rsa-sha256 header.s=dkim-202410-rsa2048 header.b=QUTKkt2c
Authentication-Results: oxsus-vadesecure.net;
 auth=pass smtp.auth=4@316323 smtp.mailfrom=dave@synergy.org;
DKIM-Signature: v=1; a=rsa-sha256; bh=U6ehwGNbgVklLD8CruN0kobVz0rs3arSRIBCBp
 mtZuw=; c=relaxed/relaxed; d=oxsus-vadesecure.net; h=from:reply-to:
 subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
 in-reply-to:references:list-id:list-help:list-unsubscribe:
 list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive;
 q=dns/txt; s=dkim-202410-rsa2048; t=1786229248; x=1786834048; b=QUTKkt2
 c52p+E+fFUG9k/OXlDVhIshdPpQesOZRuowdk3h3upeYlmK7t879MpwetS2e+xajW0YFqYa
 IX93P3VKninewckWfNnHk0MPzvK2CNn5lrJr5prQuuCj3NvJ0sk6duyDSmWlkVgGOvP9iZd
 i+pUcY2pXK+pKvpQjxtSLWKwR6v8+T4PR8FYifnrun+HWfiEp9xxg1OBdgJhoECr+yng6cj
 loSTk9MXdAHXwYR//QEpqDsI/Q2DoLboVEcLRbRtjqS7zoz3b41JoYnp6VwqfL+XKBFyG3q
 7/P/7q9zt7PZkz3ekQYofYhkjjW5ibiav2SLT5qmsePtBSrmScw==
Received: from proxy-9 ([174.165.77.67])
 by oxsus2nmtao01p.internal.vadesecure.com with ngmta
 id f793b570-18c9f60933016c7b; Sat, 08 Aug 2026 22:47:28 +0000
From: <dave@synergy.org>
To: <alsa-devel@alsa-project.org>
Subject: the ALSA state machine
Date: Sat, 8 Aug 2026 15:47:24 -0700
Message-ID: <000201dd2787$e39e3f10$aadabd30$@synergy.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad0nhGxClQOH6ovkRP+4lp4ko73khw==
Content-Language: en-us
X-MailFrom: dave@synergy.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DQ3YRBRUH33VSNBULVYTPDY5GFKNX2Q6
X-Message-ID-Hash: DQ3YRBRUH33VSNBULVYTPDY5GFKNX2Q6
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:25:40 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DQ3YRBRUH33VSNBULVYTPDY5GFKNX2Q6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,
	I am trying to debug some ALSA playback code. I have two playback
devices,. The first is A USB sound bar and the second is A Bluetooth sound
bar. The issue I am debugging is truncated output on the Bluetooth sound
bar. The USB sound bar works fine. I've added assertions to understand how
my code may be getting out of sync with the ALSA state machine.
	For reference, I am using the documentation at
https://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
	After opening the device, I check its state and it is always in the
SND_PCM_STATE_OPEN state, as expected. After initializing the h/w and s/w
params, however, the document says I should be in the SND_PCM_STATE_SETUP
state. Instead, however, I am in the SND_PCM_STATE_PREPARED state. I then
call snd_pcm_prepare() and remain in the SND_PCM_STATE_PREPARED state. I
then call snd_pcm_start(). In the USB version I get an -EPIPE error. In the
Bluetooth code I do not get an error. Finally, I check the state before I
exit my initialization code and I am in the SND_PCM_STATE_PREPARED, not the
SND_PCM_STATE_RUNNING state. Evidently, the documentation and the code do
not agree. Which is correct? It would be trivial to check the state and omit
the snd_pcm_prepare() call if it is already in the prepared state. But I am
trying to follow the document as closely as possible.
	Thoughts?
	David



