From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix memory leaks for the
	CS4270 driver
Date: Thu, 04 Sep 2008 10:54:28 -0500
Message-ID: <48C004B4.2000208@freescale.com>
References: <1220479634-26912-1-git-send-email-timur@freescale.com>
	<s5hd4jko0p2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A6CAD2440E
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 17:55:39 +0200 (CEST)
In-Reply-To: <s5hd4jko0p2.wl%tiwai@suse.de>
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

> - In cs4270_remove(), cs4270_i2c_detach() is called after
>   snd_soc_free_pcms().  snd_soc_free_pcms() invokes snd_card_free()
>   inside, and this releases the all resources already, including the
>   control elements.  That is, you free an already-freed item.

I was wondering why so few drivers were calling snd_ctl_remove().  :-)

>   Well, looking the code again, you create only one element, and if
>   this fails, there is no other remaining element.  Thus, there is
>   nothing to free there.

True, but I intend on adding more controls in the future, so I want to code to
handle that automatically.

> 
> - The way you look for a kcontrol is wrong although it may work in
>   practice.  A usual way is to remember the kctl and use it for
>   removal, or find the kctl via snd_ctl_find_id(), not _numid().

It would be nice if snd_kcontrol_new had a snd_kcontrol *.  I could use it to
store the pointer for later deallocation.  Would you accept a patch to add that?

> - Your patch merged in the ALSA tree already would conflict with this
>   patch.  This is a mess, results in the whole rebase of git tree.

What, wait other patch?  I based this patch on
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git.  It should
apply cleanly on that repo.

> So, I think the code in 2.6.27 tree can stay as is.  There is no leak
> in the end.  But, we can fix cs4270.c in the latest ALSA tree,
> e.g. add a missing remove callback to release codec->reg_cache.

I'm confused, because I thought I was fixing the latest ALSA tree.

-- 
Timur Tabi
Linux kernel developer at Freescale
