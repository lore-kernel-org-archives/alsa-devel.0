From: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
Subject: Re: [PATCH] snd-hda-intel: Jack Mode changes for
	Sigmatel boards
Date: Fri, 29 May 2009 13:16:55 +0000
Message-ID: <4A1FE047.5050300@gmail.com>
References: <4A13F91D.8010102@gmail.com>	<s5hvdnp5wdv.wl%tiwai@suse.de>	<4A1AEF14.1090608@gmail.com>	<s5hy6sj9fl0.wl%tiwai@suse.de>	<4A1D4AB0.40904@gmail.com>
	<s5hy6sgv2cd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 00F0F24629
	for <alsa-devel@alsa-project.org>;
	Fri, 29 May 2009 22:07:31 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so4312606yxn.2
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2009 13:07:31 -0700 (PDT)
In-Reply-To: <s5hy6sgv2cd.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> That looks good.  Could you complete the patch, then let's merge
> first?  We can tune up later after the merge (if any).
>
>
> thanks,
>
> Takashi
>
>   
Will do.  I've also changed stac92xx_get_vref() to
stac92xx_get_default_vref() to hopefully avoid confusion with
vref_get().  I'll be posting the (hopefully) final version of this patch
shortly.

Thanks for all your help,
Nick
