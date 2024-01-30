Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B3DC46CD2
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jan 2024 18:48:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1D3710BE;
	Tue, 30 Jan 2024 19:47:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1D3710BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706640488;
	bh=/Scr6QfMZ0RCV35H3B6N+LHXt3JnpeduIhhpHaToKUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=msNKgjx6brV9CnpaMJxxaHEdZh1YAe1kMAL0tJuy8XqO7Mvfr9ldJ34HaBqtYP8p1
	 U5c5Z/dPWpEM+fWm0zwZLqvrbT4dZNZf/Q8eFaFzMjuj6MHL9lrCbfvQ3CcJXwZOXK
	 8HbRep/N81COzFLHmGZBb4EQLlkRhJZmIUFEN0pw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1DDCF80600; Tue, 30 Jan 2024 19:47:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 073C5F80604;
	Tue, 30 Jan 2024 19:47:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7845FF8057F; Tue, 30 Jan 2024 19:46:57 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 30381F8055C
	for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2024 19:46:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30381F8055C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=JEoAujC5
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A3975CE1C39;
	Tue, 30 Jan 2024 18:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C46C433C7;
	Tue, 30 Jan 2024 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706640401;
	bh=/Scr6QfMZ0RCV35H3B6N+LHXt3JnpeduIhhpHaToKUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEoAujC5s2u7BS20jS5iQkeHDhaHoO14PWbNCx/yT6GTbPSKfGvmPQWHo3EAY6Oz5
	 qqrMzz9jvfZWiFbdRVKYJeu1QXh6S8SaVntmOj+kZGARof2B8kb7yeMLcxwflkkeAe
	 OAkS89eEpD6BPw6c5QQPup8vAd7UvIMDmyPwLbKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 2/6] soundwire: sysfs: move sdw_slave_dev_attr_group into the
 existing list of groups
Date: Tue, 30 Jan 2024 10:46:28 -0800
Message-ID: <2024013029-afternoon-suitably-cb59@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=/Scr6QfMZ0RCV35H3B6N+LHXt3JnpeduIhhpHaToKUk=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDKk7XVjXmhzm99L80ysUunDv2iTNrm7uN7MCJ7MIXvn3f
 8uCWZcPdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEAuIZ5hnuTOeNfiPWvsVX
 /e7WpMUnV77XfsGw4PycJgOeGN6sFzc/K/YWPBXY5LUrDwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IPUWDJINCB6HKV62WOEU6UWW7GLPXRWO
X-Message-ID-Hash: IPUWDJINCB6HKV62WOEU6UWW7GLPXRWO
X-MailFrom: gregkh@linuxfoundation.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IPUWDJINCB6HKV62WOEU6UWW7GLPXRWO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The sysfs logic already creates a list of groups for the device, so add
the sdw_slave_dev_attr_group group to that list instead of having to do
a two-step process of adding a group list and then an individual group.

This is a step on the way to moving all of the sysfs attribute handling
into the default driver core attribute group logic so that the soundwire
core does not have to do any of it manually.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/sysfs_slave.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 3210359cd944..83e3f6cc3250 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -105,7 +105,10 @@ static struct attribute *slave_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(slave);
+
+static const struct attribute_group slave_attr_group = {
+	.attrs = slave_attrs,
+};
 
 static struct attribute *slave_dev_attrs[] = {
 	&dev_attr_mipi_revision.attr,
@@ -190,6 +193,12 @@ static const struct attribute_group dp0_group = {
 	.name = "dp0",
 };
 
+static const struct attribute_group *slave_groups[] = {
+	&slave_attr_group,
+	&sdw_slave_dev_attr_group,
+	NULL,
+};
+
 int sdw_slave_sysfs_init(struct sdw_slave *slave)
 {
 	int ret;
@@ -198,10 +207,6 @@ int sdw_slave_sysfs_init(struct sdw_slave *slave)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_device_add_group(&slave->dev, &sdw_slave_dev_attr_group);
-	if (ret < 0)
-		return ret;
-
 	if (slave->prop.dp0_prop) {
 		ret = devm_device_add_group(&slave->dev, &dp0_group);
 		if (ret < 0)
-- 
2.43.0

