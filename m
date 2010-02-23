From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] usb/gadget/{f_audio,
 gmidi}.c: follow recent changes in audio.h
Date: Tue, 23 Feb 2010 15:31:52 -0800
Message-ID: <20100223233152.GA29894@suse.de>
References: <20100223082634.GR28972@buzzloop.caiaq.de>
	<1266917400-26397-1-git-send-email-daniel@caiaq.de>
	<s5hocjg1dqm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9775D1037EE
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 00:32:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hocjg1dqm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, dbrownell@users.sourceforge.net, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2010 at 10:51:45AM +0100, Takashi Iwai wrote:
> At Tue, 23 Feb 2010 10:30:00 +0100,
> Daniel Mack wrote:
> > 
> > Some structs in linux/usb/audio.h have got new names to mark them as
> > part of version 1.0 of the USB audio standard. Follow these changes
> > in the gadget drivers.
> > 
> > Not that this header and the ALSA USB driver will undergo some
> > refactoring soon, so there might be another update to the gadgets as
> > well.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > ---
> > I believe this would be best to go thru the ALSA tree as the other
> > changes are there, too.
> 
> Yep, now applied to topic/usb-v2.0 branch of sound git tree.
> 
> If anyone has no objection, I'll merge this branch today for
> linux-next.

No objection from me, thanks for doing this.

greg k-h
