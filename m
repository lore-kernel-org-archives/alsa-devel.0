Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B4C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 10:13:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD5360EEA
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 10:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6AD5360EEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanheusden.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1D291700;
	Tue,  3 Aug 2021 12:12:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1D291700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627985614;
	bh=Dn9t2AOrmtcQyI4Q26e3v7kYgVZssUnt5jWAFRsMfR0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D6+2kJYfcJLJdBxGc0TJuF6s8hROUYOOldXiax6Anf5kRZiP5ks9Ucv1aTQPorYly
	 9kmmgvkdvwX4RjrdD5XSKlmWYc2Jcs5xZ3fsTIFeTSAchwb2cVYA8AMm+y5L1IPC4c
	 18TPfDuL2f64LFxp0JkDXwTgci4ZFz+l7CnqY5C8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5544EF802E8;
	Tue,  3 Aug 2021 12:12:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1937F8032C; Tue,  3 Aug 2021 12:12:42 +0200 (CEST)
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net
 [194.109.24.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 999DFF80082
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 12:12:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 999DFF80082
Received: from cust-b66e5d83 ([IPv6:fc0c:c157:b88d:62c6:5e3c:5f07:82d0:1b4])
 by smtp-cloud8.xs4all.net with ESMTPA
 id ArPXmTlWwXTlcArPYmkfi2; Tue, 03 Aug 2021 12:12:36 +0200
Received: from localhost (localhost [127.0.0.1])
 by keetweej.vanheusden.com (Postfix) with ESMTP id 9DDBB1626FF;
 Tue,  3 Aug 2021 12:12:35 +0200 (CEST)
Received: from keetweej.vanheusden.com ([127.0.0.1])
 by localhost (mauer.intranet.vanheusden.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id 4qc3QHCOoEtd; Tue,  3 Aug 2021 12:12:34 +0200 (CEST)
Received: from belle.intranet.vanheusden.com (belle.intranet.vanheusden.com
 [192.168.64.100])
 by keetweej.vanheusden.com (Postfix) with ESMTP id D0B3D1626F6;
 Tue,  3 Aug 2021 12:12:34 +0200 (CEST)
Received: by belle.intranet.vanheusden.com (Postfix, from userid 1000)
 id C736016097B; Tue,  3 Aug 2021 12:12:34 +0200 (CEST)
Date: Tue, 3 Aug 2021 12:12:34 +0200
From: folkert <folkert@vanheusden.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: aconnect occasionally causes kernel oopses
Message-ID: <20210803101234.GA890690@belle.intranet.vanheusden.com>
References: <20210801182754.GP890690@belle.intranet.vanheusden.com>
 <s5hlf5kz80e.wl-tiwai@suse.de>
 <20210802061845.GQ890690@belle.intranet.vanheusden.com>
 <s5him0oz5zq.wl-tiwai@suse.de>
 <20210802091012.GR890690@belle.intranet.vanheusden.com>
 <s5hczqvyj8m.wl-tiwai@suse.de>
 <20210802152117.GT890690@belle.intranet.vanheusden.com>
 <s5h5ywnydlz.wl-tiwai@suse.de>
 <20210802195349.GV890690@belle.intranet.vanheusden.com>
 <s5h1r7bxbiv.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1r7bxbiv.wl-tiwai@suse.de>
Reply-By: Fri 16 Jul 2021 08:34:34 AM CEST
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4xfN+wlXrB086pJ3Tl86bh5JRbB+6nnrfjql4n/vC9nf8XB/6cjF4DlpF2aDgWiV1CdX7VLiy0Gdsak8WbpyK98zDYd5S5ZGYjEGv1SBE2xlQ8IK23y1a0
 buKn025xiLjmHEsMA1yQmSNRr/ZJNPK7h8X7KiaIzH92PWFs2XFErxBW/e1VE4tNfrNtZnm2Tu2tsidq0uNMxPT5lb1pA0KxkqaEhEIxGgftdYUVuKpmLVy7
 dbjThp9OeeiAjwSySrqS9A==
Cc: alsa-devel@alsa-project.org
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

> > folkert@oensoens:~$ aplaymidi -l
> > ALSA lib seq_hw.c:466:(snd_seq_hw_open) open /dev/snd/seq failed: Permission denied
> > Cannot open sequencer - Permission denied
> > 
> > ???
> 
> Hrm, that's unexpected.

New system, account was not in the audio-group.

> Meanwhile, I reconsidered the fix and a better idea came after the
> sleep.  Below is the new fix patch.  Could you give it a try instead
> of the previous one?

Works fine as well: 7 concurrent script-instances for half an hour and
nothing logged in dmesg.
