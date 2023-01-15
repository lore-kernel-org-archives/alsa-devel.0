Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8200C3DA78
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Jan 2023 17:41:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D93941633;
	Sun, 15 Jan 2023 18:40:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D93941633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673804472;
	bh=b0c4SisGOxXTZv+SqlAq3EVXxnbaGRSwkRGwqq/AE24=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=IhlGlteU9jxseNhixYkvwjkJurq1HeWGJWcZjaEEFIPXvFXSX/ZhCL8OD3ur8MWS+
	 10N8M9sTbYcXNgD/YmqyzUyP2FekG4UCO7IS2kxNLF0eGqoHfjuUgXxu39uIFBZUCd
	 eIvym6PPllVdFFTMkYCxRoiFtcgAwxjzf6r9cGgo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 953E7F804BC;
	Sun, 15 Jan 2023 18:40:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22F33F804DE; Sun, 15 Jan 2023 18:40:21 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93481F801EB
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2023 18:40:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93481F801EB
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 secure) header.d=perex.cz header.i=@perex.cz header.a=rsa-sha256
 header.s=default header.b=Df4CAiol
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BCF6BA003F;
 Sun, 15 Jan 2023 18:40:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BCF6BA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1673804415; bh=+4MyiBBI3+rHdJSz/uu81wyClilJEo0vJjFAH+YodTg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Df4CAiolb94HU6i950Domc0gUOnpP53+bSHIqS1g3/E28iAqRCKYMW89kCmTQyunS
 SBL1YYLVcfDgyYRsLIinjcNrCn9vs/rVbwRkSZBTJWCRiCqbxrpZmJMjoljUq3eZhy
 aXCZVo3vRVrNwgV/loV7wwC/UPEFh1/uRThf1Up0=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun, 15 Jan 2023 18:40:12 +0100 (CET)
Message-ID: <944b3ca8-27fb-01da-a2b0-77b15d7422f9@perex.cz>
Date: Sun, 15 Jan 2023 18:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] ucm: add existence checks to geti calls
Content-Language: en-US
To: cujomalainey@chromium.org, alsa-devel@alsa-project.org
References: <20230113185019.1500147-1-cujomalainey@chromium.org>
 <20230113212155.2108905-1-cujomalainey@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230113212155.2108905-1-cujomalainey@chromium.org>
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

On 13. 01. 23 22:21, cujomalainey@chromium.org wrote:
> From: Curtis Malainey <cujomalainey@chromium.org>
> 
> Right now in snd_use_case_geti you cannot tell if the item being queried
> exists or not when being checked. This also means the only way to check
> for the existence of something in the client of the library is to
> iterate over the list of mods/devs even if we know exactly the name we
> are looking for. We have functions that do exactly this internally so
> lets return this information in a logical fashion through geti.

Thanks. I applied your code and and pushed a cleanup + fix on top:

https://github.com/alsa-project/alsa-lib/commit/c083417b723a3485657234a21da3264419da1411

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
