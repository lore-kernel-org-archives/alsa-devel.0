Return-Path: <SRS0=vz66=XD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72DCC4332F
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Sep 2019 10:48:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C1120863
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Sep 2019 10:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IauCD8sL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C1120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8867E1675;
	Sun,  8 Sep 2019 12:47:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8867E1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567939729;
	bh=TdI8BT97s5gvljKVrXYrPC1f5PVfluhXcJriMZcZuNM=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IauCD8sLnKAZHymTSa07N0+eoMC7qRwkQqN+KaTi6E7N36t9nDnEzfGtbihkGZOhs
	 v0al7RzQJinXPR1ArlLq9/0TiPhjlZjx/4y9QoYKKr5phhOR85b2Suw18AtEIa/4jz
	 boWyWhhrSYg9jTfXK5zbULbLHjrAmqbmlMIYhbHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BA3BF806F5;
	Sun,  8 Sep 2019 12:40:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB82CF8065B; Sun,  8 Sep 2019 12:39:57 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCB58F80600
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2019 12:39:34 +0200 (CEST)
Received: from server.perex-int.cz (unknown [172.16.0.20])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 71524A0042;
 Sun,  8 Sep 2019 12:39:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 71524A0042
Received: from alsa-devel.perex.cz (unknown [192.168.102.181])
 by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
 DBF83140059; Sun,  8 Sep 2019 12:39:31 +0200 (CEST)
MIME-Version: 1.0
From: Jaroslav Kysela <jkysela@redhat.com>
To: Nishit Sharma <nishitx.sharma@intel.com>
Message-Id: <15679391594432724-alsa-devel@perex.cz>
Date: Sun,  8 Sep 2019 12:39:57 +0200 (CEST)
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] Licence change for your alsa-lib UCM commit (Nishit
	Sharma: 1 total)
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190908103957.NPnol3rhF1qVNhbX0-GHOfzgGCSc9tFpc2XkyoOy4LU@z>

As discussed, we would like to move the UCM configuration files from the
alsa-lib repository to new alsa-ucm-conf repository with the licence change
from LGPL-2.1 to BSD-3-Clause.

I would like to check, if you agree with this licence change. Please, answer
to this e-mail and write your agreement / disagreement (keep CC to
the alsa-devel mailing list for the archiving purposes).

Thank you for your time and co-operation.

Reference:  https://mailman.alsa-project.org/pipermail/alsa-devel/2019-July/153257.html

List of your commit(s):

  360c976aaa051809c34cb412ffa52380baeaabee
    conf/ucm: broxton: add broxton-rt298 conf files

---
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
