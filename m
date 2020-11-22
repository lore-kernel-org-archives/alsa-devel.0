Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219DC63777
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 17:06:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59BE2086A
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 17:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="emzNAF0q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=buddington.net header.i=@buddington.net header.b="UB2cZfAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59BE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buddington.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0875316D8;
	Tue, 24 Nov 2020 18:05:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0875316D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606237590;
	bh=E2MeRU8SjZw/GMpYGp6cTCj1iolQhS04xT3yQ8ppML8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=emzNAF0qSQgjfoTOqhYP3kFmrk4YQN0DeVT4oOsVtxABL1IhL/D4RgAURxOVGQ8AK
	 /c348G5hqVM7fwaUYoeTl9oweTQHBksOfP2CF66zsNLLlJtGdYw4rMXRV31fXXFqtR
	 1delWU6xNv9LrxW/7fwtcObIAl8eb+XQzWB+G+pQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FFE9F8053B;
	Tue, 24 Nov 2020 17:58:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA665F80165; Sun, 22 Nov 2020 17:03:49 +0100 (CET)
Received: from bee.birch.relay.mailchannels.net
 (bee.birch.relay.mailchannels.net [23.83.209.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B15BDF80113
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2020 17:03:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B15BDF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=buddington.net header.i=@buddington.net
 header.b="UB2cZfAl"
X-Sender-Id: dreamhost|x-authsender|eric@buddington.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 086D2401138
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2020 16:03:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a27.g.dreamhost.com
 (100-96-9-156.trex.outbound.svc.cluster.local [100.96.9.156])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 95CC540041B
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2020 16:03:39 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eric@buddington.net
Received: from pdx1-sub0-mail-a27.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
 by 0.0.0.0:2500 (trex/5.18.10); Sun, 22 Nov 2020 16:03:39 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eric@buddington.net
X-MailChannels-Auth-Id: dreamhost
X-White-Trail: 6bd90966669752ae_1606061019840_1820198432
X-MC-Loop-Signature: 1606061019840:26453781
X-MC-Ingress-Time: 1606061019839
Received: from pdx1-sub0-mail-a27.g.dreamhost.com (localhost [127.0.0.1])
 by pdx1-sub0-mail-a27.g.dreamhost.com (Postfix) with ESMTP id 3FEBA7F681
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2020 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=buddington.net; h=date
 :from:sender:to:subject:message-id:reply-to:mime-version
 :content-type; s=buddington.net; bh=2mB6wSOdnjkwUPrTqJuAeRBsXJc=; b=
 UB2cZfAlngp6IHrGL+KAipelBO9hgfh+yI86Wfm+l4SByzNn8u1nEhV48aHeuGXb
 GkRrn8DzyBp50HUqvnDi3VPS0zlREulTmBQs8YsKIw6YOWPXkcKx7p3YlxeihBbC
 Ceg8q84YIfowq/3CTqR5+B+2XCB0ga2DoIVKIy6vdoM=
Received: from hermit.home.eric.buddington.net
 (cpe-74-76-227-193.nycap.res.rr.com [74.76.227.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: eric@buddington.net)
 by pdx1-sub0-mail-a27.g.dreamhost.com (Postfix) with ESMTPSA id F1F5D7F67E
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2020 08:03:37 -0800 (PST)
Date: Sun, 22 Nov 2020 11:03:35 -0500
X-DH-BACKEND: pdx1-sub0-mail-a27
From: Eric Buddington <eric@buddington.net>
To: alsa-devel@alsa-project.org
Subject: How to interperet snd_pcm_htimestamp available frames?
Message-ID: <X7qL18y+CkrzVDBR@hermit.home.eric.buddington.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
X-Mailman-Approved-At: Tue, 24 Nov 2020 17:58:07 +0100
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
Reply-To: eric@buddington.net
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

I am recording from multiple (cheap USB) mics, and trying to
synchronize them. I am assuming that there will be a common minimum
latency (reflecting an uncontested USB bus), with occasional spikes up
- but not down.

In my loop, I am calling snd_pcm_mmap_begin(), snd_pcm_htimestamp(),
and snd__mmap_commit() in that order.

My question is about the 'avail' value returned from htimestamp. It is
documented as "Number of available frames when timestamp was grabbed".
Does this mean frames since the last frame consumed with
_mmap_commit()?

Is there a possibility of there being no timestamp, or one where
'avail' refers to some older state?

Thanks for any insight.

-Eric
