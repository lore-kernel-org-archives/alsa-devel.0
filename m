Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F0C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 22:48:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAD764F67
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 22:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAD764F67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF4E41728;
	Tue,  2 Feb 2021 23:47:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF4E41728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612306116;
	bh=GcTF9UO4H7YXXBEpXe5/Q5EpCuJoCjqvI2+h9aq5pa4=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=liIGCxzF6pHjDDNugKMfLYmRL0jDITOCMNGO4+jxjjD6SgArHtzFKjPmufqzXhHY5
	 bWk77w2lkh12WYzXcZIvCQfHuCzJB2QvK5Qle0NwWmTxQFtKB7BahLzv3qIDXeCSBN
	 bqPWws7dsNHaFCozWi17ijXlWtQUS3yHwlYyxuno=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AE6DF80152;
	Tue,  2 Feb 2021 23:47:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49B70F80171; Tue,  2 Feb 2021 23:47:44 +0100 (CET)
Received: from fireflyinternet.com (unknown [77.68.26.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6913DF800E1
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 23:47:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6913DF800E1
X-Default-Received-SPF: pass (skip=forwardok (res=PASS))
 x-ip-name=78.156.65.138; 
Received: from localhost (unverified [78.156.65.138]) 
 by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id
 23777703-1500050 for multiple; Tue, 02 Feb 2021 22:47:32 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <s5h4kiue7q4.wl-tiwai@suse.de>
References: <161228343605.1150.8862281636043446562@build.alporthouse.com>
 <s5h4kiue7q4.wl-tiwai@suse.de>
Subject: Re: Oops with "ALSA: jack: implement software jack injection via
 debugfs"
From: Chris Wilson <chris@chris-wilson.co.uk>
To: Takashi Iwai <tiwai@suse.de>
Date: Tue, 02 Feb 2021 22:47:33 +0000
Message-ID: <161230605343.29124.4948122167882588203@build.alporthouse.com>
User-Agent: alot/0.9
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

Quoting Takashi Iwai (2021-02-02 16:48:35)
> On Tue, 02 Feb 2021 17:30:36 +0100,
> Chris Wilson wrote:
> >=20
> > commit 2d670ea2bd53 ("ALSA: jack: implement software jack injection via
> > debugfs") is causing issues for our CI as we see a use-after-free on
> > module unload (on all machines):
> >=20
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_9715/fi-skl-6700k2/psto=
re0-1612277467_Oops_1.txt
>=20
> Could you try the patch below?  The unload test was completely
> forgotten.

This took longer than it deserved,
https://patchwork.freedesktop.org/series/86597/

The oops is fixed.

Tested-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
