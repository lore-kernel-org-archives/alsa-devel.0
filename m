From: Nicola Fagnani <nicfagn@iol.it>
Subject: Re: Recent code changes for HD-audio on HG repo
Date: Thu, 16 Aug 2007 14:21:39 +0200
Message-ID: <1717EBB5-F362-4767-8D40-BFE2E17AFA9C@iol.it>
References: <1187217195.12267.38.camel@nic-desktop>
	<s5hk5rviy0v.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out1.libero.it (smtp-out1.libero.it [212.52.84.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C5B31038C7
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 14:21:42 +0200 (CEST)
Received: from localhost (172.31.0.47) by smtp-out1.libero.it (7.3.120)
	id 4688F31703CD4CF1 for alsa-devel@alsa-project.org;
	Thu, 16 Aug 2007 14:21:41 +0200
Received: from smtp-out2.libero.it ([172.31.0.38])
	by localhost (asav-out6.libero.it [192.168.32.34]) (amavisd-new,
	port 10024)
	with ESMTP id RZX57j+Sk6w9 for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 14:21:40 +0200 (CEST)
Received: from MailRelay10.libero.it (192.168.32.119) by smtp-out2.libero.it
	(7.3.120) id 46A743AE011C8EE4 for alsa-devel@alsa-project.org;
	Thu, 16 Aug 2007 14:21:40 +0200
In-Reply-To: <s5hk5rviy0v.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> Are you sure that you passed power_save_controller=0, not
> power_save=0?  See below.
>

Yes, I set power_save_controller=0. This should have disabled the  
power save
timeout, preventing the call of azx_stop_chip().

> OK, it's an Intel Mac, right?  Then maybe the culprit is the missing
> GPIO initialization.  It's done only at creation time.
> Did you get the PM suspend/resume working with this machine?
> I guess you'll have the same problem, too.
>

Right, I forgot that initialization and in fact the sound never  
worked after a
suspend.

> Anyway, try the patch below.  Hopefully it fixes the power-save
> problem too.

Yes, it does. :-) Great work!
It fixes suspend too :-D

Thanks very much

Nicola Fagnani
