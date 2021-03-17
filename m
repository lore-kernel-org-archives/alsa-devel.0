Return-Path: <SRS0=sQP2=IP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DADC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 00:56:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB71A64FBC
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 00:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB71A64FBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B83F1816;
	Wed, 17 Mar 2021 01:56:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B83F1816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615942614;
	bh=8lIR2o4v18WR/2YlHYIn96RC4k9ZocX631GO7STRiBc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tw5ymMUPqRaKvjKy01AjxekidHrKlkCmkb39nwbejuIZD5UEc7li7Th4r9ewtFO6A
	 NXv/bNqjodW3oXcZwjW52Hi1e54aw/1j4jj5oee94eNOJnUT+nn+RTrJsYyoVaY6BX
	 57Wch0OrgR4muhtBSvYsHc8fwhjL6FUt+U7ZwNQQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92FCAF80156;
	Wed, 17 Mar 2021 01:56:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2BE2F80163; Wed, 17 Mar 2021 01:55:59 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21BAFF80148
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 01:55:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21BAFF80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QzVAUuj6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF2264F8C;
 Wed, 17 Mar 2021 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942548;
 bh=8lIR2o4v18WR/2YlHYIn96RC4k9ZocX631GO7STRiBc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QzVAUuj68j1wv13I6kZoYqbz+0WoFQfQWjwufMboy+QlEoBYo392BQUdURQKF3Efl
 tW9+7mIZMHQO6EkvUDT6eKCV48VjptWgJJ4wecRBrvej/l6b9DWrqPU5SaD16wdbYM
 tl40plS0XfTzODoDvaZA/2axlH57nPtOie0FVYsbUi4a4q90kr+z6A04BJxYAvYoHj
 yE8nVQkXBxGEwkv4DZNyPgRDO8R82hmfKX1Yj3hkSzS5C0Gj3mccr3PuYeJOAmcpun
 apb54EmTquyptKtKi/OOHK8JskYwYDi7LDf4CiQFxdtzt71StFV51RrKnicw/1DZGh
 clX3mN89y3g/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 09/61] ALSA: hda: ignore invalid NHLT table
Date: Tue, 16 Mar 2021 20:54:43 -0400
Message-Id: <20210317005536.724046-9-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005536.724046-1-sashal@kernel.org>
References: <20210317005536.724046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Philipp Leskovitz <philipp.leskovitz@secunet.com>,
 Mark Pearson <markpearson@lenovo.com>
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

From: Mark Pearson <markpearson@lenovo.com>

[ Upstream commit a14a6219996ee6f6e858d83b11affc7907633687 ]

On some Lenovo systems if the microphone is disabled in the BIOS
only the NHLT table header is created, with no data. This means
the endpoints field is not correctly set to zero - leading to an
unintialised variable and hence invalid descriptors are parsed
leading to page faults.

The Lenovo firmware team is addressing this, but adding a check
preventing invalid tables being parsed is worthwhile.

Tested on a Lenovo T14.

Tested-by: Philipp Leskovitz <philipp.leskovitz@secunet.com>
Reported-by: Philipp Leskovitz <philipp.leskovitz@secunet.com>
Signed-off-by: Mark Pearson <markpearson@lenovo.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210302141003.7342-1-markpearson@lenovo.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-nhlt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index d053beccfaec..e2237239d922 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -39,6 +39,11 @@ int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
 	if (!nhlt)
 		return 0;
 
+	if (nhlt->header.length <= sizeof(struct acpi_table_header)) {
+		dev_warn(dev, "Invalid DMIC description table\n");
+		return 0;
+	}
+
 	for (j = 0, epnt = nhlt->desc; j < nhlt->endpoint_count; j++,
 	     epnt = (struct nhlt_endpoint *)((u8 *)epnt + epnt->length)) {
 
-- 
2.30.1

