From: Geoffrey McRae <geoff@spacevs.com>
Subject: Re: [PATCH 1/2] ALSA: hda - Fix probing and stuttering
 on CMI8888 HD-audio controller
Date: Wed, 29 Oct 2014 23:13:15 +1100
Message-ID: <20141029231315.77e79b70@sarah.home.spacevs.com>
References: <1407328755-1021-1-git-send-email-tiwai@suse.de>
 <20141029072124.2cc32661@sarah.home.spacevs.com>
 <s5hy4rzco0y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.spacevs.com (mail1.spacevs.com [202.174.111.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AB732604E3
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 13:13:24 +0100 (CET)
In-Reply-To: <s5hy4rzco0y.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 29 Oct 2014 08:50:53 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 29 Oct 2014 07:21:24 +1100,
> Geoffrey McRae wrote:
> > 
> > I can confirm that disable of MSI is required as even Windows 7
> > 64bit does not enable this for Intel HDA. Out of curiosity I altered
> > the driver to use MSI-X with the same results, interrupts are never
> > received even though the PCI caps state that MSI is supported.
> > 
> > Playback is very poor and stutters if I do not allow snoop by
> > commenting out "case AZX_DRIVER_CMEDIA:" in
> > azx_check_snoop_available.
> 
> OK, so we have some conflicting results.  Possibly we need non-cached
> pages only for CORB/RIRB but leave the stream buffers?  Could you
> check the patch below?
> 

The patch works fine, no errors reported, if I however disable snoop it
continues to stutter.
