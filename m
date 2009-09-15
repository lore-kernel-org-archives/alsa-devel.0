From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 3/6] ak4113 support
Date: Tue, 15 Sep 2009 13:54:28 +0200
Message-ID: <4AAF8074.6000008@ivitera.com>
References: <1252968303-29334-1-git-send-email-pavel.hofman@ivitera.com>	<1252968303-29334-2-git-send-email-pavel.hofman@ivitera.com>	<1252968303-29334-3-git-send-email-pavel.hofman@ivitera.com>
	<s5hpr9sbgrt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 93B2410385A
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Sep 2009 13:54:07 +0200 (CEST)
In-Reply-To: <s5hpr9sbgrt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 15 Sep 2009 00:45:00 +0200,
> pavel.hofman@ivitera.com wrote:
>> +MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
> 
> You are the author, no?

Well, it was mostly copy/paste/modify from ak4114/7. OK, I will be the
author :) I will send the patch in the evening.
> 
>> +EXPORT_SYMBOL(snd_ak4113_create);
> 
> Use EXPORT_SYMBOL_GPL() for new stuff, unless any reason given.
> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
