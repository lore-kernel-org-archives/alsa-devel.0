Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D91C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jan 2022 09:20:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5770A3180;
	Wed, 19 Jan 2022 10:19:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5770A3180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642584039;
	bh=TPtnHj/P3BtQ3St7R+JcxInvA0hrLwoknRLB80UYop8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J26XrueAUoapH9dmn33BbAdNAJTUvBq7rzSYseoZ7zWkj9oAI6kzjYkHjL4MIaU94
	 o4cngHrIcyUI0JL9QTeYTnSIT7AsME5IJdaQIFnthSxbyGo30L/LjFn0i8RcshgvyC
	 wYNTwuliEQnfoViLOMKb9kemlfdLtQijf+HravcU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA50CF80162;
	Wed, 19 Jan 2022 10:19:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1CD0F800F8; Wed, 19 Jan 2022 10:19:47 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8807FF800F8
 for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2022 10:19:42 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 83055A0046;
 Wed, 19 Jan 2022 10:19:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 83055A0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1642583979; bh=HFHEMbI3FJBXoZSh7kY+uFOQtESBi9Y/PqSpzp/h/VA=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=eS0Iv8ilOjeVZi+ttuLxFWzp8O3b8xabD7jQqOJXyiiA85o0Q1B+Y7IVes4o/lEgB
 kIai8eCXVexKlkf40ODXSYQqoQdzzdZeubOd3uXZ8S0H7V/cOLXinxMGDCA0ksW7a4
 pYoo4OfTsed+gZwF6c/FZujMH20I0kBEdIXuCNC8=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 19 Jan 2022 10:19:37 +0100 (CET)
Message-ID: <fa03088c-7f98-736b-a9f3-0235119b5c60@perex.cz>
Date: Wed, 19 Jan 2022 10:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ALSA: core: Simplify snd_power_ref_and_wait() with the
 standard macro
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20220119091050.30125-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220119091050.30125-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 19. 01. 22 10:10, Takashi Iwai wrote:
> Use wait_event_cmd() macro and simplify snd_power_ref_wait()
> implementation.  This may also cover possible races in the current
> open code, too.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

Thanks.

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
