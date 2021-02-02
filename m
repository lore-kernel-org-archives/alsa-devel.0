Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E65CC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 12:57:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFA764F49
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 12:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFA764F49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=base.nu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 730AE16E0;
	Tue,  2 Feb 2021 13:57:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 730AE16E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612270672;
	bh=cCz7XdJfYHF80R1hU5bTogBk6t6PUT+bgeWqWiniaB0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cirGoFSoVOkU+XFny13vCsvU50QP4emlRmeH8Lu6Yc8YFBko6KOWZaQhU42019qhr
	 HaJbvPV9kwzazOYwwnBQbxe+7sMb0z6wAWVdZPlG4GU+9xIVVsMSB8dMDk5B85n977
	 SfcEEjK489WOdL4JepdIjqk6og1/L2MZ/80e0pH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D811DF80152;
	Tue,  2 Feb 2021 13:57:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A442EF80171; Tue,  2 Feb 2021 13:56:59 +0100 (CET)
Received: from hellmouth.base.nu (hellmouth.base.nu [192.248.168.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27CC8F8013C
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 13:56:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27CC8F8013C
Received: from baphomet.hell (<unknown> [192.168.179.1])
 by hellmouth.base.nu (OpenSMTPD) with ESMTP id 6f84a002;
 Tue, 2 Feb 2021 12:56:45 +0000 (UTC)
Received: from baphomet.hell (localhost [127.0.0.1])
 by baphomet.hell (OpenSMTPD) with ESMTP id 52cfa899;
 Tue, 2 Feb 2021 12:54:58 +0000 (GMT)
Received: from base.nu ([192.168.178.2]) by baphomet.hell with ESMTPSA
 id 2E2+EqJLGWC3EgEAnQSWfg
 (envelope-from <livvy@base.nu>); Tue, 02 Feb 2021 12:54:31 +0000
Date: Tue, 2 Feb 2021 12:54:10 +0000
From: Olivia Mackintosh <livvy@base.nu>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Add DJM450 to Pioneer format quirk
Message-ID: <20210202125404.c24roplg7hx6tmdh@base.nu>
References: <20210202000237.z2hxauysouuf3ice@base.nu>
 <s5h4kiug0j3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4kiug0j3.wl-tiwai@suse.de>
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

Apologies. I am just getting used to the git-send-email mailer for
emailing threaded patch sets and made a few oversights. I will correct
these, add Signed-off-by line and resubmit as thread.

Olivia

On Tue, Feb 02, 2021 at 12:41:04PM +0100, Takashi Iwai wrote:
> On Tue, 02 Feb 2021 01:02:37 +0100,
> Olivia Mackintosh wrote:
> > 
> > Like the DJM-750, ensure that the format control message is passed to
> > the device when opening a stream. It seems as though fmt->sync_ep is not
> > always set when this function is called hence the passing of the value
> > at the call site. If this can be fixed, fmt->sync_up should be used as
> > the wvalue.
> 
> Could you give your Signed-off-by line?
> 
> > +static int pioneer_djm_set_format_quirk(struct snd_usb_substream *subs,
> > +					u16 windex)
> > +{
> > +	unsigned int cur_rate = subs->data_endpoint->cur_rate;
> > +	u8 sr[3];
> > +	// Convert to little endian
> > +	sr[0] = cur_rate&0xff;
> > +	sr[1] = (cur_rate>>8)&0xff;
> > +	sr[2] = (cur_rate>>16)&0xff;
> 
> Better to have some appropriate spaces around operators.
> 
> Also, instead of open-code, you can use cpu_to_le32() and pass its
> pointer, too.
> 
> 
> thanks,
> 
> Takashi
