Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A5AC3DA78
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Jan 2023 19:33:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A701AFD3;
	Fri, 13 Jan 2023 20:32:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A701AFD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673638411;
	bh=5WbftOTuLkrCIPJ10SJwRiyxCbE/YtIQUpRn3O7eJXA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jgAoBTXMttOIkdv9PCIfAOkW7u1ShAMCrNuLhjSh3qPYY+iMKrRnfnl6fgCg3ybrX
	 XY4R8rMaCH8BX8o6qlt/gkxbuZ05UPlp41AOApMx2DVqGFgOV8GsYQ+Agpmg3Azljp
	 Ooee4YvguMinKCW2GwODJieb20qMw6oubKHdLmQE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B391F8019B;
	Fri, 13 Jan 2023 20:32:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E74F6F8030F; Fri, 13 Jan 2023 20:32:39 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A8EAF8019B
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 20:32:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A8EAF8019B
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 secure) header.d=perex.cz header.i=@perex.cz header.a=rsa-sha256
 header.s=default header.b=yxPBUx6T
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A9953A0042;
 Fri, 13 Jan 2023 20:32:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A9953A0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1673638356; bh=tSWL9tjFBugMvI9x8edoDFF0brsGiAMYV6j6lcYujNY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yxPBUx6TlU0laDBR99d3WvnLB5+XZ7e380JiVdVWJKJ54yUxJGpz69LH5++ggmu15
 Xpqhlp7F6809J05s8jbHqkvmBi1/TEQribrTtC0Q5MlogmCQIew8fiele/7TDS5Kip
 J8AnrVW05uUZJ88VtompCxj/8iVABZ2IQF2W7HPY=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 13 Jan 2023 20:32:33 +0100 (CET)
Message-ID: <43beedbe-05e4-1c11-a27a-b2e3ca002935@perex.cz>
Date: Fri, 13 Jan 2023 20:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] ucm: add existence checks to geti calls
Content-Language: en-US
To: cujomalainey@chromium.org, alsa-devel@alsa-project.org
References: <20230112234426.1714071-1-cujomalainey@chromium.org>
 <20230113185019.1500147-1-cujomalainey@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230113185019.1500147-1-cujomalainey@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: tiwai@suse.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 13. 01. 23 19:50, cujomalainey@chromium.org wrote:
> From: Curtis Malainey <cujomalainey@chromium.org>
> 
> Right now in snd_use_case_geti you cannot tell if the item being queried
> exists or not when being checked. This also means the only way to check
> for the existence of something in the client of the library is to
> iterate over the list of mods/devs even if we know exactly the name we
> are looking for. We have functions that do exactly this internally so
> lets return this information in a logical fashion through geti.

The device_status/modifier_status functions are used internally, too.
I would add the device validation only to the geti code. The other parts do 
this job already and expect just 0 or 1 return values.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
