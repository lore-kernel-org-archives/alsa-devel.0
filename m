From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH] ucm: Add support for device positions
Date: Tue, 3 Jan 2017 15:32:11 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881A1303C@shsmsx102.ccr.corp.intel.com>
References: <1483423758-8986-1-git-send-email-mengdong.lin@linux.intel.com>
 <1483455527.4555.12.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EE16A2666FE
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 16:32:18 +0100 (CET)
In-Reply-To: <1483455527.4555.12.camel@loki>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
> Sent: Tuesday, January 3, 2017 10:59 PM

> > Users can provide prosition info of audio devices as a device value.
> > This will help the sound server to choose an audio devices from some
> > candidates based on the their locations and the status of the machine.
> >
> > The value name is the "Postion",
> 
> We should change this to "Location" and use "Position" for x,y,z coordinates
> of the device to help for beam forming etc (separate patch series for
> Position).

Okay. "Location" seem better here.
> 
> >  and its value should be a composition of "Top", "Bottom", "Left",
> > "Right", "Front" and "Back". For example, a speaker may have a
> > position like "Front Top".
> >
> > The postion value can be got by either of the two APIs:
> > - snd_use_case_get(), via identifier 'Postion/device', to get the original
> >   position string defined by the user.
> > - snd_use_case_geti(), via identifier '_devpos/device', to get the integer
> >   value of the position. If the user has not define a position, 0 will be
> >   returned that means an unknown position.
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
> >
> > diff --git a/include/use-case.h b/include/use-case.h index
> > 8911645..b3b451b 100644
> > --- a/include/use-case.h
> > +++ b/include/use-case.h
> > @@ -165,6 +165,28 @@ extern "C" {
> >  #define SND_USE_CASE_TQ_VOICE		"Voice"		/**< Voice
> Tone Quality */
> >  #define SND_USE_CASE_TQ_TONES		"Tones"		/**<
> Tones Tone Quality */
> >
> > +
> > +/**
> > + * Device Position bits
> > + *
> > + * 0 is reserved for unknown position in each dimesion. Users can get
> > +the
> > + * integer value of the device postion by API snd_use_case_geti() via
> > + * identifier '_devpos/device', and the returned value is a
> > +compostion of
> > + * three dimesions.
> > + *
> > + * NOTE: Users can also get the position string like "Top Left" by
> > +API
> > + * snd_use_case_get() via identifier 'Position/device".
> > + */
> > +#define SND_USE_CASE_POS_LEFT           (1<<0)
> > +#define SND_USE_CASE_POS_RIGHT          (2<<0)
> > +#define SND_USE_CASE_POS_HORIZON_MASK   (0xffff<<0)
> > +#define SND_USE_CASE_POS_TOP            (1<<4)
> > +#define SND_USE_CASE_POS_BOTTOM         (2<<4)
> > +#define SND_USE_CASE_POS_VERTICAL_MASK  (0xffff<<4)
> > +#define SND_USE_CASE_POS_FRONT          (1<<8)
> > +#define SND_USE_CASE_POS_BACK           (2<<8)
> > +#define SND_USE_CASE_DEPTH_MASK         (0xffff<<8)
> 
> These are a little restrictive. It would be best to copy the other examples and
> use strings as users can easily append new locations by adding a string to a
> value list (without having to update any UCM core code).
> 
> We would have a set of the common default locations so that sound servers
> could use present this info to users in meaningful ways, bespoke locations
> could also be presented to users (but only in string format).
> 
> SectionDevice."Mic".0 {
> 
> 	EnableSequence [
> 	     ....
> 	]
> 
> 	DisableSequence [
>              ....
> 	]
> 
> 	Value {
> 		Location "Left"
> 		Position "19.5, 34.2, 3.1"
> 	}
> }
> 
> Using the above format means we just return the value of location to the
> client. We dont have to do any parsing or validation. Same applies for
> position.

> Liam

Okay. And If we only need to provide "Location" or "Position" in string format, current UCM code can already support it. We just need to specify these two variable names in the comments :-)

Users can get the info by API snd_use_case_get() with the identifier 'Location/device" or "Position/device" , e.g. "Location/Speaker". 

Thanks
Mengdong
