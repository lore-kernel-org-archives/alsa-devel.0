From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH] ALSA : hda - not use assigned
 converters for all unused pins
Date: Fri, 20 Sep 2013 08:00:17 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80137789B@SHSMSX101.ccr.corp.intel.com>
References: <1379299244-18559-1-git-send-email-mengdong.lin@intel.com>
 <523788CF.3060001@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9992A261A2F
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 10:00:22 +0200 (CEST)
In-Reply-To: <523788CF.3060001@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi David,

Sorry, I missed your mail. Please see comments below ...

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Tuesday, September 17, 2013 6:40 AM

> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index 3d8cd044..4960695 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -1152,29 +1152,34 @@ static void haswell_config_cvts(struct
> hda_codec *codec,
> >  			int pin_id, int mux_id)
> >  {
> >  	struct hdmi_spec *spec = codec->spec;
> > -	struct hdmi_spec_per_pin *per_pin;
> > -	int pin_idx, mux_idx;
> > +	hda_nid_t  pin_nid;
> > +	int pin_idx, cvt_idx;
> >  	int curr;
> > -	int err;
> > -
> > -	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> > -		per_pin = get_pin(spec, pin_idx);
> > +	struct hdmi_spec_per_cvt *per_cvt;
> >
> > +	/* configure all 3 pins, including "no physical connection" ones */
> > +	for (pin_nid = 5; pin_nid < 8; pin_nid++) {
> 
> It might not be so future proof to hard code nid IDs here (even if it should be
> safe right now?). Perhaps more elegant to go through the entire codec->nids
> array like being done here:
> 
> http://lxr.linux.no/linux+*/sound/pci/hda/hda_auto_parser.c#L188
> 
> The nid's wcaps is cached so it does not mean additional reads from the codec.

Xingchao defined haswell_config_cvts() to configure converters on codec->pins before.
But codec->pins does not include the pins programmed by BIOS as "No physical connections" (like port B in the OEM machine).
So I change the code from using codec->pins to hard coded NIDs. It's not graceful and the NIDs may change in the future.

There is another option to change add_pin() to not overlook such "no connection" pins for Haswell.
But there would be a side effect: the 1st pin can be "no connection" and then the following function will be affected:
- simple_playback_build_pcms()
- simple_playback_init()
Both of them assume the 1st pin is valid and use get_pin(spec, 0) to operates on the 1st pin.
And in addition, I don't want more PCM and controls to be created on the "No connection" pins.
So finally I gave up to change add_pin() but just modify haswell_config_cvts().

Thanks
Mengdong
