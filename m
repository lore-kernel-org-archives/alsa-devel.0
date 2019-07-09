From: "Geoffrey D. Bennett" <g@b4.vu>
Subject: Re: [PATCH V4] ALSA: usb-audio: Scarlett Gen 2 mixer
	interface
Date: Wed, 10 Jul 2019 01:54:30 +0930
Message-ID: <20190709162430.GA25766@b4.vu>
References: <20190709132605.GA25293@b4.vu> <s5hk1crtinr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from b4.vu (b4.vu [203.16.231.147])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A001AF801A4
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 18:24:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk1crtinr.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 09, 2019 at 03:57:28PM +0200, Takashi Iwai wrote:
[...]
> > But I tested suspending while the delayed work
> >   was waiting and it seemed like the delayed work was cancelled
> >   anyway. Probably better to do a flush on suspend though;
> 
> The flush would block, hence it wastes lots of time at suspend.
> Ideally the suspend should be performed immediately.
> 
> > should this
> >   be done through a hook like:
> > 
> >   diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> >   index 2444737a14b2..1572a89267c6 100644
> >   --- a/sound/usb/mixer.c
> >   +++ b/sound/usb/mixer.c
> >   @@ -3547,6 +3547,8 @@ static int snd_usb_mixer_activate(struct usb_mixer_interface *mixer)
> >    int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer)
> >    {
> >           snd_usb_mixer_inactivate(mixer);
> >   +       if (mixer->private_suspend)
> >   +               mixer->private_suspend(mixer);
> >           return 0;
> >    }
> >    
> >   diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
> >   index fa6e216a06f0..d94c688c65f7 100644
> >   --- a/sound/usb/mixer.h
> >   +++ b/sound/usb/mixer.h
> >   @@ -28,6 +28,7 @@ struct usb_mixer_interface {
> >    
> >           void *private_data;
> >           void (*private_free)(struct usb_mixer_interface *private_data);
> >   +       void (*private_suspend)(struct usb_mixer_interface *);
> >    };
> >    
> >    #define MAX_CHANNELS   16      /* max logical channels */
> > 
> >   ...or just keep the existing behaviour where it seems to get
> >   cancelled?
> 
> I'm fine to add the new suspend/resume callbacks, but maybe the
> corresponding resume would be needed.

Did you mean "wouldn't be needed"?

[...]
> > +static int scarlett_gen2_mixer_enable;
> > +module_param(scarlett_gen2_mixer_enable, int, 0444);
> > +MODULE_PARM_DESC(scarlett_gen2_mixer_enable,
> > +		 "Focusrite Scarlett Gen 2 Mixer Driver Enable");
> 
> Do we need this?  If disabling the quirk is really required, it should
> be implemented rather in a generic option, instead.

Actually it would be best to have it disabled by default as I have had
two reports from people who tried this mixer driver and it broke audio
for them.

The failure looks like this... the first vendor-specific USB message
sent to the interface to initialise it results in an error:

e2d87480 3146602314 S Ci:1:007:0 s a1 03 0000 0005 0010 16 <
e2d87480 3152107418 C Ci:1:007:0 -2 0

My mixer driver gives up initialising, and subsequent USB messages
fail:

e2d87480 3152110424 S Ci:1:007:0 s 80 06 0304 0409 00ff 255 <
e2d87480 3152121815 C Ci:1:007:0 -71 0
e2d87480 3152121955 S Ci:1:007:0 s 80 06 0304 0409 0002 2 <
e2d87480 3152131554 C Ci:1:007:0 -71 0
e2d87480 3152133420 S Ci:1:007:0 s 80 06 0305 0409 00ff 255 <
e2d87480 3157224469 C Ci:1:007:0 -2 0

I don't see any way to distinguish between devices that do and don't
work before sending the initialisation message. lsusb -v output is
identical. I need someone to do a USB capture to see what the vendor
driver does differently, but I haven't found someone who can do this
yet.

I have 9 success reports so far and 2 failure reports. I hope that by
getting this driver out to a wider audience I can get the data I need
to make it work in all cases and then we can remove the
scarlett_gen2_mixer_enable quirk and have the driver always enabled.

Thanks for your feedback again. The other things which I didn't
comment on I agree with and will fix.

Regards,
Geoffrey.
