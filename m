From: Steven Zakulec <spzakulec@mail.widener.edu>
Subject: [Fixed-Mostly] ALC268
Date: Fri, 6 Jul 2007 10:04:58 -0400 (EDT)
Message-ID: <10305193.1183730698546.JavaMail.root@ccprodapp11.campuscruiser.com>
Reply-To: Steven Zakulec <spzakulec@mail.widener.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ccprodapp11.campuscruiser.com (email.campuscruiser.com
	[216.35.68.59]) by alsa0.perex.cz (Postfix) with ESMTP id 579351038F7
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 16:05:00 +0200 (CEST)
Received: from ccprodapp11 (localhost.localdomain [127.0.0.1])
	by ccprodapp11.campuscruiser.com (8.13.1/8.13.1) with ESMTP id
	l66E4waW013608
	for <alsa-devel@alsa-project.org>; Fri, 6 Jul 2007 10:04:58 -0400
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
List-Id: alsa-devel@alsa-project.org

I was finally able to get sound working, thanks to the bugreport here: https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3104

What I did was get the patch_realtek.c from the bugreport, put it in alsa-kernel/pci/hda, and then re-build the driver (plus I re-built the lib, but probably not necessary).  I wasn't able to rmmod snd-hda-intel after the build finished, so I restarted the computer, and then it just worked.

Unfortunately, the headphone jack is not working.  The sound is only slightly, if at all, muted from the speakers when the headphones are plugged in.
