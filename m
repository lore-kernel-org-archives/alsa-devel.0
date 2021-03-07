Return-Path: <SRS0=dfEF=IF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A3C433DB
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 13:31:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F46650E7
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 13:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F46650E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80F3B18FB;
	Sun,  7 Mar 2021 14:30:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80F3B18FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615123882;
	bh=7GSAYzyKreVs6ebcDog1i8nuxjANh9fGw27JDTNf5uU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U5gdicNN+4nQ2WO13mntQDKvMdg8cgIgIyhZUWQKrZe/9AepnIN1cZCRdKO/lDvcx
	 E5l0y//58Tbkzod7fbUlS/D13HplN+OS+iMfpujs36FLINQFokVHKht1Ra0Y0YGFCm
	 LGVU/pzBHo/VEL9Ujz5ygj/MulIXE3ZTQMARiFs8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 792B0F80227;
	Sun,  7 Mar 2021 14:30:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26F01F8029B; Sun,  7 Mar 2021 14:30:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB883F800CC
 for <alsa-devel@alsa-project.org>; Sun,  7 Mar 2021 14:30:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB883F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="FAwYCikg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615123810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5SL00BNHyt7bzS9Gi2d+CPSxfnptw1VqlWxt9ptQaL4=;
 b=FAwYCikgu/cB8Xgk0IYNkKPMCKwU/i01PAAcfYG0RUfVUehjs5mILn04FPeCHTDEKXKXLm
 RKMMHkA9pHnSD4ilPzj2HDMS8OpUNkY4u6Om1Ju3Tc+Nxl0znzznXeBiy1elcXOE+NMmUZ
 uLuNP6BnWqtctgEMv4EVIpVGmZvTmyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-utIzPjp9PPmD7MFym3apaA-1; Sun, 07 Mar 2021 08:30:09 -0500
X-MC-Unique: utIzPjp9PPmD7MFym3apaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF391005D4A;
 Sun,  7 Mar 2021 13:30:07 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD7C45C1CF;
 Sun,  7 Mar 2021 13:30:06 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib v3 0/5] mixer: simple - Volume control fixes
Date: Sun,  7 Mar 2021 14:30:00 +0100
Message-Id: <20210307133005.30801-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>
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

Hi All,

Here is v3 of my series of alsa-lib volume-control fixes which I wrote
while working on adding hw-volume control to UCM profiles for various
x86 ASoC setups.

New in version i3 s first adding a new generic exceptions table to
deal with controls with names which don't use the expected suffixes
to indicate their type.

Also new this version is a patch to deal with some output mute switches
which are called "Foo Channel Switch" instead of "Foo Playback Switch"
(patch 5/5).

Note patch 1/5 also fixes a regression introduced by the changes which
Jaroslav made to commit 86b9c67774bc ("mixer: simple - Unify simple_none: 
base_len() exception handling") before merging it.

Regards,

Hans


Hans de Goede (5):
  mixer: simple - Add generic exception mechanism for non-standard
    control-names
  mixer: simple - Move handling of 3D Control - Depth controls to the
    exceptions list
  mixer: simple - Add exceptions for non " Volume" suffixed capture
    vol-ctls used in ASoC realtek codec drivers
  mixer: simple - Add exceptions for some capture-vol-ctls which have a
    " Volume" suffix
  mixer: simple - Add exceptions for some Playback Switches with a "
    Channel Switch" suffix

 src/mixer/simple_none.c | 74 +++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 28 deletions(-)

-- 
2.30.1

