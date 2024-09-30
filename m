Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F163ACF6497
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:22:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1BCF192C;
	Mon, 30 Sep 2024 13:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1BCF192C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727695361;
	bh=zY5fLQx5eAob2m8RVjDYU4PsTYf3zrfWO5TzD8j7olM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rl8YTLtlWC74ZYUjHg6ULrBT/m1NGvCg6KPvMaJ1H0o+3v0SE9xVG7SKTGaMzcz6x
	 97PY2nVUw/IdqX8s6hXY/trK+2N5cN9kJsfKk4pClV5j6X0h9d2mTLTmXbPABoclOF
	 DL5DGUAADZAQv86LeiCQZRxV7aqoOuNPa1V9HL/Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77453F805FC; Mon, 30 Sep 2024 13:21:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2D35F805E9;
	Mon, 30 Sep 2024 13:21:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8318BF805A1; Mon, 30 Sep 2024 13:21:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 977DCF800FA
	for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2024 13:21:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 977DCF800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256
 header.s=dc header.b=h/tOh7AW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Kr5dOKa8hZztibt/ZHFgdGNFDX6J60qxqGmrL527Zk=;
  b=h/tOh7AWoEhfvDreNIbqZe2D24GWlprTaC7/tBKl3GHFD5uorJ1ghT3o
   I4gvxyIFeb3Yka9YAeLAXqw6VAxILrf6iCAaSRAdoKP2rU7VJNigOb4mF
   URE8UR4/IyJDo4uTYNplKRwLCjjeRCFMyo8fXhDNfjkD+lcJv8ScgmqNg
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400";
   d="scan'208";a="185956883"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Vinod Koul <vkoul@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/35] soundwire: stream: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:58 +0200
Message-Id: <20240930112121.95324-13-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RJ7ZNH2GHRBIWP2I622KBXFI4HOGO5SQ
X-Message-ID-Hash: RJ7ZNH2GHRBIWP2I622KBXFI4HOGO5SQ
X-MailFrom: Julia.Lawall@inria.fr
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RJ7ZNH2GHRBIWP2I622KBXFI4HOGO5SQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/soundwire/stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 7aa4900dcf31..0e1875c31a3d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1977,9 +1977,9 @@ EXPORT_SYMBOL(sdw_stream_remove_master);
  *
  * @slave: SDW Slave instance
  * @stream_config: Stream configuration for audio stream
- * @stream: SoundWire stream
  * @port_config: Port configuration for audio stream
  * @num_ports: Number of ports
+ * @stream: SoundWire stream
  *
  * It is expected that Slave is added before adding Master
  * to the Stream.

