Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2926EC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 07:17:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E1560241
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 07:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E1560241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9220E165E;
	Fri,  5 Feb 2021 08:17:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9220E165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612509471;
	bh=NRbrpPQLxrc0TSVKjwXCr9+mdR/4kWSnJ4uWRtVXmhc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UNV3S0SrJ36QsKzfThSVy8gmq+9yArOWku+eXihZLSHEqK9fxpwGOMCtnspJsHDat
	 L/vI25gCBloFWHboT0cVDF+R8R3qVkCxOJ/EMcDHeIdbvo+1ThNTnmJ/1Zy4fJ0Pza
	 3iOSJasRTL+UK1nxLnJofWySw9n0M52anjyKrn+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9D56F80139;
	Fri,  5 Feb 2021 08:17:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAAFEF8015A; Fri,  5 Feb 2021 08:16:42 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98EB7F80139
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 08:16:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98EB7F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hqcMKSa2"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 115C260241;
 Fri,  5 Feb 2021 07:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612509395;
 bh=NRbrpPQLxrc0TSVKjwXCr9+mdR/4kWSnJ4uWRtVXmhc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hqcMKSa2sgszcxkzc08G68+SUE2n8fd6e7g5qmVq7rdPJhhBX0L7tJGdsQ6xu8BRd
 qlOIGnPtfVRP8zCiHbeI4Bm1DarHOu4XpQWgD9+r0lcifj0hIk8d1h1HTCfgw76RFY
 jseZAS/3O/y3wwI8y6LDKDy497lERMEucGEoQZfWd8FcpHzJamel5hubdL64o7Vn1n
 fIB46U0bjgsrnAISyrr9JSg84biZNNnMRPTJ5enkQDN7QzHmt7gzBXiYDram+j7DYO
 vJCk45HwaGVofUud6OG274zXkwjeIthtvStwvAcWTFbRn8O10lXcwavhPsDznhf4YV
 aDRpoX1QNKd1w==
Date: Fri, 5 Feb 2021 12:46:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] soundwire: slave: introduce DMI quirks for HP
 Spectre x360 Convertible
Message-ID: <20210205071621.GF2656@vkoul-mobl.Dlink>
References: <20210204204837.27876-1-pierre-louis.bossart@linux.intel.com>
 <20210204204837.27876-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204204837.27876-2-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Bard Liao <bard.liao@intel.com>
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

Hi Pierre,

On 04-02-21, 14:48, Pierre-Louis Bossart wrote:
> HP Spectre x360 Convertible devices expose invalid _ADR fields in the
> DSDT, which prevents codec drivers from probing. A possible solution
> is to override the DSDT, but that's just too painful for users.
> 
> This patch suggests a simple DMI-based quirk to remap the existing
> invalid ADR information into valid ones.

While I agree with the approach, I do not like the implementation. The
quirks in firmware should not reside in core code. Drivers are the right
place, of course we need to add callbacks into driver for this.

So I did a quick hacking and added the below patch, I think you can add
the quirks in Intel driver based on DMI for this.

-- >8 --

From 20af8100025637ea5e295877d28f3afb9dbd4814 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vkoul@kernel.org>
Date: Fri, 5 Feb 2021 12:38:21 +0530
Subject: [PATCH] soundwire: add override addr ops

Some firmware can have buggy _ADR values causing the scanning of devices
to fail. Add the override_ops which if implemented by master driver
would be invoked instead of reading _ADR. The drivers can implement
quirks based on DMI etc to override the addr values.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 -compile tested only, pls validate

 drivers/soundwire/slave.c     | 25 +++++++++++++++++++++----
 include/linux/soundwire/sdw.h |  3 +++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index a08f4081c1c4..2b0d646c5c2f 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -91,12 +91,11 @@ int sdw_slave_add(struct sdw_bus *bus,
 
 #if IS_ENABLED(CONFIG_ACPI)
 
-static bool find_slave(struct sdw_bus *bus,
-		       struct acpi_device *adev,
-		       struct sdw_slave_id *id)
+static bool _find_slave(struct sdw_bus *bus,
+		        struct acpi_device *adev,
+		        struct sdw_slave_id *id)
 {
 	unsigned long long addr;
-	unsigned int link_id;
 	acpi_status status;
 
 	status = acpi_evaluate_integer(adev->handle,
@@ -108,6 +107,24 @@ static bool find_slave(struct sdw_bus *bus,
 		return false;
 	}
 
+	return addr;
+}
+
+static bool find_slave(struct sdw_bus *bus,
+		       struct acpi_device *adev,
+		       struct sdw_slave_id *id)
+{
+	unsigned long long addr;
+	unsigned int link_id;
+
+	if (bus->ops->override_adr)
+		addr = bus->ops->override_adr(bus);
+	else
+		addr = _find_slave(bus, adev, id);
+
+	if (!addr)
+		return false;
+
 	/* Extract link id from ADR, Bit 51 to 48 (included) */
 	link_id = SDW_DISCO_LINK_ID(addr);
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index f0b01b728640..d0ad3404ca95 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -804,6 +804,8 @@ struct sdw_defer {
 /**
  * struct sdw_master_ops - Master driver ops
  * @read_prop: Read Master properties
+ * @override_adr: Override reading address from firmware and read from
+ * driver instead (quirk for buggy firmware)
  * @xfer_msg: Transfer message callback
  * @xfer_msg_defer: Defer version of transfer message callback
  * @reset_page_addr: Reset the SCP page address registers
@@ -813,6 +815,7 @@ struct sdw_defer {
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
+	unsigned long long (*override_adr)(struct sdw_bus *bus);
 
 	enum sdw_command_response (*xfer_msg)
 			(struct sdw_bus *bus, struct sdw_msg *msg);
-- 
2.26.2

-- 
~Vinod
