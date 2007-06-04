From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: Fix prototype
 for	snd_soc_dai_link.init() function pointer
Date: Mon, 04 Jun 2007 11:44:51 -0500
Message-ID: <46644183.9090109@freescale.com>
References: <11807378971701-git-send-email-timur@freescale.com>
	<s5hmyzgau3t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B04B2459C
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2007 18:44:57 +0200 (CEST)
In-Reply-To: <s5hmyzgau3t.wl%tiwai@suse.de>
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
> At Fri,  1 Jun 2007 17:44:57 -0500,
> Timur Tabi wrote:
>> Change the snd_soc_dai_link.init() function to take a pointer to the
>> corresponding snd_soc_dai_link structure, instead of a pointer to a
>> snd_soc_codec structure.  This allows the initialization function to initialize
>> its own structure.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> Liam, is this change OK for you?
> If yes, I'll add this to HG tree after 1.0.14 release.

Please note my comment in the patch.  I have not compiled all the code that I changed, so 
I don't know if this patch is good.  I would like someone to test this patch.

This patch is just a refactoring - no new features have been added, so after applying this 
patch, everything should still compile and run exactly the same.

The key code changes are:

	struct snd_soc_codec *codec = dai->codec_dai->codec;

I'm hoping that 'codec' contains the same value that it did before the patch, and

	err = socdev->machine->dai_link[i].init(&machine->dai_link[i]);

I hope this passes the correct snd_soc_dai_link pointer.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
