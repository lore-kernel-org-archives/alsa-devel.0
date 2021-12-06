Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65ECC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Dec 2021 21:25:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86D83234D;
	Mon,  6 Dec 2021 22:25:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86D83234D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638825953;
	bh=WrdJT37ASPUzHOCTgplPEuYPsv8e5CNEXm2Lc5ZgPno=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMxH4y245hcVf2qZVSNYOYbmI+GnaE6M3YxMOJ6HEuq0N5ERD6icXRU0Cu4JCepUT
	 tnw6EVYwOODCk69bGEJLhzrpWpI/75NjZlcXpbrPv45fHqvl70XaNTx5PEWnFu+EKO
	 vVCDSAvbvHYRflpzTSMXEgpJqdLNxD8iJh3hw0t8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23F47F804E5;
	Mon,  6 Dec 2021 22:25:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51D25F804EC; Mon,  6 Dec 2021 22:25:01 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DFCB3F804AE
 for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2021 22:24:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFCB3F804AE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1638825896176964998-webhooks-bot@alsa-project.org>
References: <1638825896176964998-webhooks-bot@alsa-project.org>
Subject: pre-processor only works with relative path based on input file with
 the complete path
Message-Id: <20211206212501.51D25F804EC@alsa1.perex.cz>
Date: Mon,  6 Dec 2021 22:25:01 +0100 (CET)
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

alsa-project/alsa-utils issue #123 was opened from ranj063:

For ex:

`alsatplg -P sof-hda-generic.conf -o test.conf` fails with:

Unable to open included conf file sof-hda-generic.conf/include/components/eqiir/highpass_40hz_0db_48khz.conf
Unable to process include file 
Failed to process includes
Failed to process conditional includes in input config

whereas:

`alsatplg -P ~/work/sof/sof/tools/topology/topology2/sof-hda-generic.conf -o test.conf` works OK.

Would it be possible to make the first command work with the use of the ALSA_CONFIG_DIR environment variable?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/123
Repository URL: https://github.com/alsa-project/alsa-utils
