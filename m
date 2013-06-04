From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - Ignore default pin config
 on Haswell HDMI codecs
Date: Tue, 4 Jun 2013 16:23:22 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890118220E2@SHSMSX104.ccr.corp.intel.com>
References: <1370332965-3489-1-git-send-email-david.henningsson@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F80123BA2C@SHSMSX101.ccr.corp.intel.com>
 <51ADBF4D.30407@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C22C82615C0
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 18:23:27 +0200 (CEST)
In-Reply-To: <51ADBF4D.30407@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "tiwai@suse.de" <tiwai@suse.de>, "Li,
 Jocelyn" <jocelyn.li@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, James M Leddy <james.leddy@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi David,


> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Tuesday, June 04, 2013 6:20 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de; Wang, Xingchao;
> daniel@ffwll.ch; Girdwood, Liam R; Li, Jocelyn; James M Leddy
> Subject: Re: [RFC PATCH] ALSA: hda - Ignore default pin config on Haswell HDMI
> codecs
> 
> On 06/04/2013 12:10 PM, Lin, Mengdong wrote:
> > Hi David,
> >
> > Do you mean that a pin's default configuration may tell "No physical
> connection" by mistake?
> 
> A pin's default configuration can be set to "No physical connection".
> I've seen this on one machine that we're trying to enable.
> 
> Whether that is a mistake or not, that's the million dollar question here:
> 
> If it is not a mistake, then the graphics driver/stack should pay attention to this
> value, and not route audio to that pin.

Well by default, all the pins choose converter 0 as data source. So when playing audio
on the pin without external physical device connected, it would throw data to converter 0.
Meanwhile converter 0 maybe data source for other pin in use with physical device connected, that's why you hear sound.

I'm working on the patch to fix this issue. in my test, you cannot hear sound on an pin with nothing connected.

> 
> If it is a mistake, then the bspec [1] should mention that programming of this
> value should not be allowed (so we can tell the OEM to correct their BIOS).
> 
> I'm still trying to get a clear answer from someone at Intel, and it's becoming a
> bit frustrating not to get that.
> 
> 

Thanks
--xingchao

> >
> > Thanks
> > Mengdong
> >
> >> -----Original Message-----
> >> From: David Henningsson [mailto:david.henningsson@canonical.com]
> >> Sent: Tuesday, June 04, 2013 4:03 PM
> >> To: alsa-devel@alsa-project.org
> >> Cc: tiwai@suse.de; Wang, Xingchao; daniel@ffwll.ch; Lin, Mengdong;
> Girdwood,
> >> Liam R; Li, Jocelyn; David Henningsson
> >> Subject: [RFC PATCH] ALSA: hda - Ignore default pin config on Haswell HDMI
> >> codecs
> >>
> >> According to Daniel Vetter, these pin configs should be ignored, because the
> >> graphics driver/userspace could route audio to these pins even if they are
> >> disabled by BIOS.
> >>
> >> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> >> ---
> >>   sound/pci/hda/patch_hdmi.c |   10 ++++++----
> >>   1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> It would be good to have this acked by someone at Intel before committing.
> >>
> >> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index
> >> e12f7a0..8c1bede 100644
> >> --- a/sound/pci/hda/patch_hdmi.c
> >> +++ b/sound/pci/hda/patch_hdmi.c
> >> @@ -1307,12 +1307,14 @@ static int hdmi_add_pin(struct hda_codec
> *codec,
> >> hda_nid_t pin_nid)
> >>   	if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
> >>   		return 0;
> >>
> >> -	config = snd_hda_codec_get_pincfg(codec, pin_nid);
> >> -	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
> >> -		return 0;
> >> -
> >>   	if (codec->vendor_id == 0x80862807)
> >>   		intel_haswell_fixup_connect_list(codec, pin_nid);
> >> +	else {
> >> +		/* On Haswell, default pin config should be ignored */
> >> +		config = snd_hda_codec_get_pincfg(codec, pin_nid);
> >> +		if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
> >> +			return 0;
> >> +	}
> >>
> >>   	pin_idx = spec->num_pins;
> >>   	per_pin = snd_array_new(&spec->pins);
> >> --
> >> 1.7.9.5
> >
> 
> 
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
> 
> [1] Or some other document. I don't have access to the bspec, so I can't
> check this for myself.
