From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ALSA: Add snd_ctl_update()
	to	dynamically update a control
Date: Tue, 15 Mar 2011 16:27:28 +0000
Message-ID: <20110315162728.GA27777@opensource.wolfsonmicro.com>
References: <1300192269-20435-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4D7F7516.7050009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD4C82455E
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 17:27:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D7F7516.7050009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2011 at 03:17:58PM +0100, Clemens Ladisch wrote:
> Doing this outside the semaphore doesn't look good.

Yes, I was thinking about the same thing, wasn't sure about nesting rw
semaphores though.

> I wonder whether snd_ctl_add() is the right function to use, because it
> will assign a different numid event if the control didn't change.

Hm, indeed.  I can probably inline a slightly different version of
snd_ctl_add()?

> > A separate patch needs to be made to make ALSA Mixer cope with this.
> 
> What happens?

It doesn't break or anything hopefully.  It will probably need support for
handling the update of the controls (without exiting and starting it
again).  I've only tested it against alsa-utils 1.0.20 and it worked
fine with a few changes (updating the controls on the fly).

Thanks,
Dimitris
