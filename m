From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Date: Tue, 31 Aug 2004 20:50:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040831185054.GC25485@elte.hu>
References: <OF923A124A.1D8E364E-ON86256F01.0053F7B2-86256F01.0053F7D7@raytheon.com> <1093972819.5403.8.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266622AbUHaStl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1093972819.5403.8.camel@krustophenia.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Hmm, looks like the es1371 takes ~0.5 ms to set the DAC rate.  The
> ALSA team would probably be able to help.  Takashi, any ideas?

i'd suggest to postpone this issue for the time being, the SMP hardware
in question produces 'mysterious' latencies in other, very unexpected
places as well. I suspect there's some issue that hits whatever code
happens to run - and the es1371 driver is used for the latency testing. 
So i believe it's just an innocent bystander. I'd suggest to look at
these again if they pop up after the 'mysterious' latency source is
found.

	Ingo
