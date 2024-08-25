Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A105C5321E
	for <alsa-devel@archiver.kernel.org>; Sun, 25 Aug 2024 18:23:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CFE4825;
	Sun, 25 Aug 2024 20:22:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CFE4825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724610182;
	bh=F17+/l4/y3fXnmO2FEWxquut7fnPo/TcqdjxqQVqIh4=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Uub1GEvgxkLG7rwsI3A97qd1OMOfswHrkrlARSz1RmHMsdGcAuCgManhHDlIvNw7e
	 pgNr9L8jOLmPl3U/xcHP74rUW/QsuDWrGGy0JB0P/PoHvhLG/uAPFVhgTmbBRaUsYw
	 1HSjUGcumi8SLW8VOzD49Ng4sKAA6vHN7LXtWmgw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE5C3F805B2; Sun, 25 Aug 2024 20:22:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 474AEF805B4;
	Sun, 25 Aug 2024 20:22:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 136EEF80423; Sun, 25 Aug 2024 20:16:53 +0200 (CEST)
Received: from smtp.ivitera.com (smtp.ivitera.com [88.101.85.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0D099F800AC
	for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2024 20:16:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D099F800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ivitera.com header.i=@ivitera.com header.a=rsa-sha256
 header.s=mail header.b=TEyFl95r;
	dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.a=rsa-sha256 header.s=mail header.b=TEyFl95r
Received: from localhost (localhost [127.0.0.1])
	by smtp.ivitera.com (Postfix) with ESMTP id A2CA817E9A9;
	Sun, 25 Aug 2024 20:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1724609805; bh=F17+/l4/y3fXnmO2FEWxquut7fnPo/TcqdjxqQVqIh4=;
	h=Date:From:To:Subject:From;
	b=TEyFl95r6aRNLfV/qiIzkuhrDrMvkiy1YN+DaXsNLnl9PNNzYGTQ5PHWmH8dLpuRT
	 g2KLcMgcwy0nR3qFBGw5tAlvNwjexOL9f4oKnfeTIYqCmZLC/Y7Wb9Uc5SmngbX4/6
	 RXw5TbmeQvEQcACcKBTDtKfFPoKHLLkifRkbr0wo=
Received: from smtp.ivitera.com ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8YKazOk5yo6r; Sun, 25 Aug 2024 20:16:45 +0200 (CEST)
Received: from [192.168.105.22] (dustin.pilsfree.net [81.201.58.138])
	(Authenticated sender: pavel)
	by smtp.ivitera.com (Postfix) with ESMTPSA id 2A4B217E9A8;
	Sun, 25 Aug 2024 20:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1724609805; bh=F17+/l4/y3fXnmO2FEWxquut7fnPo/TcqdjxqQVqIh4=;
	h=Date:From:To:Subject:From;
	b=TEyFl95r6aRNLfV/qiIzkuhrDrMvkiy1YN+DaXsNLnl9PNNzYGTQ5PHWmH8dLpuRT
	 g2KLcMgcwy0nR3qFBGw5tAlvNwjexOL9f4oKnfeTIYqCmZLC/Y7Wb9Uc5SmngbX4/6
	 RXw5TbmeQvEQcACcKBTDtKfFPoKHLLkifRkbr0wo=
Message-ID: <24c2052b-607d-3f2a-8733-0aa67bcde874@ivitera.com>
Date: Sun, 25 Aug 2024 20:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From: Pavel Hofman <pavel.hofman@ivitera.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Jaroslav Kysela <perex@perex.cz>
Subject: Specifying supported hw params (channels, format, etc.) by the plug
 plugin in alsa config?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: PGTPMJHWW42WVM43EUTPWL26HKZEPZPG
X-Message-ID-Hash: PGTPMJHWW42WVM43EUTPWL26HKZEPZPG
X-MailFrom: pavel.hofman@ivitera.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PGTPMJHWW42WVM43EUTPWL26HKZEPZPG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Please is it possible to restrict the hw params space for the plug
plugin by some alsa configuration, so that it reports/accepts only a
specific number of channels/specific sample format? I was not able to
figure it out, I apologize if it's trivial :-)

Thanks a lot.

With regards,

Pavel.
