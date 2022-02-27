Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2707C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Feb 2022 07:48:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31D821753;
	Sun, 27 Feb 2022 08:48:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31D821753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645948134;
	bh=vNcLeXLbN6YTbMdOPHqCFreWCkdTul0KQGs9pPL/tPM=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QYxE6hSjKzjAXlGNMr+cTtIAg8ZQOJrkMOdWQSsWatPP/9jh3K2Y9jjqGyPfOOT1i
	 +y9DwWRydKGvX9NNY4R2jyKr7jxq7qywbjfw0bTJGNF9krCxVjzcttQquu4TU9W3+7
	 /DUBaB+TbZq1cJ0K0dRip5qmv8zD/rM3+NABcm+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9641F80137;
	Sun, 27 Feb 2022 08:48:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CA95F80155; Sun, 27 Feb 2022 08:48:01 +0100 (CET)
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.37])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FFBAF800B6
 for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2022 08:47:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FFBAF800B6
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay09.hostedemail.com (Postfix) with ESMTP id 74D81220DE;
 Sun, 27 Feb 2022 07:47:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf14.hostedemail.com (Postfix) with ESMTPA id 173C72F; 
 Sun, 27 Feb 2022 07:47:31 +0000 (UTC)
Message-ID: <5aae43769bced6d5c17f143332004285af6d1c4d.camel@perches.com>
Subject: Re: [PATCH 1/2] ALSA: core: remove initialise static variables to 0
From: Joe Perches <joe@perches.com>
To: Meng Tang <tangmeng@uniontech.com>, perex@perex.cz, tiwai@suse.com
Date: Sat, 26 Feb 2022 23:47:51 -0800
In-Reply-To: <20220227071253.28193-1-tangmeng@uniontech.com>
References: <20220227071253.28193-1-tangmeng@uniontech.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8xnixydnu3zmz4hwsd8h1xfo3msdj6f6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 173C72F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+2xEQu8yUXGYkYqv//dyUnZLZR68nqb9I=
X-HE-Tag: 1645948051-399840
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Sun, 2022-02-27 at 15:12 +0800, Meng Tang wrote:
> Initializing the static variable to 0 causes the following error
> when exec checkpatch:
> 
> ERROR: do not initialise statics to 0
> FILE: sound/sound_core.c:142:
> static int preclaim_oss = 0;
> 
> Static variable does not need to be initialised to 0, because
> compiler will initialise all uninitialised statics to 0. Thus,
> remove the unneeded initializations.
[]
> diff --git a/sound/sound_core.c b/sound/sound_core.c
[]
> @@ -139,7 +139,7 @@ struct sound_unit
>  #ifdef CONFIG_SOUND_OSS_CORE_PRECLAIM
>  static int preclaim_oss = 1;
>  #else
> -static int preclaim_oss = 0;
> +static int preclaim_oss;
>  #endif

Probably better without the #ifdef / #else / #endif as

static int preclaim_oss = IS_ENABLED(CONFIG_SOUND_OSS_CORE_PRECLAIM);


