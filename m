From: Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Date: Wed, 1 Sep 2004 09:37:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <OFCD90FFE9.E98FB2D7-ON86256F02.00505992-86256F02.00505A16@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266777AbUIAOiL@vger.kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Ok, the second try.

This patch appears to work well. No snd_es1371 traces in over 25 minutes
of testing (I had a couple hundred yesterday in similar tests). The sound
was OK as well.

I am seeing some additional CPU overhead during the disk I/O tests with
today's kernel but I don't think this is due to this patch.

Thanks.
  --Mark
