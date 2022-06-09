Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7CEC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jun 2022 12:04:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90D311B06;
	Thu,  9 Jun 2022 14:03:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90D311B06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654776252;
	bh=pTupH7cpRcHe0yKYD5EEDvkVkks0JzWSOQcIEppBV6I=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TV5njYxd/Sui6LLQVTTsscx/aGdMpLV9P7Q6R56ek1oU4KbzgPfbEPIIva0m9ePcs
	 IYj4TSOPugcsR1fykkZjMqbXzd5v3wlfvZu94CGWFMZa4gD6luvLoyB5j/QZTJlNiF
	 EKLitLuRT4IoMlzY+QckBnZ9rZZvILc5sF8DRAI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6E08F8012F;
	Thu,  9 Jun 2022 14:02:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4540F80520; Thu,  9 Jun 2022 14:02:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C211F80240
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2022 14:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C211F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="YMDv8tho"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="myBBet/M"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DA4921ED0;
 Thu,  9 Jun 2022 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1654776142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PuJCRxo+N/JmJRtEtrkDLmW7pGD0n583n24L7xJ+5a8=;
 b=YMDv8thojNFD55+eZEnvrWZdYxehAZVOkI807HHx0FydLBokwErKHH1mOSWet1Vvz0eZEK
 buowWVea+fyr63+/Ul7OEiHb8XrGUHyQVd/isCIEU1vvgINr8Q2T3cfpZ0vSnjP0WAej1w
 RBoSimrbvDgwzrIWCKajNmBjXn8Ez3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1654776142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PuJCRxo+N/JmJRtEtrkDLmW7pGD0n583n24L7xJ+5a8=;
 b=myBBet/MwZHXrAS3pf5b+ckXbcHwtDQif8GWvSEkzDkTW6L8KX3XUF1lEdZpyivfLvYSgb
 I74Onk7/tLNcc+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F7EE13A8C;
 Thu,  9 Jun 2022 12:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XorfCk7hoWL1MAAAMHmgww
 (envelope-from <tiwai@suse.de>); Thu, 09 Jun 2022 12:02:22 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ALSA: input validation for control element writes
Date: Thu,  9 Jun 2022 14:02:15 +0200
Message-Id: <20220609120219.3937-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

this is a patch set to add a new feature to ALSA control interface,
a validation for the write to control elements.  So far we rely fully
on the driver implementation to deal with the user inputs with invalid
values (e.g. a value outside the defined range).  This patch set
allows ALSA core to verify the input values beforehand and returns the
error immediately if the validation fails.

The feature is enabled with a new Kconfig for now, as it brings a
slight performance overhead, although this could be turned on as
default in most cases, IMO.

The patch set contains a few preliminary cleanup patches.  The
essential change is only the last one.


Takashi

===

Takashi Iwai (4):
  ASoC: topology: Drop superfluous check of CONFIG_SND_CTL_VALIDATION
  ALSA: control: Rename CONFIG_SND_CTL_VALIDATION to
    CONFIG_SND_CTL_DEBUG
  ALSA: control: Drop superfluous ifdef CONFIG_SND_CTL_DEBUG
  ALSA: control: Add input validation

 include/sound/control.h  |  2 +-
 sound/core/Kconfig       | 27 ++++++++++---
 sound/core/control.c     | 87 +++++++++++++++++++++++-----------------
 sound/soc/soc-topology.c |  2 +-
 4 files changed, 73 insertions(+), 45 deletions(-)

-- 
2.35.3

