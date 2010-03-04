From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ALSA: usb: move ua101 driver
Date: Thu, 4 Mar 2010 16:16:27 +0100
Message-ID: <20100304151627.GY9007@buzzloop.caiaq.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
	<4B8BA4A3.1060506@ladisch.de>
	<20100301140129.GI28972@buzzloop.caiaq.de>
	<s5haaus16gu.wl%tiwai@suse.de>
	<20100301141848.GJ28972@buzzloop.caiaq.de>
	<s5h635g15p2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 12DE21037F7
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 16:16:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h635g15p2.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 01, 2010 at 03:23:37PM +0100, Takashi Iwai wrote:
> At Mon, 1 Mar 2010 15:18:48 +0100,
> Daniel Mack wrote:
> > 
> > Clemens fixes only make sense for v2 of the USB audio spec, which isn't
> > fully supported yet. IOW, the code as it will go into 2.6.34 is not able
> > to support that, with or without my refactoring. So rebasing them
> > doesn't make sense IMO.
> 
> OK, then we can merge them together later.

Any plan on when to do that? I'm not in a hurry really, but I see the
usbaudio driver moving on, so merging would need some manual backporting
already. I can do that if you want and prepare a new patchset.

Btw - I'm curious how the commits e61e642c and 864c11080 made it to your
tree. Wasn't the alsa-devel list copied for the patch or am I losing
email?

Thanks,
Daniel
