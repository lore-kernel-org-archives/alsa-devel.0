From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Build patch failure.
Date: Tue, 25 Nov 2008 13:45:53 +1300
Message-ID: <200811251345.53742.linux@audioscience.com>
References: <200811242310.29792.maillist@superlative.org>
	<200811251247.27296.linux@audioscience.com>
	<200811242356.52786.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id EFEEB244EA
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 01:45:54 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KAV002HF64FFO50@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 25 Nov 2008 13:45:52 +1300 (NZDT)
In-reply-to: <200811242356.52786.maillist@superlative.org>
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
Cc: Takashi Iwai <tiwai@suse.de>, "Keith A. Milner" <maillist@superlative.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 25 November 2008 12:56:52 Keith A. Milner wrote:
> On Monday 24 November 2008 23:47:27 Eliot Blennerhassett wrote:
> > I see this too. My kernel: ubuntu 2.6.24-21-generic
>
> I'm on Mandriva kernel version 2.6.24.7
>
> > No. git is right.
>
> Thank you very much for confirming this. I thought I was missing something,
> but I couldn't see what.
>
> I believe the kernerl version shouldn't matter as this error occurs when
> trying to apply a patch to one of the main files. I guess we have to sit
> tight for someone to fix this, or just delete and ignore the patch file for
> now?

I applied the rejected part of the patch manually.
(cp init.c.orig init.c; patch init.c init.patch;  edit init.c and apply 
init.c.rej manually)

But now have another reject in hda_beep.c (if you aren't building for 
intel-hda this might not affect you).
Well I fixed this manually and now all OK.

Heres the .rej for hda_beep.c

***************
*** 87,93 ****
  		return -ENOMEM;
  	snprintf(beep->phys, sizeof(beep->phys),
  		"card%d/codec#%d/beep0", codec->bus->card->number, codec->addr);
  	input_dev = input_allocate_device();
  
  	/* setup digital beep device */
  	input_dev->name = "HDA Digital PCBeep";
--- 93,103 ----
  		return -ENOMEM;
  	snprintf(beep->phys, sizeof(beep->phys),
  		"card%d/codec#%d/beep0", codec->bus->card->number, codec->addr);
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 15)
  	input_dev = input_allocate_device();
+ #else
+ 	input_dev = kzalloc(sizeof(*input_dev), GFP_KERNEL);
+ #endif
  
  	/* setup digital beep device */
  	input_dev->name = "HDA Digital PCBeep";


cheers


-- 
--
Eliot Blennerhassett
www.audioscience.com
