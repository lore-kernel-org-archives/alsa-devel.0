From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH v2 0/3] Atmel ALSA drivers
Date: Thu, 5 Feb 2009 15:50:21 +0100
Message-ID: <20090205155021.7c4c43e8@hcegtvedt>
References: <1233835861-5533-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<s5hbpth9cb6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 41006243BF
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 15:50:23 +0100 (CET)
In-Reply-To: <s5hbpth9cb6.wl%tiwai@suse.de>
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

On Thu, 05 Feb 2009 15:40:45 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu,  5 Feb 2009 13:10:58 +0100,
> Hans-Christian Egtvedt wrote:
> > 
> > This patch series is the second revision after the initial review on
> > alsa-devel mailing list. I have addressed the feedback and fixed up
> > the drivers appropriatly, at least I hope so.
> > 
> > I've settled to put the drivers in the more common sound/atmel and
> > added an "Atmel devices (AVR32 and AT91)" menu entry in the ALSA
> > part of kconfig. No drivers are available for AT91 yet, but the
> > AC97C driver should be quite simple to add support for AT91 devices
> > as well.
> > 
> > The patches are formatted against v2.6.29-rc3 tag from Linux
> > repository.
> 
> Thanks, I applied the patches to topic/atmel branch on sound git tree,
> and merged back to master and for-next branches.
> 

Thanks for the quick feedback on the drivers.

> For further development, please base on this version.
> 

Okay.

> > In addition a vital DMA patch[1] is needed, which adds a cyclic DMA
> > interface to the DesignWare DMA controller.
> > 
> > 1: http://avr32linux.org/archives/kernel/2009-February/002088.html
> >    http://avr32linux.org/archives/kernel/2009-February/002087.html
> 
> These aren't taken into sound tree, though...
> 

Nope, that is correct, they will go through Haavard and his AVR32 tree.

-- 
Best regards,
Hans-Christian Egtvedt
