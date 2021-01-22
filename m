Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A49C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 17:01:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A725233FA
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 17:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A725233FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49DCF175E;
	Fri, 22 Jan 2021 18:01:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49DCF175E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611334913;
	bh=z7+wmUmdtv4F8QboYXMhaJjSK7XUtOy3sb0VXBsCVIY=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HZ810YiKxpaHDtIAYIROpzzb8PVupffv338WpXOFtCgOHA0/SalfEZyzyAgr/jGwN
	 FvxJaD9HvH8qSuifA/h3Z03FNV4J9O0Pl9AFmFXiPI6QknY4RQZtRAWp2uYep3fBln
	 kiGzjFjMElRNoFUuxaVWZOKYG+aicto13WRInoAg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CF98F80166;
	Fri, 22 Jan 2021 18:01:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9CF59F8016E; Fri, 22 Jan 2021 18:00:59 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E888F8015B
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 18:00:51 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7A833A0040;
 Fri, 22 Jan 2021 18:00:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7A833A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1611334850; bh=tnXFqSoUOD/Qz1sA1MyUAocRIeBpelozpGfeYWPR1uE=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=s3JqbS3BdCxaAIbB+i+lZZyZ7abMxWkQZ0CYkwxtIaQELyjZ0ewJ8a1ECWUJvbMMe
 c//PZU5sxlr2dti+U72ZlFnfbZYD9w9UPlt/k6QYgtA2cW8JxMcFMTBR9Y/xbaP66/
 pZpoXVv+Z256sZ8EDf7fxcR5IF5GnDZE8/yQaCi4=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 22 Jan 2021 18:00:48 +0100 (CET)
Subject: Re: [PATCH alsa-lib 0/4] pcm: Fix missing appl_ptr and hw_ptr updates
 in snd_pcm_status()
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20210122144842.8843-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <f78519ee-cb48-2c2a-91eb-e506a361d5b6@perex.cz>
Date: Fri, 22 Jan 2021 18:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210122144842.8843-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
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

Dne 22. 01. 21 v 15:48 Takashi Iwai napsal(a):
> Hi,
> 
> here is the fixes for a crash with dmix plugin and co, as well as the
> missing appl_ptr/hw_ptr updates that are found on other plugins.

It looks all correct. Dunno why it passed this in my tests. I applied all
changes to alsa-lib's repo.

				Thank you,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
