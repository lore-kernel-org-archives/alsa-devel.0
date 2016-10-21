From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v3 2/3] ALSA: hda - add DP mst audio
 support
Date: Fri, 21 Oct 2016 08:56:24 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D194FA4A3D4@SHSMSX103.ccr.corp.intel.com>
References: <1476344977-147193-1-git-send-email-libin.yang@linux.intel.com>
 <1476344977-147193-3-git-send-email-libin.yang@linux.intel.com>
 <s5hmvhzghkq.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D194FA4A381@SHSMSX103.ccr.corp.intel.com>
 <s5hfunqgkhs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 8558926717B
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 10:56:30 +0200 (CEST)
In-Reply-To: <s5hfunqgkhs.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, October 21, 2016 4:44 PM
> To: Yang, Libin <libin.yang@intel.com>
> Cc: libin.yang@linux.intel.com; alsa-devel@alsa-project.org; Lin, Mengdong
> <mengdong.lin@intel.com>
> Subject: Re: [alsa-devel] [RFC PATCH v3 2/3] ALSA: hda - add DP mst audio
> support
> 
> On Fri, 21 Oct 2016 10:24:26 +0200,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Thursday, October 20, 2016 11:34 PM
> > > To: libin.yang@linux.intel.com
> > > Cc: alsa-devel@alsa-project.org; Yang, Libin <libin.yang@intel.com>;
> > > Lin, Mengdong <mengdong.lin@intel.com>
> > > Subject: Re: [alsa-devel] [RFC PATCH v3 2/3] ALSA: hda - add DP mst
> > > audio support
> > >
> > > On Thu, 13 Oct 2016 09:49:36 +0200,
> > > libin.yang@linux.intel.com wrote:
> > > >
> > > > From: Libin Yang <libin.yang@linux.intel.com>
> > > >
> > > > This patch adds the DP mst audio support.
> > >
> > > A bit more useful texts here please.  I know you'll give more
> > > explanations in the document in the later patch, but still something
> > > better should be mentioned here.
> >
> > Yes, I will add more description here.
> >
> > >
> > > >
> > > > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > > > ---
> > > >  sound/pci/hda/hda_codec.c  |   4 +
> > > >  sound/pci/hda/patch_hdmi.c | 243
> > > > +++++++++++++++++++++++++++++++++++----------
> > > >  2 files changed, 196 insertions(+), 51 deletions(-)
> > > >
> > > > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > > > index caa2c9d..8a6b0a2 100644
> > > > --- a/sound/pci/hda/hda_codec.c
> > > > +++ b/sound/pci/hda/hda_codec.c
> > > > @@ -468,6 +468,10 @@ static int read_pin_defaults(struct hda_codec
> > > *codec)
> > > >  		pin->nid = nid;
> >
> > ...
> >
> > > > +
> > > >
> > > >  		/* choose an unassigned converter. The conveters in the
> > > >  		 * connection list are in the same order as in the codec.
> > > > @@ -1008,12 +1078,13 @@ static void
> > > > intel_not_share_assigned_cvt(struct
> > > hda_codec *codec,
> > > >  				break;
> > > >  			}
> > > >  		}
> > > > +		snd_hda_set_dev_select(codec, nid, dev_id_saved);
> > >
> > > I guess this revert won't be reached when you break or continue the
> > > loop beforehand?
> >
> > To make it easier to explain, please let me attach the full patched code here:
> >
> > for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> > 		int dev_id_saved;
> > 		int dev_num;
> >
> > 		per_pin = get_pin(spec, pin_idx);
> > 		/*
> > 		 * pin not connected to monitor
> > 		 * no need to operate on it
> > 		 */
> > 		if (!per_pin->pcm)
> > 			continue;
> >
> > 		if ((per_pin->pin_nid == pin_nid) &&
> > 			(per_pin->dev_id == dev_id))
> > 			continue;
> >
> > 		/*
> > 		 * if per_pin->dev_id >= dev_num,
> > 		 * snd_hda_get_dev_select() will fail,
> > 		 * and the following operation is unpredictable.
> > 		 * So skip this situation.
> > 		 */
> > 		dev_num = snd_hda_get_num_devices(codec, per_pin-
> >pin_nid) + 1;
> > 		if (per_pin->dev_id >= dev_num)
> > 			continue;
> >
> > 		nid = per_pin->pin_nid;
> >
> > 		/*
> > 		 * Calling this function should not impact
> > 		 * on the device entry selection
> > 		 * So let's save the dev id for each pin,
> > 		 * and restore it when return
> > 		 */
> > 		dev_id_saved = snd_hda_get_dev_select(codec, nid);
> > tag 1		snd_hda_set_dev_select(codec, nid, per_pin->dev_id);
> > 		curr = snd_hda_codec_read(codec, nid, 0,
> > 					  AC_VERB_GET_CONNECT_SEL, 0);
> > 		if (curr != mux_idx) {
> > tag 2			snd_hda_set_dev_select(codec, nid, dev_id_saved);
> > 			continue;
> > 		}
> >
> >
> > 		/* choose an unassigned converter. The conveters in the
> > 		 * connection list are in the same order as in the codec.
> > 		 */
> > 		for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
> > 			per_cvt = get_cvt(spec, cvt_idx);
> > 			if (!per_cvt->assigned) {
> > 				codec_dbg(codec,
> > 					  "choose cvt %d for pin nid %d\n",
> > 					cvt_idx, nid);
> > 				snd_hda_codec_write_cache(codec, nid, 0,
> > 					    AC_VERB_SET_CONNECT_SEL,
> > 					    cvt_idx);
> > tag 3				break;
> > 			}
> > 		}
> > 		snd_hda_set_dev_select(codec, nid, dev_id_saved);
> > 	}
> >
> > We need revert dev_id only after we change the dev_id setting before.
> > This is done by: snd_hda_set_dev_select(codec, nid, per_pn->dev_id)
> > (tag1) There is one "continue" and we have reverted dev_id before
> > continue (tag 2) There is one "break" (tag 3). However, this is for another
> for loop.
> 
> OK, fair enough.
> 
> 
> > > Also, this rewrite changes the loop completely, so we you should
> > > update the comment appropriately.  It's no longer scanning the all
> > > pins (including unused ones).  And I'm not 100% sure whether it's OK
> > > to change in that way; the function was written to do that (touching
> > > the unused pin as well) on purpose, IIRC.
> > >
> > > Hm, or is it OK because we are listing always the three pins?
> > > More explanation please, either in comments or in the changelog.
> > >
> >
> > This function is a little complex now. Please let me explain it in detail.
> >
> > As you know, we need this function because we need fix: same cvt is
> > connecting to several pins. In this situation, playback on one pin
> > will also impact on other pins. Let's assume cvt 1 are connecting to pin 1, 2,
> 3.
> > When we playback on pin1, we need call this function to make sure pin
> > 2, 3 is connected to other cvts.
> >
> > In MST mode,  we are using dynamic pcm. If no pcm is attached to the
> > pin, it means there is no monitor connected to the pin. So we don't
> > need to set the cvt. Let's still assume the cvt 1 are connecting to
> > pin 1, 2, 3, 4, 5, 6, 7, 8, 9 (here pin is the virtual pin).
> >
> > Let's assume playback on pin 1 (which is connected to cvt 1).
> > So we should make sure all others pins are not connected to cvt1.
> >
> > 1) For other pins:
> >     if (!per_pin->pcm)
> >         continue;
> > This means no monitors is connected to the pin. So we don't care the
> > cvt connection because the pin doesn't output sound to monitor.
> > (when the virtual pin is connected to monitor later, this function
> > will be called in present_sense(), which will make sure the cvt
> > connected to the virtual pin is different from the cvt connected to
> > pin 1)
> >
> > 2) For the following situation:
> >     dev_num = snd_hda_get_num_devices(codec, per_pin->pin_nid) + 1;
> >         if (per_pin->dev_id >= dev_num)
> >             continue;
> > The per_pin->dev_id is greater than dev_num. This means no such
> > virtual pin. We should skip this situation.
> >
> > 3) For the following situation:
> >     if (curr != mux_idx) {
> >         snd_hda_set_dev_select(codec, nid, dev_id_saved);
> >         continue;
> >     }
> > It means the cvt connected to the virtual pin is already different to
> > the cvt connected to the pin 1. So we don't need to do anything.
> >
> > 4) Otherwise (the cvt is the same to pin 1), we need change the cvt.
> >
> > I will add more description for this function in the next version patch.
> 
> One thing that is still unclear to me is how to deal with the unconfigured pins.
> I thought that the pins with port=non pincfg are still ignored in
> hdmi_add_pin() even after your patch.  So they won't be listed in the pins /
> nids arrays.

Actually, MST code doesn't touch port=non code. It exists before.

My understanding of this code is that port=non is HW connection
related. If this pin is not connected to any jack, it means it is not
lined out and the pin is useless for the special machine.

> 
> Now, your new code only loops over the enumerated pins, i.e. these
> unconfigured pins are ignored.  What if these pins are connected to the
> active converters?  I thought excluding such a connection is one of the
> purposes of this function, judging from the function description.

If the pin is not lined out, no monitor will be connected to the pin. So even
the cvt is connected to the pin, it will impact nothing. For MST mode,
if it is not lined out, there will be never pcm attached to the pin. This means
you will never have chance to operate the cvt connected to the pin.
Besides, I found if there is no monitor connected to the pin, 
the connection list is not actually connecting to any cvt for the pin.

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
