Return-Path: <SRS0=2FB+=BH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B268C433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:47:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269CA207F5
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f/a0vN6a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="RZn831Tv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="FmR8q8Eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269CA207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B56CD16D7;
	Tue, 28 Jul 2020 18:46:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B56CD16D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595954834;
	bh=dyEMHTMqLlcfCZiHMGljZAEjN4IHi82H26oFStAZa1Y=;
	h=Subject:From:To:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/a0vN6aIV5trpI8ShzVpTeqgGwMdNVksBKZcpKwgaxwhdayxxohKxwQEM3NZtFNY
	 MdHtDJtqHF0MOCgINe8NWj80FRkSEs5CLxD/o98Agwcu7SFCregoDE3kAltjULvqkL
	 lxmyI8Z0p3StFdc/28in7jMcXd5ZjysxKFTv1bY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EA20F8021C;
	Tue, 28 Jul 2020 18:46:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DB97F8021E; Tue, 28 Jul 2020 18:46:22 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB392F800AD
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2020 18:46:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB392F800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="RZn831Tv"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="FmR8q8Eu"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id CD423A1F65AA3;
 Tue, 28 Jul 2020 18:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1595954769; bh=dyEMHTMqLlcfCZiHMGljZAEjN4IHi82H26oFStAZa1Y=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=RZn831TvvHOKVKCOwk7vrxAGTq11PGMcm3AL0I97DLbJWQXG5iE37u9KO4qnTE/fL
 2FTSOKSyyDtj7Zo4angfIYcZ+5/anZiULINbisE/BmXu7knQsVOKd00ZCPpXaIa+/I
 fTgo1Ji2vrG38r8UnKrH0i1ZTYUmpQobQFELoFWg=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16ySbqPcq27X; Tue, 28 Jul 2020 18:46:04 +0200 (CEST)
Received: from [192.168.105.151] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 54049A1F67621;
 Tue, 28 Jul 2020 18:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1595954764; bh=dyEMHTMqLlcfCZiHMGljZAEjN4IHi82H26oFStAZa1Y=;
 h=Subject:From:To:References:Date:In-Reply-To:From;
 b=FmR8q8EuXepy3E4I/AgMRHDOFCg9376A8j6wsgj6fLuZyxejhP1xyvexixpyzk3xy
 py7PyqphYNjMj4iGrK+qFbDc9eXy3+CQjvEavkcQojE8BbRGOfMKedrF8/Q2vponE0
 GygW9LyYFLe83WBZQyqfgBWd9OQ5STzzkSiqWZyw=
Subject: Re: pcm_meter.c issue at s16_update
From: Pavel Hofman <pavel.hofman@ivitera.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>
References: <f56d6a67-014a-e562-c253-830c0ec03717@ivitera.com>
Message-ID: <9957e124-be4b-cdc9-ffad-579b631455df@ivitera.com>
Date: Tue, 28 Jul 2020 18:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f56d6a67-014a-e562-c253-830c0ec03717@ivitera.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


Dne 26. 07. 20 v 20:20 Pavel Hofman napsal(a):
> Hi,
> 
> I am debugging the following problem with the PCM METER API:
> 
> An application with meter/scope configured in .asoundrc hits a high CPU
> load sometimes when a new playback stream is opened. E.g. in MPD when
> opening a new radio stream. The 100% CPU core load takes tens of seconds.
> ...........
> 
> TL;DR: at decrease of [status.appl_ptr - status.delay] between
> consequent runs the size of buffer to convert by the built-in s16 scope
> is set from usual 100s to huge value of pcm->boundary (1.5G), causing a
> very long processing at 100% core load.
> 
> The debug around the event looks like this, suddenly meter->now drops down:
> 
> s16_update 1: meter->now 2567498, s16->old 2566593, size 905
> s16_update 1: meter->now 2568401, s16->old 2567498, size 903
> s16_update 1: meter->now 20786, s16->old 20786, size 0
> s16_update 1: meter->now 1065, s16->old 20786, size -19721
> s16_update 1: meter->now 24839, s16->old 24838, size 1
> s16_update 1: meter->now 701, s16->old 24839, size -24138
> s16_update 1: meter->now 1253162, s16->old 701, size 1252461
> s16_update 1: meter->now 1255148, s16->old 1253162, size 1986
> 
> ..........
> 
> s16_update 1: meter->now 11136, s16->old 10261, size 875
> s16_update 1: meter->now 22525, s16->old 22524, size 1
> s16_update 1: meter->now 963, s16->old 22525, size -21562
> s16_update 1: meter->now 1270914, s16->old 963, size 1269951
> s16_update 1: meter->now 1272917, s16->old 1270914, size 2003
> 

I think the problem is that s16->old is not reset when status.appl_ptr
is zeroed and starts running again. There is a call

static void s16_reset(snd_pcm_scope_t *scope)
{
	snd_pcm_scope_s16_t *s16 = scope->private_data;
	snd_pcm_meter_t *meter = s16->pcm->private_data;
	s16->old = meter->now;
}

but I do not know when this method is called and whether the meter->now
is already assigned to the newly zeroed status.appl_ptr.

Please at which method should I reset s16->old = 0?
* s16_reset
* s16_enable
* s16_start
* snd_pcm_scope_s16_open


Thanks a lot for any help,

Pavel.

