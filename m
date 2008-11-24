From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: CVS, git, or something else? Build patch failure.
Date: Tue, 25 Nov 2008 12:47:27 +1300
Message-ID: <200811251247.27296.linux@audioscience.com>
References: <200811242310.29792.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 11D82244C1
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 00:47:31 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KAV009K03F2WZ10@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 25 Nov 2008 12:47:27 +1300 (NZDT)
In-reply-to: <200811242310.29792.maillist@superlative.org>
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Keith A. Milner" <maillist@superlative.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 25 November 2008 12:10:29 Keith A. Milner wrote:
> I've been trying to check out the latest alsa-driver source to do some work
> on it. I followed the instructions at:
> http://www.alsa-project.org/main/index.php/GIT_Server#Occasional_Developers
>
> But when I cd alsa-drivers and gitcompile, it fails:
>
> make[1]: Entering directory
> `/homedirs/kamilner/Development/Workspace/alsa/alsa-driver/acore'
> copying file alsa-kernel/core/init.c
> patching file init.c
> Hunk #2 succeeded at 280 (offset 3 lines).
> Hunk #3 succeeded at 306 (offset 3 lines).
> Hunk #4 FAILED at 568.
> 1 out of 4 hunks FAILED -- saving rejects to file init.c.rej
> make[1]: *** [init.c] Error 1
> make[1]: Leaving directory
> `/homedirs/kamilner/Development/Workspace/alsa/alsa-driver/acore'
> make: *** [dep] Error 1

I see this too. My kernel: ubuntu 2.6.24-21-generic

Heres the .rej file.

***************
*** 552,560 ****
  		return -EINVAL;
  #ifndef CONFIG_SYSFS_DEPRECATED
  	if (!card->card_dev) {
  		card->card_dev = device_create(sound_class, card->dev,
  					       MKDEV(0, 0), NULL,
  					       "card%i", card->number);
  		if (IS_ERR(card->card_dev))
  			card->card_dev = NULL;
  	}
--- 568,586 ----
  		return -EINVAL;
  #ifndef CONFIG_SYSFS_DEPRECATED
  	if (!card->card_dev) {
+ #ifdef CONFIG_SND_HAS_DEVICE_CREATE_DRVDATA
+ 		card->card_dev = device_create_drvdata(sound_class, card->dev,
+ 						       MKDEV(0, 0), NULL,
+ 						       "card%i", card->number);
+ #elif LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27)
  		card->card_dev = device_create(sound_class, card->dev,
  					       MKDEV(0, 0), NULL,
  					       "card%i", card->number);
+ #else
+ 		card->card_dev = device_create(sound_class, card->dev,
+ 					       MKDEV(0, 0),
+ 					       "card%i", card->number);
+ #endif
  		if (IS_ERR(card->card_dev))
  			card->card_dev = NULL;
  	}

>
> Do I have the right version? Am I going about this the right way? I see a
> lot of posts on this list talking about CVS but none mentioning git.
>
> Maybe I should be using CVS instead?

No. git is right.



-- 
--
Eliot Blennerhassett
www.audioscience.com
