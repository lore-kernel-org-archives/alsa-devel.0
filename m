Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18D3C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 06:39:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5A561027
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 06:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F5A561027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D67D82B;
	Wed, 13 Oct 2021 08:38:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D67D82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634107186;
	bh=5bwBHR5Elp1oZe5rAH33D6SLwcdsSK31gCIT2of7qAY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IN5LsZXy7sVK9wBZy+b3KZedS/0TlyCOPJ4RXVrPj7dnOWX11QWTKj+JP9HhFT4Uc
	 sse9p2Cz+vNHqaT0EXHpjwjnRiRSDh5GJqcxSOM6ikkV8vVcskicUfOzP38fyA+U6C
	 /gzlKmV1b4PPwJM7p/ua9xaG0pCuinQQF67gyc9Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6C40F8025B;
	Wed, 13 Oct 2021 08:38:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0CD8F80269; Wed, 13 Oct 2021 08:38:52 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61551F800C0
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 08:38:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61551F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="oJAbfZUc"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="gN0WBiJz"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id D5B4AA1A3D404;
 Wed, 13 Oct 2021 08:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1634107117; bh=5bwBHR5Elp1oZe5rAH33D6SLwcdsSK31gCIT2of7qAY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=oJAbfZUc5fAS3YF31GrSE9kKv8gEgdeFnEv0ZJo0mgLGpsp3di1kUeoWr7Wcq6Z96
 Huoh+jx2wdnv+YI/F8D2xlTd7bJTKfQCubdUecOBQLK6rLQWydrBtCuZihn9yS//c4
 QaFMCiTuGr1TjmvwcvV5z2x4SLX7vq9koXpoyIgI=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IrTup0aSq7u1; Wed, 13 Oct 2021 08:38:32 +0200 (CEST)
Received: from [192.168.105.22] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 694EAA1A3D403;
 Wed, 13 Oct 2021 08:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1634107112; bh=5bwBHR5Elp1oZe5rAH33D6SLwcdsSK31gCIT2of7qAY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=gN0WBiJzRZ9SmLX4Ye9E+O3KSHYcp82uGEwfxtw34f6wK3jqKlQWDQ+achU7hyV9T
 R4c6y790GEIkSXidT8s7wBtefM2dOk43rbw+ezUqsIbwdGJpiNB7B2t7y+gc/Y0P5b
 k4sCfBFpBC71MY03MUwXFC30ozqsKlUEmXuMZfO0=
Subject: Re: Alsaloop: sync mode PLAYSHIFT + Loopback on playback side
To: Jaroslav Kysela <perex@perex.cz>
References: <a87670e2-302b-8408-cdc2-f0f010646fdc@ivitera.com>
 <958623cd-7d0d-5329-567b-74edbbf0c16d@perex.cz>
 <b18c5b00-e3a8-14d1-15aa-c7d7c577530d@ivitera.com>
 <2ad744ed-5618-0ea0-e2a4-b919ee9dfeeb@perex.cz>
 <c9804070-e520-24e5-d5a7-9ba7e2bb8abe@ivitera.com>
 <36b2762f-8527-639c-274c-3efa40562eab@perex.cz>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <4713a882-fbf5-5b53-a846-22028f9fb51e@ivitera.com>
Date: Wed, 13 Oct 2021 08:38:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <36b2762f-8527-639c-274c-3efa40562eab@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: ALSA development <alsa-devel@alsa-project.org>
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

Hi Jaroslav,

Dne 05. 10. 21 v 10:58 Jaroslav Kysela napsal(a):
> On 04. 10. 21 16:32, Pavel Hofman wrote:
> 
>>
>> +static int openctl_play_rateshift(struct loopback_handle *lhandle,
>> +            char *ascii_name) {
> 
> I would create 'openctl_elem_ascii' function which will accept the ascii 
> id and the snd_ctl_elem_value_t pointer like 'openctl_elem' does. The 
> the common code may be moved to the 'openctl_elem_id' function from the 
> 'openctl_elem' function.
> 
> But it's just nitpicking, the rest of patch looks fine and follows my 
> suggestion. Thank you.
> 

Thanks for your recommendations. I sent the v2 patch in 
https://patchwork.kernel.org/project/alsa-devel/patch/20211005194903.7957-1-pavel.hofman@ivitera.com/ 
. Please is it OK now or should I make some more changes?

Thanks a lot,

Pavel.
