Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F4BC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 10:32:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C927864E89
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 10:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C927864E89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7161B16B6;
	Thu, 18 Mar 2021 11:31:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7161B16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616063538;
	bh=GtXTi+eyJtEmY4W0fWnvMDKsiDHBmqs032tVSRiHrOo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bEDUI+EcT+cVc1zPUv0GbKtQH5+D9EkfHAfPlarNh/RTsYIw3A7X6GNWcUZ/Iqg6n
	 RYipnK86frwdXsZPeyg3WZPomAX7fuoqho0dlq8BN85y5iiRzxwquoq114sBBt3II6
	 XhKcpC2wAbJUlEcbsAOhg7AcGb29iihxhZuPJ0RM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6423DF8027D;
	Thu, 18 Mar 2021 11:30:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8594CF802E3; Thu, 18 Mar 2021 11:30:33 +0100 (CET)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCA16F80165
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 11:30:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCA16F80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="06rCZUHR"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="lPbCB88t"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id A62081B40;
 Thu, 18 Mar 2021 06:30:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 18 Mar 2021 06:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=u3b4u7AhBKvmx
 GxRH3d8Y/f0H1IDxZKY6QNRVYncw/Q=; b=06rCZUHRO1ZXqiG1sHqZyN9rdxN8r
 83eXcJ3mNNfbVMAm0/jUiZD6fMkw9UywmgdP+KthMYBg9U524sAbO1JH2ah+yRnF
 NNJvnKEupdOzQYsgzB8i6FA2/rdP94sgnaTVCW92YTknypn3u2uqymJq0PjulGKm
 yD59dIz25FWVeQhjx4LqCeVl45BJnLp8eCud4ELLzEa1u5HjKrqf/jaiVITiYqq6
 myd7uI4BJA5ItDABr5wpZ/cQ/tZ04lVUfr921KcOlZ3YGUrN68SKHOnTbGDv4Oqk
 R6rrfUwNtjrmdQA3XWdb62HtsP1WiX0GI+yp5iYy5pHXKaiZ4NLdD+xag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=u3b4u7AhBKvmxGxRH3d8Y/f0H1IDxZKY6QNRVYncw/Q=; b=lPbCB88t
 amWb4z56bSqYoX6AiWuZvd40GAHzbBgsBW/YEj8sTEJDrokOl0qGqgSQZ/YPID29
 xEBEmSnR7fvh+pYcqHkzU7p3w7JprsKly0rUN8blPUUkrWMXgKQIOz6+ZTCgnMl4
 JwL+5GHsXyf6I0JSwuEvtr861cMWvWg9nlIL6PKCsDkv2L58XQIhZBsIhUXy9PhU
 AExQEO2N5Z98Ynu+v3a9oVjrY663RalW4uDKSxxgwvSDTuXP8+D5iCw7SSXDHHFY
 FJQTCQZOFZjAgNi5U6/U/y0WGJgB+yo4SGQdrUdzdMsi9iQEATsp1M0efw+LZyxW
 ppv3TuSau0vpfA==
X-ME-Sender: <xms:vCtTYNd-Y8w89VVKD3qP887Dq-gkIJIoE2AhmqyFXWLjMz8mtLadWA>
 <xme:vCtTYLKs-zIBQlDWQ2G5053EJelUPt8WHv-fonJd0Rrss7P7esIZJfsfREBZjRsDN
 eGD7F1eVQj2ziEe7KI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefiedgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:vCtTYDZpjQOnLUOd1O0eDxbX50x737zrkc-JdImLaM00mWcMmt8QfQ>
 <xmx:vCtTYOs8LyNvHsjMXsArnM4RTZvhR8Wcl5at1AnbgYnwkLOUv8Wnrw>
 <xmx:vCtTYIsbe20Cikk7cZXECMqwlPNSVF-tBozpiEHHShoELm0CUtxVrg>
 <xmx:vStTYAYBjCri1U2p6QwNNREgHBRRRjGH_NMvD-4NrcvGsw7x5BouSw>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id C7BA91080069;
 Thu, 18 Mar 2021 06:30:19 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [alsa-lib][PATCH 2/6] ctl: add API to check equality between a pair
 of control element IDs by numid
Date: Thu, 18 Mar 2021 19:30:09 +0900
Message-Id: <20210318103013.265264-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318103013.265264-1-o-takashi@sakamocchi.jp>
References: <20210318103013.265264-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, tanjeff@cccmz.de
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

The structure for control element ID is hybrid. It has two ways to check
equality; e.g. equality of numid field, and equality of the other fields.
Just checking equality according to numid field, current alsa-lib take
userspace applications to call snd_ctl_elem_id_get_numid() twice. It's
better to add optimized version of the equality check.

This commit adds API to check equality of numid field for a pair of control
element IDs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h      |  1 +
 src/control/control.c  | 19 ++++++++++++++++
 test/lsb/ctl-elem-id.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/include/control.h b/include/control.h
index 40ac2e97..260d7f30 100644
--- a/include/control.h
+++ b/include/control.h
@@ -424,6 +424,7 @@ int snd_ctl_elem_id_malloc(snd_ctl_elem_id_t **ptr);
 void snd_ctl_elem_id_free(snd_ctl_elem_id_t *obj);
 void snd_ctl_elem_id_clear(snd_ctl_elem_id_t *obj);
 void snd_ctl_elem_id_copy(snd_ctl_elem_id_t *dst, const snd_ctl_elem_id_t *src);
