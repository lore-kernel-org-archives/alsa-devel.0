From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH] ALSA: hda - limit mic boost on Asus UX31[A, E]
Date: Wed, 27 Nov 2013 18:59:36 +0100
Message-ID: <52963308.9090400@rempel-privat.de>
References: <1385568723-4412-1-git-send-email-linux@rempel-privat.de>
 <s5hd2ll6cns.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5141F265090
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 18:59:39 +0100 (CET)
Received: from [192.168.1.138] ([93.218.116.213]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0Mg3h3-1VyA193mRZ-00NToZ for
 <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 18:59:38 +0100
In-Reply-To: <s5hd2ll6cns.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 27.11.2013 17:18, schrieb Takashi Iwai:
> At Wed, 27 Nov 2013 17:12:03 +0100,
> Oleksij Rempel wrote:
>>
>> This both devices need limit for internal dmic.
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> 
> Ah, you have this Zenbook.  While I'll take your patch, yet a
> counter-question to you:
> 
> I got a bug report complaining that the output level on this (or
> similar) machine is too low compared with Windows.  Is it so on yours,
> too?

I'll check it ASAP ;)

> If so, does the patch below make the level equivalent?
> The reporter isn't responsive, so need more better testing...
> 
> BTW, I'd suggest to name the new fixup in your patch as
> ALC269VB_FIXUP_ZENBOOK (or ALC269VB_FIXUP_ASUS_ZENBOOK) as my patch
> does.
> 
> 
> thanks,
> 
> Takashi


-- 
Regards,
Oleksij
