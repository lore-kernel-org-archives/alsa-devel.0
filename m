Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AA0C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 11:43:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E435E60EFD
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 11:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E435E60EFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5ED41753;
	Tue,  3 Aug 2021 13:42:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5ED41753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627990989;
	bh=7cURj9atw3HS8RgEzZblTrn1vO5WvUk6zLIftvRnVR4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jx+dRMg8ZqgcXvkkM9ngw041Jn0w3+aIVlZpSyg+VwPgROVpY4SYS6Mkw5g/BWXuG
	 2947HpiXTVSVKo2eEAukDPlYX04Gew79rMbaYOSOp49gfD6WqxNlaTKk+0DcSujrK6
	 sJuBbuixzmO8ZcCgxsZZfoBhvdAGr6IKOyR20pFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21EA6F8016D;
	Tue,  3 Aug 2021 13:42:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6762F80095; Tue,  3 Aug 2021 13:42:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C289F80095
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 13:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C289F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="ql3auYG5"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="ETCuCIL8"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9FCEE20024;
 Tue,  3 Aug 2021 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627990928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWlPf+5GP9EmJgHfLJddpVraOkqZvXoP+VQ6q3i35h8=;
 b=ql3auYG5mrHK90rSv7mclut0On85UcnYIq+G9wX+wHlTQwOh7dhwT3B+8vKCGOPFdASkYL
 e1z15Xb5U0Z1BfO42GbU/0lUsuEY9WKNX+fhSC0aLV+Y0gCBREuTcJcaKxSDkE20lOfBcc
 PQhgCwnBRKYtO25xIp+An2l9+vHb/8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627990928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWlPf+5GP9EmJgHfLJddpVraOkqZvXoP+VQ6q3i35h8=;
 b=ETCuCIL8dRbq8I9SxaUk8uXZXqGlBXQqfA7sb6SUMF2uA60lmF1mPe+jVJDBvau1XkcuG+
 S8BGPzEKgGl1PdAg==
Received: from alsa1.suse.de (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 90C39A3BCD;
 Tue,  3 Aug 2021 11:42:08 +0000 (UTC)
Date: Tue, 03 Aug 2021 13:42:08 +0200
Message-ID: <s5h5ywmwy9b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: folkert <folkert@vanheusden.com>
Subject: Re: aconnect occasionally causes kernel oopses
In-Reply-To: <20210803101234.GA890690@belle.intranet.vanheusden.com>
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
 <20210803101234.GA890690@belle.intranet.vanheusden.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 03 Aug 2021 12:12:34 +0200,
folkert wrote:
> 
> > > folkert@oensoens:~$ aplaymidi -l
> > > ALSA lib seq_hw.c:466:(snd_seq_hw_open) open /dev/snd/seq failed: Permission denied
> > > Cannot open sequencer - Permission denied
> > > 
> > > ???
> > 
> > Hrm, that's unexpected.
> 
> New system, account was not in the audio-group.
> 
> > Meanwhile, I reconsidered the fix and a better idea came after the
> > sleep.  Below is the new fix patch.  Could you give it a try instead
> > of the previous one?
> 
> Works fine as well: 7 concurrent script-instances for half an hour and
> nothing logged in dmesg.

Great, I'm going to submit and merge the fix soon.


Thanks!

Takashi
