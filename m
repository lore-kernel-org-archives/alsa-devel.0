Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95429CA5FCE
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:31:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22C72601D5;
	Mon,  5 Oct 2026 09:31:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22C72601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791185491;
	bh=coheoy0BhiwrFcxLoYN2V378HYvzScXoYGpeqMEd68A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YG3LC+SURz7tte0b+g27irAeBuAWWL7I4OA3KTzXAhHlinKRm4fpNuylmR8KLZIHW
	 sq7Skhx80PiRj/N9JDlBqnGbkvzSKjQt4bldl+k0zE79nVLal3HthjmbWCRdRwI8qH
	 naD8hDxoY0tU5JQ5CwXW4fQ0aCek0Ah40L3KrjMg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF1ABF805FA; Mon,  5 Oct 2026 09:30:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A1ED5F80603;
	Mon,  5 Oct 2026 09:30:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1025F80588; Mon,  5 Oct 2026 09:30:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791185445;
	b=achTEtVUZecsvmoawQQE70GW2dzjCPXkA7nQYxXDzqJUi6jJJfBM8UBtKNde6R7w6ziX
	 rFXpEemR4hIt//IDdtP2CO1+viY/qRuerzEZiIbmmRxWlHiFLTbItl4rRRfesWxnDTPsx
	 RvxDR9O+8HDWc3fHt8G34ex4jEXuo+gahf3Q7x6nVaQ1mWC3rrPW+V9qKBxT8VbUwbwxG
	 w2gIOyoDIfzOqbtgU5C06cMC4/FOSl6IauPEZI9s7s65ZiI6nm2zT8Ihc46Ija7Y82vYE
	 DqRGMOV0mLShGeTwK0dP3WmAjTIjz2GQyGyO7SCfg7wevG088u6X5NDW8GI+NELSwhQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791185445;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=coheoy0BhiwrFcxLoYN2V378HYvzScXoYGpeqMEd68A=;
	b=FdMbU65jjavdKDoR9K+DAuUgg7BaVbAN90yauyJ6KuFUNoyNHviiggiZSEaChEGsdxoL
	 eQrCkRhaHFWvdd95HeADX8DZ/DMNWX2TR0CmoORSzNLh0hZ/SUggeqRu4EsWGLcrneaOY
	 zOMLH22b+iutb3Mnlm5kAohRhCPmT9ypepkeanWAYhFY+8pT8i61S/khHlNSh1Jo9PHHo
	 RAzyhF1BSkdEoJw3zSA6oyTAvjR/zOrh98oDmMjSkLH2id/SuNXWBPbjDVhQXbOX88PbN
	 yzpofBqEtaNo10z3dZZ4CIfvAgnOo2YkM2KPiKDFDPduUXc3wGrPuCASNAviX/14QTA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D549F804B2
	for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2026 09:30:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D549F804B2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18db91abc66a9500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/867@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/867@alsa-project.org>
Subject: ucm2: qcs6490: add RB3Gen2 Industrial Mezzanine card support
Date: Mon,  5 Oct 2026 09:30:47 +0200 (CEST)
Message-ID-Hash: RTUZJDX5CD3W6GD672UCEVWAGQWILRAV
X-Message-ID-Hash: RTUZJDX5CD3W6GD672UCEVWAGQWILRAV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RTUZJDX5CD3W6GD672UCEVWAGQWILRAV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #867 was opened from kumarsingh-art:

Add a new UCM profile for the QCS6490-RB3Gen2-Industrial-Mezz sound card, with a HiFi verb defining Speaker playback (WSA883x via the WSA macro) and Mic1 capture (DMIC via the VA macro) devices, plus the card-init/ctl-remap/wsa883x/wsa-macro init includes.

Also add the qcs6490-rb3gen2-ia-snd-card.conf symlink under ucm2/conf.d/qcs6490 so the new card is discoverable by alsa-lib.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/867
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/867.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
