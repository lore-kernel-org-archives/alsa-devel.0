From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH] ALSA: usb: Work around CM6631 sample rate
 change bug
Date: Sun, 3 Mar 2013 20:29:22 +0100
Message-ID: <20130303192922.GE4452@pvv.ntnu.no>
References: <20130302130403.GD4452@pvv.ntnu.no>
 <5131FAC1.30007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DC472625D9
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 20:29:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5131FAC1.30007@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 02, 2013 at 02:12:33PM +0100, Daniel Mack wrote:
> On 02.03.2013 14:04, Torstein Hegge wrote:
> > The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
> > sampling frequency while the interface is active.
> > 
> > Reset the interface after setting the sampling frequency, to ensure that the
> > sample rate set by snd_usb_init_sample_rate() is used. Otherwise, the device
> > will try to use the sample rate of the previous file, causing distorted sound
> > on sample rate changes.
> > 
> > Signed-off-by: Torstein Hegge <hegge@resisty.net>
> 
> Acked-by: Daniel Mack <zonque@gmail.com>

While this does fix the sample rate change problem, it introduces a new
problem. With at least one media player application (xbmc) this patch
causes the usb sound card to not output sound when starting a video
file. Skipping forward or backward in the video stream restores audio
output.

I haven't yet been able to look into why this happens, or why xbmc
behaves different from mplayer and vlc.

Torstein

> > ---
> >  sound/usb/pcm.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> > index d82e378..01978a6 100644
> > --- a/sound/usb/pcm.c
> > +++ b/sound/usb/pcm.c
> > @@ -710,6 +710,16 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
> >  		subs->need_setup_ep = false;
> >  	}
> >  
> > +	/* Some devices doesn't respond to sample rate changes while the
> > +	 * interface is active. */
> > +	switch (subs->stream->chip->usb_id) {
> > +	case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Interface */
> > +	case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */
> > +		usb_set_interface(subs->dev, subs->cur_audiofmt->iface,
> > +					subs->cur_audiofmt->altset_idx);
> > +		break;
> > +	}
> > +
> >  	/* some unit conversions in runtime */
> >  	subs->data_endpoint->maxframesize =
> >  		bytes_to_frames(runtime, subs->data_endpoint->maxpacksize);
> > 
