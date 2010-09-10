From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: usb-audio: Assume first control
 interface is for audio
Date: Fri, 10 Sep 2010 18:15:44 +0200
Message-ID: <20100910161544.GS7159@buzzloop.caiaq.de>
References: <1283418795-3319-1-git-send-email-daniel@caiaq.de>
	<s5hfwxsh3ex.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C39324513
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 18:16:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfwxsh3ex.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Greg KH <gregkh@suse.de>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 02, 2010 at 11:59:18AM +0200, Takashi Iwai wrote:
> At Thu,  2 Sep 2010 17:13:15 +0800,
> Daniel Mack wrote:
> > 
> > For devices with more than one control interface, let's assume the first
> > one contains the audio controls. Unfortunately, there is no field in any
> > of the descriptors to tell us whether a control interface is for audio
> > or MIDI controls, so a better check is not easy to implement.
> > 
> > On a composite device with audio and MIDI functions, for example, the
> > code currently overwrites chip->ctrl_intf, causing operations on the
> > control interface to fail if they are issued after the device probe.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> 
> Applied now.  Thanks.

This went upstream now, thanks. However, I forgot to mention in my
commit log that we also need this backported to 2.6.35.

Greg, can you queue it up manually? Upstream commit is 7b6717e.

Thanks,
Daniel


> > ---
> >  sound/usb/card.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> > 
> > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > index 9feb00c..b443a33 100644
> > --- a/sound/usb/card.c
> > +++ b/sound/usb/card.c
> > @@ -465,7 +465,13 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
> >  			goto __error;
> >  	}
> >  
> > -	chip->ctrl_intf = alts;
> > +	/*
> > +	 * For devices with more than one control interface, we assume the
> > +	 * first contains the audio controls. We might need a more specific
> > +	 * check here in the future.
> > +	 */
> > +	if (!chip->ctrl_intf)
> > +		chip->ctrl_intf = alts;
> >  
> >  	if (err > 0) {
> >  		/* create normal USB audio interfaces */
> > -- 
> > 1.7.0.4
> > 
