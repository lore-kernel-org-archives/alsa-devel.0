Return-Path: <SRS0=QDkj=5O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDF6C43331
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Mar 2020 12:12:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B63E2074A
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Mar 2020 12:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QM0WJZ3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B63E2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=SDF.ORG
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74B81166D;
	Sun, 29 Mar 2020 14:11:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74B81166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585483961;
	bh=LmL8bvx1ci2dN6TTPz/hmLgN5t6w+ZTCgyIJdvgaqos=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QM0WJZ3PQbHuYoryUHitEfRq9M0lVeOh6nz4aAMLAzTMa+ENLN2sC8ME6Wt5gVUKI
	 zDcIktdFeZB5G1pK/XzTCdvMsaGaS/hPQaryBWc4GvLkFg2sgM5oNFRaW08DjQ/yuR
	 IV4jfQtleWbzysT7fqqwOhillgyG9YgX2UfIgDzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1783F80140;
	Sun, 29 Mar 2020 14:11:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F637F80146; Sun, 29 Mar 2020 14:11:49 +0200 (CEST)
Received: from mx.sdf.org (mx.sdf.org [205.166.94.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB0FDF8013F
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2020 14:11:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB0FDF8013F
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
 by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02TCBVww020963
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
 Sun, 29 Mar 2020 12:11:32 GMT
Received: (from lkml@localhost)
 by sdf.org (8.15.2/8.12.8/Submit) id 02TCBTk2014576;
 Sun, 29 Mar 2020 12:11:29 GMT
Date: Sun, 29 Mar 2020 12:11:29 +0000
From: George Spelvin <lkml@SDF.ORG>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH v1 13/50] Avoid some useless msecs/jiffies conversions
Message-ID: <20200329121129.GC11951@SDF.ORG>
References: <202003281643.02SGhBrh000992@sdf.org>
 <s5ho8sfd2dk.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ho8sfd2dk.wl-tiwai@suse.de>
Cc: lkml@sdf.org, alsa-devel@alsa-project.org,
 Marek Lindner <mareklindner@neomailbox.ch>, linux-scsi@vger.kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>, linux-wireless@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Antonio Quartulli <a@unstable.cc>,
 linux-kernel@vger.kernel.org, b.a.t.m.a.n@diktynna.open-mesh.org,
 Hannes Reinecke <hare@suse.de>, Johannes Berg <johannes@sipsolutions.net>,
 Sven Eckelmann <sven@narfation.org>
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

On Sun, Mar 29, 2020 at 09:52:23AM +0200, Takashi Iwai wrote:
> On Thu, 22 Aug 2019 02:25:10 +0200, George Spelvin wrote:
>> Likewise, "msecs_to_jiffies(seconds * 1000)" is more
>> conveniently written "seconds * HZ".
> 
> I thought the compiler already optimizes to the constant calculation
> for the above case?

It optimizes that if the entire argument, including "seconds", is
a compile-time constant.

However, given "msecs_to_jiffies(hdev->rpa_timeout * 1000);",
the computatin is non-trivial.
