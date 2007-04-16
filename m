From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [1/2] 2.6.21-rc7: known regressions
Date: Mon, 16 Apr 2007 17:44:57 -0400
Message-ID: <4623EE59.7090005@redhat.com>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org> <20070416003714.GL3691@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753913AbXDPVrN@vger.kernel.org>
In-Reply-To: <20070416003714.GL3691@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, perex@suse.cz, alsa-devel@alsa-project.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Adrian Bunk wrote:

> This email lists some known regressions in Linus' tree compared to 2.6.20.
> 
> Subject    : snd_intel8x0: divide error: 0000
> References : http://lkml.org/lkml/2007/3/5/252
> Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
> Status     : unknown
> 

Oops is in sound/pci/intel8x0.c::snd_intel8x0_update(), part of
the interrupt handler:

Line 751:

        ichdev->position += step * ichdev->fragsize1;
        if (! chip->in_measurement)
                ichdev->position %= ichdev->size;

ichdev->size is 0. Interrupt happened upon request_irq().

Does chip->in_measurement need to be reset because this is a
crashdump kernel?