+int snd_ctl_elem_id_equal_by_numid(snd_ctl_elem_id_t *l, snd_ctl_elem_id_t *r);
 int snd_ctl_elem_id_compare(snd_ctl_elem_id_t *id1, const snd_ctl_elem_id_t *id2);
 unsigned int snd_ctl_elem_id_get_numid(const snd_ctl_elem_id_t *obj);
 snd_ctl_elem_iface_t snd_ctl_elem_id_get_interface(const snd_ctl_elem_id_t *obj);
diff --git a/src/control/control.c b/src/control/control.c
index 197d4f52..6d1eda15 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -83,6 +83,8 @@ the same (driver updates can change it, but in practice this is
 rare). The numid can change on each boot. In case of an USB sound
 card, the numid can also change when it is reconnected.
 
+For equality check between a pair of #snd_ctl_elem_id_t according to the numid,
+snd_ctl_elem_id_equal_by_numid() is available.
 
 \section element_lists Element Lists
 
@@ -1818,6 +1820,23 @@ void snd_ctl_elem_id_copy(snd_ctl_elem_id_t *dst, const snd_ctl_elem_id_t *src)
 	*dst = *src;
 }
 
+/**
+ * \brief check equality between two arguments according to numid.
+ * \param l opaque pointer to element ID structure.
+ * \param r opaque pointer to another element ID structure.
+ * \retval zero if they equal, else zero.
+ *
+ * The structure underlying #snd_ctl_elem_id_t is hybrid one. It has two ways to
+ * check equality. The API implements one of the ways, according to the value of
+ * numid field.
+ */
+int snd_ctl_elem_id_equal_by_numid(snd_ctl_elem_id_t *l, snd_ctl_elem_id_t *r)
+{
+	assert(l && r);
+
+	return l->numid == r->numid;
+}
+
 /**
  * \brief compare one #snd_ctl_elem_id_t to another
  * \param id1 pointer to first id
diff --git a/test/lsb/ctl-elem-id.c b/test/lsb/ctl-elem-id.c
index ae416698..f499b268 100644
--- a/test/lsb/ctl-elem-id.c
+++ b/test/lsb/ctl-elem-id.c
@@ -18,9 +18,59 @@
 
 #include "../include/asoundlib.h"
 
+static void set_elem_id_by_tuple(snd_ctl_elem_id_t *elem_id,
+				 snd_ctl_elem_iface_t iface,
+				 unsigned int device_id,
+				 unsigned int subdevice_id,
+				 const char *name,
+				 unsigned int index)
+{
+	snd_ctl_elem_id_set_interface(elem_id, iface);
+	snd_ctl_elem_id_set_device(elem_id, device_id);
+	snd_ctl_elem_id_set_subdevice(elem_id, subdevice_id);
+	snd_ctl_elem_id_set_name(elem_id, name);
+	snd_ctl_elem_id_set_index(elem_id, index);
+}
+
+// Case 0.0. The same value of numid field should result in true positive.
+static void equality_by_numid_0(snd_ctl_elem_id_t *l, snd_ctl_elem_id_t *r)
+{
+	snd_ctl_elem_id_set_numid(l, 33);
+	snd_ctl_elem_id_set_numid(r, 33);
+	assert(snd_ctl_elem_id_equal_by_numid(l, r));
+}
+
+// Case 0.1. The different value of numid field should result in false positive.
+static void equality_by_numid_1(snd_ctl_elem_id_t *l, snd_ctl_elem_id_t *r)
+{
+	snd_ctl_elem_id_set_numid(l, 333);
+	snd_ctl_elem_id_set_numid(r, 444);
+	assert(!snd_ctl_elem_id_equal_by_numid(l, r));
+}
+
+// Case 0.2. The same tuple should result in false positive.
+static void equality_by_numid_2(snd_ctl_elem_id_t *l, snd_ctl_elem_id_t *r)
+{
+	set_elem_id_by_tuple(l, SND_CTL_ELEM_IFACE_CARD, 0, 1, "something", 2);
+	set_elem_id_by_tuple(r, SND_CTL_ELEM_IFACE_CARD, 0, 1, "something", 2);
+	assert(!snd_ctl_elem_id_equal_by_numid(l, r));
+}
+
+// Case 0.3. The tuple should result in false positive.
+static void equality_by_numid_3(snd_ctl_elem_id_t *l, snd_ctl_elem_id_t *r)
+{
+	set_elem_id_by_tuple(l, SND_CTL_ELEM_IFACE_CARD, 300, 400, "something", 500);
+	set_elem_id_by_tuple(r, SND_CTL_ELEM_IFACE_MIXER, 600, 700, "something", 800);
+	assert(!snd_ctl_elem_id_equal_by_numid(l, r));
+}
+
 int main()
 {
 	void (*entries[])(snd_ctl_elem_id_t *l, snd_ctl_elem_id_t *r) = {
+		equality_by_numid_0,
+		equality_by_numid_1,
+		equality_by_numid_2,
+		equality_by_numid_3,
 	};
 	int count = sizeof(entries) / sizeof(*entries);
 	int fd;
-- 
2.27.0

