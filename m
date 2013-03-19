From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH] ALSA: usb: Parse UAC2 extension unit like
 for UAC1
Date: Tue, 19 Mar 2013 19:10:39 +0100
Message-ID: <20130319181038.GC7539@pvv.ntnu.no>
References: <20130319161214.GB7539@pvv.ntnu.no> <s5h7gl3l3ls.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D8F92615D7
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 19:10:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7gl3l3ls.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 19, 2013 at 06:08:15PM +0100, Takashi Iwai wrote:
> At Tue, 19 Mar 2013 17:12:14 +0100,
> Torstein Hegge wrote:
> > 
> > UAC2_EXTENSION_UNIT_V2 differs from UAC1_EXTENSION_UNIT, but can be handled in
> > the same way when parsing the unit. Otherwise parse_audio_unit() fails when it
> > sees an extension unit on a UAC2 device.
> > 
> > UAC2_EXTENSION_UNIT_V2 is outside the range allocated by UAC1.
> > 
> > Signed-off-by: Torstein Hegge <hegge@resisty.net>
> 
> Does this bug hit on any existing device with 3.9-rc kernel?
> If it does, it'd be nice to have a bit actual description.

The bug was reported on a Focusrite Scarlett 8i6 USB with a 3.5.0 kernel [1],
where the unhandled subtype causes the card creation to fail:

[ 1144.857836] usb 2-1.2: new high-speed USB device number 4 using ehci_hcd
[ 1144.951520] usb 2-1.2: New USB device found, idVendor=1235, idProduct=8002
[ 1144.951531] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1144.951538] usb 2-1.2: Product: Scarlett 8i6 USB 
[ 1144.951543] usb 2-1.2: Manufacturer: Focusrite
[ 1144.951547] usb 2-1.2: SerialNumber: 00006B8B
[ 1144.956590] usbaudio: unit 51: unexpected type 0x09
[ 1144.956640] snd-usb-audio: probe of 2-1.2:1.0 failed with error -5

Still waiting for him to report back with a 3.9-rc kernel.

[1] http://thread.gmane.org/gmane.linux.alsa.user/37289/focus=37294


Torstein

> > ---
> >  sound/usb/mixer.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 638e7f7..8eb84c0 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -725,7 +725,8 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
> >  		case UAC1_PROCESSING_UNIT:
> >  		case UAC1_EXTENSION_UNIT:
> >  		/* UAC2_PROCESSING_UNIT_V2 */
> > -		/* UAC2_EFFECT_UNIT */ {
> > +		/* UAC2_EFFECT_UNIT */
> > +		case UAC2_EXTENSION_UNIT_V2: {
> >  			struct uac_processing_unit_descriptor *d = p1;
> >  
> >  			if (state->mixer->protocol == UAC_VERSION_2 &&
> > @@ -2052,6 +2053,8 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
> >  			return parse_audio_extension_unit(state, unitid, p1);
> >  		else /* UAC_VERSION_2 */
> >  			return parse_audio_processing_unit(state, unitid, p1);
> > +	case UAC2_EXTENSION_UNIT_V2:
> > +		return parse_audio_extension_unit(state, unitid, p1);
> >  	default:
> >  		snd_printk(KERN_ERR "usbaudio: unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
> >  		return -EINVAL;
> > -- 
> > 1.7.10.4
