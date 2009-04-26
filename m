From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problem bringing up new alsa driver
Date: Sun, 26 Apr 2009 20:31:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904262020010.25064@eeebox2.perex-int.cz>
References: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
	<9e4733910904251428r678cd32fkc6c56e4f43a1887b@mail.gmail.com>
	<s5hljpnwtst.wl%tiwai@suse.de>
	<9e4733910904260842g991f476ib112d12c0f481e5d@mail.gmail.com>
	<s5hws97xsau.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0904261926470.25064@eeebox2.perex-int.cz>
	<9e4733910904261112l488b30b1s6180d651ff2f47f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B380310380C
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 20:31:14 +0200 (CEST)
In-Reply-To: <9e4733910904261112l488b30b1s6180d651ff2f47f9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 26 Apr 2009, Jon Smirl wrote:

> If I take this out I get these errors...
> ALSA sound/core/pcm_lib.c:264: PCM: hw_ptr skipping! [Q] (pos=11026,
> delta=5513, period=5513, jdelta=33/37/0)

It means that the period DMA operation is too quick in your case and does 
not correspond to the timing specified by rate. It might be that the FIFO 
on path is large or rate set to the codec is not correct. What's HZ value 
on your system and FIFO size? There is HZ/100 margin in the check now.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
