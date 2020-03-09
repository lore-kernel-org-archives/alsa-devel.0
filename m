Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C921C10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:08:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC9F20578
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GVrw9m3e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDZuaPba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC9F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36A6816A6;
	Mon,  9 Mar 2020 19:07:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36A6816A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583777307;
	bh=yb8pBS8kRpZPyNpCu7Ivc9hb2KQ4O/6p5BRMcveklEM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GVrw9m3emHwDIwjAHuKvZSwd8ksLTlW5lh8S5137RhPJqgocUhKEUU5vEMkO9O7Hd
	 73VG0pjU1FHbI66N8UIhu0nXX7DkZsaz8g7lbk++9rJXa+WzlhVxdLY3wDeqH2b5iF
	 UUP9bkyvV7yMrzZco+YViS2UHDyZiMlkcPL4ZZJM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BA2DF801A3;
	Mon,  9 Mar 2020 19:07:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F57DF801EB; Mon,  9 Mar 2020 19:07:34 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 501F1F800DA
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 19:07:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 501F1F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="NDZuaPba"
Received: by mail-wm1-x342.google.com with SMTP id a141so154355wme.2
 for <alsa-devel@alsa-project.org>; Mon, 09 Mar 2020 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eBA+lZ954g7jKtpw1/B41PQ19wyi8PM6OpdNZu9C37U=;
 b=NDZuaPbahD6tbwTSLsUoK6vFEr3myBlaK8x58xuAm1YAI3IdhxHCNkh6nd43S8a8R7
 OKWSf/G7BtmTl6J4NgeR55mAh9i6TBontjXNbG8fqVhEdlPQUnWNYlYdHzt2naNCxDHH
 tFN1lcR4LDqm9bsQiTqNWC1ex8RVuIzjVloyg6XGh7o24/+ROkTag5hXR7EcH2CNKhW7
 j1zz3iztybXvaFYuwzf+SxwnkLxrvBV/aRZqLCzVze0w4UMrS5jiW/mE5ubk/coYGraN
 7OBSgDlIza0pwekqoDCLhv2618fwzCUMCn2oLKxqcuOvKp6juHm1n43oGDLILmDpO5LK
 BClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eBA+lZ954g7jKtpw1/B41PQ19wyi8PM6OpdNZu9C37U=;
 b=AyALes64pe77TqniN2A6lE6+UnTzddDhpPGWK98/kXbSy/PXt79h6l9W7KsyD0gYPa
 8LbmHZSFZXVrXi7tGk8qopMNcWAz+l2FmYKS9a87CQbDM2vbxcKhMGzPcg6fAuaUkFjl
 92nPUOZTDxgFG6jxWPK1y0lhaQ6ENhTO0Jcm+PaaCdN4Jmfux6Kc6dhaKaGCKNyo7RqB
 JYpeY7jRykagYsiGt4vthR630JLETTFHgxOwSYAsUUr4nu5Jw5GRTWvkE542OR+quNNe
 0nP2fX0DNu6o5GxHbZp7vLctfvahVPpR2CwaLGU0uzB0Nzt1k61dQ9P56+7FK3aLhzTz
 vKww==
X-Gm-Message-State: ANhLgQ2FEcGcxlaI2mFBCgxq2RuuYz+MaJ/dHUqpQ4fpq3+3DC2VPwD/
 F+rGz0DUP8TXc3VGtiJZ3ghF/Q==
X-Google-Smtp-Source: ADFU+vtlH9GTgZeMk3lm/2bspK2xoqdgsbmzqg66MrkWYbiXkiMArhwcCth7YJqArpzCjiwH/5ghOw==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr16607wmg.136.1583777250248; 
 Mon, 09 Mar 2020 11:07:30 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id g127sm474817wmf.10.2020.03.09.11.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 11:07:29 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [RESEND RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
Date: Mon,  9 Mar 2020 18:07:25 +0000
Message-Id: <20200309180726.15792-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org
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

According to SoundWire Specification Version 1.2.
"A Data Port number X (in the range 0-14) which supports only one
value of WordLength may implement the WordLength field in the
DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
WordLength in response to reads."

As WSA881x interfaces in PDM mode making the only field "WordLength"
in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
register on WSA881x soundwire slave with Qualcomm Soundwire Controller
is throwing up an error. Not sure how other controllers deal with
writing to readonly registers, but this patch provides a way to avoid
writes to DPN_BlockCtrl1 register by providing a ro_blockctrl1_reg
flag in struct sdw_port_runtime.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Sorry resending this one as I missed header file changes in my previous patch.

I will send patch for WSA881x to include this change once this patch
is accepted.

 drivers/soundwire/bus.h       |  2 ++
 drivers/soundwire/stream.c    | 17 ++++++++++-------
 include/linux/soundwire/sdw.h |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 204204a26db8..791e8d14093e 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -79,6 +79,7 @@ int sdw_find_col_index(int col);
  * @num: Port number. For audio streams, valid port number ranges from
  * [1,14]
  * @ch_mask: Channel mask
+ * @ro_blockctrl1_reg: Read Only flag for DPN_BlockCtrl1 register
  * @transport_params: Transport parameters
  * @port_params: Port parameters
  * @port_node: List node for Master or Slave port_list
@@ -89,6 +90,7 @@ int sdw_find_col_index(int col);
 struct sdw_port_runtime {
 	int num;
 	int ch_mask;
+	bool ro_blockctrl1_reg;
 	struct sdw_transport_params transport_params;
 	struct sdw_port_params port_params;
 	struct list_head port_node;
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 00348d1fc606..4491643aeb4a 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -167,13 +167,15 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 		return ret;
 	}
 
-	/* Program DPN_BlockCtrl1 register */
-	ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
-	if (ret < 0) {
-		dev_err(&s_rt->slave->dev,
-			"DPN_BlockCtrl1 register write failed for port %d\n",
-			t_params->port_num);
-		return ret;
+	if (!p_rt->ro_blockctrl1_reg) {
+		/* Program DPN_BlockCtrl1 register */
+		ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
+		if (ret < 0) {
+			dev_err(&s_rt->slave->dev,
+				"DPN_BlockCtrl1 register write failed for port %d\n",
+				t_params->port_num);
+			return ret;
+		}
 	}
 
 	/* Program DPN_SampleCtrl1 register */
@@ -1195,6 +1197,7 @@ static struct sdw_port_runtime
 
 	p_rt->ch_mask = port_config[port_index].ch_mask;
 	p_rt->num = port_config[port_index].num;
+	p_rt->ro_blockctrl1_reg = port_config[port_index].ro_blockctrl1_reg;
 
 	return p_rt;
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ee349a4c5349..8b130855acd1 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -842,6 +842,7 @@ void sdw_delete_bus_master(struct sdw_bus *bus);
 struct sdw_port_config {
 	unsigned int num;
 	unsigned int ch_mask;
+	bool ro_blockctrl1_reg;
 };
 
 /**
-- 
2.21.0

