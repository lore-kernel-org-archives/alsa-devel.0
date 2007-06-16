From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: pcm->private_data is NULL in alsa core!!
Date: Sat, 16 Jun 2007 18:20:46 +0530
Message-ID: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id C95FF1038DB
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 14:50:49 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1548483wag
	for <alsa-devel@alsa-project.org>; Sat, 16 Jun 2007 05:50:46 -0700 (PDT)
Content-Disposition: inline
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

Hi
I am writing an alsa driver for my omap based board. I am testing it using
cat /dev/audio currently, i.e. I have OSS emulation turned on. This is
an initial round of testing and I will use alsa-libs and utils later.

My problem is:

I have set the pcm->private_data = my_chip after registering the pcm ops,
after referring various standard drivers in alsa tree. My module is
insmoded properly but after I do snd_card_register(card) the
pcm->private_data is corrupted !! Before this step, the
pcm->private_data is intact.  But after looking at the
snd_card_register(), I realized that it doesn't even touch the pcm
pointer.

So, when I cat the device I get huge segfault in
snd_pcm_attach_substream(), since pcm->private_data is NULL but
surprisingly all the other fields are intact in pcm pointer.

 Even the OSS code doesn't touch the pcm pointer, what must be wrong?
I have checked my source atleast 5 times and couldn't find anything in it.

-pharaoh.
