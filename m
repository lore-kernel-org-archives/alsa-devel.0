From: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH SND/USB]: Add QuickCam Communicate Deluxe/S7500 to  volume_control_quirks.
Date: Sat, 10 Dec 2016 07:35:17 +1100
Message-ID: <3895233.t8xxWNsFQ1@hex>
References: <2208242.ISe40cRj8e@hex> <s5h7f79mmg8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7f79mmg8.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday, 9 December 2016 11:22:15 AM AEDT Takashi Iwai wrote:
> On Fri, 09 Dec 2016 05:15:57 +0100,
> 
> Con Kolivas wrote:
> > The Logitech QuickCam Communicate Deluxe/S7500 microphone fails with the
> > following warning.
> > 
> > [    6.778995] usb 2-1.2.2.2: Warning! Unlikely big volume range (=3072),
> > cval->res is probably wrong.
> > [    6.778996] usb 2-1.2.2.2: [5] FU [Mic Capture Volume] ch = 1, val =
> > 4608/7680/1
> > 
> > Adding it to the list of devices in volume_control_quirks makes it work
> > properly, fixing related typo.
> > 
> > Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> Applied (with Cc to stable), thanks.

(Apologies for google mail defaulting to html, resending with a proper mail 
client)

You're welcome. As there appear to be a lot of these devices from the same 
manufacturer with the same error, and there are likely a lot of devices out 
there that are missed from this whitelist, do you think it would be worthwhile 
changing the code to detect the combination of unlikely big volume range and 
usb vendor of 0x046d and automatically try using the volume_control_quirk on 
them instead of a discrete whitelist?


Thanks,

Con

> 
> 
> Takashi
> 
> > ---
> > 
> >  sound/usb/mixer.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 2f8c388..4703cae 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -932,9 +932,10 @@ static void volume_control_quirks(struct
> > usb_mixer_elem_info *cval,> 
> >  	case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
> >  	case USB_ID(0x046d, 0x08ca): /* Logitech Quickcam Fusion */
> > 
> >  	case USB_ID(0x046d, 0x0991):
> > +	case USB_ID(0x046d, 0x09a2): /* QuickCam Communicate Deluxe/S7500 */
> > 
> >  	/* Most audio usb devices lie about volume resolution.
> >  	
> >  	 * Most Logitech webcams have res = 384.
> > 
> > -	 * Proboly there is some logitech magic behind this number --fishor
> > +	 * Probably there is some logitech magic behind this number --fishor
> > 
> >  	 */
> >  	 
> >  		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
> >  		
> >  			usb_audio_info(chip,


-- 
-ck
