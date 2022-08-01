Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ECEC00144
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Aug 2022 08:07:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C34615C1;
	Mon,  1 Aug 2022 10:06:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C34615C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659341221;
	bh=pub1nvs11OUsZrCFydwG/XuMAmavxVE8EPiptpv8kaI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SuMEHvzYnNkGcwYPymCwi63asBud01yZYeKF7DJT2rUb/0M9ybNAcO3DOUdgTNZbI
	 Zog73FsWLRNW3Qz1xbRfPlbiuUqoQcpWfjtuWi3r/PblPeioiXYHsdsSU7mXT2JTNU
	 CVUnNrlcVfNNDGEY5oNejypzBmSkwKVO3jdx4g24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2613F8014B;
	Mon,  1 Aug 2022 10:06:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84FBBF8023B; Mon,  1 Aug 2022 10:06:09 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52FEAF8014B
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2022 10:06:02 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A545EA003F;
 Mon,  1 Aug 2022 10:06:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A545EA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1659341161; bh=3J/kOVwU4fQAKASQsvZDw4vyr/BBehpMcs4SDD/Zt/k=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=bYdfh+v3myoFgXMciYv4Qn5RXPa0vSC3RSChGR7zYfBYsGPVFRA9Sk8CG/Gb2e2L8
 ij09JOuAZlvy6cp7SlzkZsi7K/ppPu+S9CWkssoa+FFLlB9gTKR3uvV2Bh20Ng60/J
 aFVA/Bl3US4SCbHrOBChp5T7PoHUIMKg3mhlgruU=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  1 Aug 2022 10:05:59 +0200 (CEST)
Message-ID: <e903d8ac-7575-77f6-2d6b-a787ea3ec0bb@perex.cz>
Date: Mon, 1 Aug 2022 10:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] ALSA: core: Add async signal helpers
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20220728125945.29533-1-tiwai@suse.de>
 <20220728125945.29533-2-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220728125945.29533-2-tiwai@suse.de>
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

On 28. 07. 22 14:59, Takashi Iwai wrote:
> Currently the call of kill_fasync() from an interrupt handler might
> lead to potential spin deadlocks, as spotted by syzkaller.
> Unfortunately, it's not so trivial to fix this lock chain as it's
> involved with the tasklist_lock that is touched in allover places.
> 
> As a temporary workaround, this patch provides the way to defer the
> async signal notification in a work.  The new helper functions,
> snd_fasync_helper() and snd_kill_faync() are replacements for
> fasync_helper() and kill_fasync(), respectively.  In addition,
> snd_fasync_free() needs to be called at the destructor of the relevant
> file object.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

...

> +void snd_kill_fasync(struct snd_fasync *fasync, int signal, int poll)
> +{
> +	unsigned long flags;
> +
> +	if (!fasync || !fasync->on)
> +		return;
> +	spin_lock_irqsave(&snd_fasync_lock, flags);
> +	fasync->signal = signal;
> +	fasync->poll = poll;
> +	list_move(&fasync->list, &snd_fasync_list);
> +	schedule_work(&snd_fasync_work);
> +	spin_unlock_irqrestore(&snd_fasync_lock, flags);
> +}

The schedule_work() may be called outside the spinlock - it calls 
queue_work_on() / __queue_work() which has already own protection for the 
concurrent execution.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
