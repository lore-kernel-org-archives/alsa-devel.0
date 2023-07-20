Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29A3C001DE
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Jul 2023 08:56:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2982E9B;
	Fri, 21 Jul 2023 10:55:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2982E9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689929759;
	bh=HQ5mIWPyQgiaiYiJ9muCewYTGSmcTxVH/CixYOAZjoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LlVznLaw39/41nR0k44AnzTJULNjdTalfAVEaQ1Lu1PLkHVDBExehFpEalrLf57kP
	 eR525R83Ou5/tngmqL2c2dchTIZrlbBp0TvWBcXEZTC84eZI1R3MkuMkUwwUkopc4X
	 mA5lIJqku13gp9ky+m6GN20wtwZQDe812xtZ2z5M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51627F805B5; Fri, 21 Jul 2023 10:53:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42C0CF805B5;
	Fri, 21 Jul 2023 10:53:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58D01F8047D; Thu, 20 Jul 2023 10:44:14 +0200 (CEST)
Received: from mail.208.org (unknown [183.242.55.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 72463F80153
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 10:44:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72463F80153
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="unknown key version" header.d=208.org header.i=@208.org
 header.a=rsa-sha256 header.s=dkim header.b=t9BqJUri
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R65nn4nXwzBRDsR
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 16:43:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689842637; x=1692434638; bh=HQ5mIWPyQgiaiYiJ9muCewYTGSm
	cTxVH/CixYOAZjoU=; b=t9BqJUriJE4ftv/uIBFWr+LvsPon5wRqwFcfqAEsS1r
	3vxeG8rjKiQSETE66IKkZDg7nQqodj7f2/HJ8bbdwVQU5PYlrTKcnRuegO3cFBwM
	9DvL0VekE36r1Mn1FY+gPubgn7U9ki+8FFPRWuahexy5yRvhj9FroC8X6iqWzpEE
	lZhOZpmUeaeMwTeFXAJWoHzlOmpBtboUeLIJBsHN+lUfpJu3ULrRd6+yrUHarIrP
	pF9iK52LZxxTjm2Qe86ZH0HTY1glcautugIv71WJxGcc6ucwYNmeOrFGjq+OjXTa
	Kj44Knm+Fk0BtPluiDQAwh8l18MTpEveOLgMI6D8ePA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b6T3hVA07NLw for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2023 16:43:57 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R65nn2H8HzBHXhQ;
	Thu, 20 Jul 2023 16:43:57 +0800 (CST)
MIME-Version: 1.0
Date: Thu, 20 Jul 2023 16:43:57 +0800
From: sunran001@208suo.com
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: fix application of sizeof to
 pointer
In-Reply-To: <20230720073836.3285-1-xujianghui@cdjrlc.com>
References: <20230720073836.3285-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <74739aaaa05f52084757b526bc8348c8@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: sunran001@208suo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: LY4DXO6VPE2W2VIJZ2BJLGSXYHJKWPKD
X-Message-ID-Hash: LY4DXO6VPE2W2VIJZ2BJLGSXYHJKWPKD
X-Mailman-Approved-At: Fri, 21 Jul 2023 08:53:20 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LY4DXO6VPE2W2VIJZ2BJLGSXYHJKWPKD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The coccinelle check report:
./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application of
sizeof to pointer

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  sound/soc/sof/ipc4-topology.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c 
b/sound/soc/sof/ipc4-topology.c
index a4e1a70b607d..2dbe87dbd239 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -218,7 +218,7 @@ static int sof_ipc4_get_audio_fmt(struct 
snd_soc_component *scomp,

  	ret = sof_update_ipc_object(scomp, available_fmt,
  				    SOF_AUDIO_FMT_NUM_TOKENS, swidget->tuples,
-				    swidget->num_tuples, sizeof(available_fmt), 1);
+				    swidget->num_tuples, sizeof(*available_fmt), 1);
  	if (ret) {
  		dev_err(scomp->dev, "Failed to parse audio format token count\n");
  		return ret;
