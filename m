From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Fri, 7 Jun 2013 11:34:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306071041170.1366-100000@iolanthe.rowland.org>
References: <s5hobbiqx7w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 7749F2610CA
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 17:34:27 +0200 (CEST)
In-Reply-To: <s5hobbiqx7w.wl%tiwai@suse.de>
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
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Jun 2013, Takashi Iwai wrote:

> > > I don't expect that to happen any time soon.  Still, I think it makes
> > > more sense to concentrate on converting the messages below sound/usb
> > > rather than fiddling around with the existing API, which is inadequate
> > > anyway since it doesn't include the device.
> > 
> > I agree with that.
> > 
> > It'd be pretty easy to take that large patch that did
> > snd_printk(fmt, ...) -> snd_dbg(1, fmt, ...) and
> > convert it to snd_card_dbg(card *, fmt, ...)
> > whenever a struct snd_card * was available.
> > 
> > snd_card_dbg() would be either a macro or a function
> > to deference the snd_card * dev and maybe emit
> > "struct snd_card.shortname" with it too.
> > 
> > Want to start with that?
> 
> As discussed earlier, the snd_card instance isn't always appropriate
> for retrieving the device pointer.  It might help some driver codes,
> but not always.
> 
> In the case of sound/usb/*, most of codes rather handle directly the
> USB device pointer (mostly struct usb_interface), thus it's more
> natural to use it directly, IMO.

Agreed -- the lower-level driver should use the underlying device for
their messages.  The natural device for the snd_usb_audio driver to
report is the USB interface.  This would be the audio control interface
in many cases, or it could be the interface that contains the streaming
endpoints, or the interface containing the mixer, or the MIDI
interface...

The relevant data structures don't all store a pointer to the
interface, so I will have to add one.  That's another example of why
the conversion can't simply be done mindlessly.

For log messages in the sound core, it does make sense to use
snd_card->dev, or (preferably) snd_card->card_dev when it is available.  
As Takashi mentioned, the lower drivers often do not set snd_card->dev
as quickly as they should, i.e., they don't call snd_card_set_dev()  
right after creating the snd_card.  The best way to solve this is
probably to add a new routine, a version of snd_card_create() that
accepts the device pointer as an additional argument.

(Or maybe just change snd_card_create() and all its callers in one big 
patch.  It would be a fair amount of work, but doable.)

Alan Stern
