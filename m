Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D885AC28CF5
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Jan 2022 19:51:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C03661B5C;
	Wed, 26 Jan 2022 20:50:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C03661B5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643226700;
	bh=/kh6dmnJIV0q+pVQ1os5y7QJUSmBMaUULsKnhR4zezQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S2BlRNDZH6USRMdM0WuSOj1qzqpKLExX+UoCyO1usP/0s6C7uWmFPSusNy4riCEwp
	 XFZAdRwTLCzf+l5xx1E9qM+y1ov5Gv0rqzVakMWRtCfJQoPhg24OEUGcLHvhyIdNAw
	 WfoYIa3DWYgoJTkUN9YMO38mQ3BITUQ41O4IdvV4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AD2AF8047D;
	Wed, 26 Jan 2022 20:50:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30797F804BC; Wed, 26 Jan 2022 20:50:49 +0100 (CET)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 129AFF800C8
 for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2022 20:50:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 129AFF800C8
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP
 (IdeaSmtpServer 4.0.0)
 id 2c39f910849b86ef; Wed, 26 Jan 2022 20:50:41 +0100
Received: from kreacher.localnet (unknown [213.134.162.63])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by v370.home.net.pl (Postfix) with ESMTPSA id 2CB2B66B306;
 Wed, 26 Jan 2022 20:50:40 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] soundwire: Replace acpi_bus_get_device()
Date: Wed, 26 Jan 2022 20:50:39 +0100
Message-ID: <3173256.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.63
X-CLIENT-HOSTNAME: 213.134.162.63
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihunhhgqdgthhhurghnrdhlihgroheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqlhhouhhishdrsghoshhsrghrtheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgrqdhprhhojhgvtghtrdho
 rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace acpi_bus_get_device() that is going to be dropped with
acpi_fetch_acpi_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/soundwire/intel_init.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/soundwire/intel_init.c
===================================================================
--- linux-pm.orig/drivers/soundwire/intel_init.c
+++ linux-pm/drivers/soundwire/intel_init.c
@@ -180,7 +180,8 @@ static struct sdw_intel_ctx
 	if (!res)
 		return NULL;
 
-	if (acpi_bus_get_device(res->handle, &adev))
+	adev = acpi_fetch_acpi_dev(res->handle);
+	if (!adev)
 		return NULL;
 
 	if (!res->count)
@@ -294,13 +295,13 @@ err:
 static int
 sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
 {
-	struct acpi_device *adev;
+	struct acpi_device *adev = acpi_fetch_acpi_dev(ctx->handle);
 	struct sdw_intel_link_dev *ldev;
 	u32 caps;
 	u32 link_mask;
 	int i;
 
-	if (acpi_bus_get_device(ctx->handle, &adev))
+	if (!adev)
 		return -EINVAL;
 
 	/* Check SNDWLCAP.LCOUNT */



