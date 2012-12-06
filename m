From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH sound-unstable] usb-audio: sync ep init fix
 for audioformat mismatch
Date: Thu, 6 Dec 2012 22:34:56 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212062234420.4388@xoschi>
References: <alpine.LNX.2.00.1212031932420.1485@xoschi>
 <1354563009-1949-1-git-send-email-eldad@fogrefinery.com>
 <s5h624icmk5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DE59826157F
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 22:35:04 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so2823212bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2012 13:35:04 -0800 (PST)
In-Reply-To: <s5h624icmk5.wl%tiwai@suse.de>
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
Cc: Grant Diffey <gdiffey@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Jeffrey Barish <jeff_barish@earthlink.net>
List-Id: alsa-devel@alsa-project.org


On Tue, 4 Dec 2012, Takashi Iwai wrote:
> At Mon,  3 Dec 2012 20:30:09 +0100,
> Eldad Zack wrote:
> > 
> > Commit 947d299686aa9cc8aecf749d54e8475c6e498956 , "ALSA: snd-usb:
> > properly initialize the sync endpoint", while correcting the
> > initialization of the sync endpoint when opening just the data
> > endpoint, prevents devices that has a sync endpoint, with a channel
> > number different than that of the data endpoint, from functioning.
> > Due to a different channel and period bytes count, attempting to
> > initialize the sync endpoint will fail at the usb host driver.
> > For example, when using xhci:
> > 
> >  cannot submit urb 0, error -90: internal error
> > 
> > With this patch, if a sync endpoint has multiple audioformats, a
> > matching audioformat is preferred. An audioformat must be found
> > with at least one channel and support the requested sample rate
> > and PCM format, otherwise the stream will not be opened.
> > 
> > If the number of channels differ between the selected audioformat
> > and the requested format, adjust the period bytes count accordingly.
> > It is safe to perform the calculation on the basis of the channel
> > count, since the requested PCM audio format and the rate must be
> > supported by the selected audioformat.
> > 
> > Cc: Jeffrey Barish <jeff_barish@earthlink.net>
> > Cc: Daniel Mack <zonque@gmail.com>
> > Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
> 
> Thanks, applied.

Great!

> At the next time, however, create a patch based on either for-next or
> for-linus branch of sound git tree.  sound-unstable tree is a place to
> play with experimental patches.  The place to put the real patches
> that will be fed to the upstream is sound git tree.

Ah, sorry, I mixed up unstable with to-next then.
Thanks for the heads up! 

Cheers,
Eldad
