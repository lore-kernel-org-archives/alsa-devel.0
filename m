Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFB0ECAAD3
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 13:18:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45C8C847;
	Mon, 19 Sep 2022 15:17:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45C8C847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663593506;
	bh=UgckQnmQL/nVuNdWZTUA13EG0Ql67PagNgE7TaO8njM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aq1rKAV9CXp+MRQ/LUc8sK5QhkvXMzPo3y/ncj8whvDpIA1dBmSqBtuCFItcJ0SEF
	 utPYVD8D0/bwcDAUDP73GQMIF4ST2mfH4JU6De+Sj01Uo6hzqnScrJiPBWKW2wbavL
	 goiiRCGXTNZo9Z9eBazcKUvpDgY+g5sEUbxg5PDQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9390F8016D;
	Mon, 19 Sep 2022 15:17:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1009F8023A; Mon, 19 Sep 2022 15:17:33 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2B74F80134
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 15:17:27 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D4A5BA003F;
 Mon, 19 Sep 2022 15:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D4A5BA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1663593446; bh=tvHwleJujRGiUEH/OfL0nVlJAMpPYSh2u3+nTAIKoRw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=u2HPlnuBsZuik2U7Sg+p6eWzHxTLZmz9TU1/q0EudXzFr3wFp8uyIVMQZnSwJe95Q
 0+DAle5tTvJRbJggKZmq8LlA40GrFgtvgwecKpQ6R7ilf/jDTxu3PvEeKWA0kZbf0T
 WM/6jpPf/W0VzkRsZa+YEcaxU/9k+utayvQiqy3g=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 19 Sep 2022 15:17:23 +0200 (CEST)
Message-ID: <a846e337-fd8c-f2bd-431f-348900b6f382@perex.cz>
Date: Mon, 19 Sep 2022 15:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: hda/hdmi: Fix the converter reuse for the silent
 stream
Content-Language: en-US
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20220913070216.3233974-1-perex@perex.cz>
 <alpine.DEB.2.22.394.2209191430310.2722275@eliteleevi.tm.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <alpine.DEB.2.22.394.2209191430310.2722275@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>
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

On 19. 09. 22 13:33, Kai Vehmanen wrote:
> Hi,
> 
> sorry for the late review (as Takashi already applied).
> 
> On Tue, 13 Sep 2022 09:02:16 +0200, Jaroslav Kysela wrote:
>> When the user space pcm stream uses the silent stream converter, it is no
>> longer allocated for the silent stream. Clear the appropriate flag in the
>> hdmi_pcm_open() function. The silent stream setup may be applied in
>> hdmi_pcm_close() (and the error path - open fcn) again.
> 
> Jaroslav, did you hit a real-life problem with a particular sequence? The 
> converter allocation was done in a sticky fashion on purpose. The silent 
> stream setup (clearing KAE and/or letting codec to power down) was only 
> released if the receiver is disconnected from the system. I.e. no actions 
> were done in PCM close (on purpose).

Thank you for your comments.

I just wrote a small test utility which shows the bad converter use:

https://gist.github.com/perexg/4977fcb33101148e578c34bd25db8ce4

For the first use (with one monitor connected) I can open 4 HDMI PCM devices,
but later, only 3 HDMI PCM devices can be opened, because the converter
allocation code (3 converters in my case) does a wrong job.

I though that the silent stream is turned off when new S/PDIF frame parameters 
are applied, but it seems that this setup is independent as you noted.

> Now if there were issues, I wonder whether we should modify the pcm_close 
> instead, and avoid some of the cleanup in this case, as a better fix.

Yes, I think that we should add a new silent_stream flag to struct 
hdmi_spec_per_cvt and do not set assigned in this struct when the silent 
stream is managed. The assigned flag should be used only for open/close calls 
to track the used converters correctly. Does it sound right for you?

> I think your patch will create a new problem: - receiver A connected to CVT
> X - silent stream enabled for X - app opens a PCM, connected to A+X, silent
> stream disabled - receiver A disconnected -> actions in
> silent_stream_disable() not run correctly for CVT X

Definitely. The silent stream setup won't be deactivated with this simple patch.

					Jaroslav



-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
