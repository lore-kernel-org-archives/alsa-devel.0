From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v3 2/3] ALSA: hda - add DP mst audio
 support
Date: Mon, 24 Oct 2016 07:09:07 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D194FA4ACE3@SHSMSX103.ccr.corp.intel.com>
References: <1476344977-147193-1-git-send-email-libin.yang@linux.intel.com>
 <1476344977-147193-3-git-send-email-libin.yang@linux.intel.com>
 <s5hmvhzghkq.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D194FA4A381@SHSMSX103.ccr.corp.intel.com>
 <s5hfunqgkhs.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D194FA4A3D4@SHSMSX103.ccr.corp.intel.com>
 <s5hd1iugji5.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D194FA4A49B@SHSMSX103.ccr.corp.intel.com>
 <s5hvawlg9vg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E661A2661A4
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 09:09:13 +0200 (CEST)
In-Reply-To: <s5hvawlg9vg.wl-tiwai@suse.de>
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
> Sent: Friday, October 21, 2016 8:33 PM
> To: Yang, Libin <libin.yang@intel.com>
> Cc: libin.yang@linux.intel.com; alsa-devel@alsa-project.org; Lin, Mengdong
> <mengdong.lin@intel.com>
> Subject: Re: [alsa-devel] [RFC PATCH v3 2/3] ALSA: hda - add DP mst audio
> support
> 
> On Fri, 21 Oct 2016 14:25:28 +0200,
> Yang, Libin wrote:
> >
> > > > > > > Also, this rewrite changes the loop completely, so we you
> > > > > > > should update the comment appropriately.  It's no longer
> > > > > > > scanning the all pins (including unused ones).  And I'm not
> > > > > > > 100% sure whether it's OK to change in that way; the
> > > > > > > function was written to do that (touching the unused pin as well)
> on purpose, IIRC.
> > > > > > >
> > > > > > > Hm, or is it OK because we are listing always the three pins?
> > > > > > > More explanation please, either in comments or in the changelog.
> > > > > > >
> > > > > >
> > > > > > This function is a little complex now. Please let me explain it in detail.
> > > > > >
> > > > > > As you know, we need this function because we need fix: same
> > > > > > cvt is connecting to several pins. In this situation, playback
> > > > > > on one pin will also impact on other pins. Let's assume cvt 1
> > > > > > are connecting to pin 1, 2,
> > > > > 3.
> > > > > > When we playback on pin1, we need call this function to make
> > > > > > sure pin 2, 3 is connected to other cvts.
> > > > > >
> > > > > > In MST mode,  we are using dynamic pcm. If no pcm is attached
> > > > > > to the pin, it means there is no monitor connected to the pin.
> > > > > > So we don't need to set the cvt. Let's still assume the cvt 1
> > > > > > are connecting to pin 1, 2, 3, 4, 5, 6, 7, 8, 9 (here pin is the virtual
> pin).
> > > > > >
> > > > > > Let's assume playback on pin 1 (which is connected to cvt 1).
> > > > > > So we should make sure all others pins are not connected to cvt1.
> > > > > >
> > > > > > 1) For other pins:
> > > > > >     if (!per_pin->pcm)
> > > > > >         continue;
> > > > > > This means no monitors is connected to the pin. So we don't
> > > > > > care the cvt connection because the pin doesn't output sound to
> monitor.
> > > > > > (when the virtual pin is connected to monitor later, this
> > > > > > function will be called in present_sense(), which will make
> > > > > > sure the cvt connected to the virtual pin is different from
> > > > > > the cvt connected to pin 1)
> > > > > >
> > > > > > 2) For the following situation:
> > > > > >     dev_num = snd_hda_get_num_devices(codec, per_pin->pin_nid)
> + 1;
> > > > > >         if (per_pin->dev_id >= dev_num)
> > > > > >             continue;
> > > > > > The per_pin->dev_id is greater than dev_num. This means no
> > > > > > such virtual pin. We should skip this situation.
> > > > > >
> > > > > > 3) For the following situation:
> > > > > >     if (curr != mux_idx) {
> > > > > >         snd_hda_set_dev_select(codec, nid, dev_id_saved);
> > > > > >         continue;
> > > > > >     }
> > > > > > It means the cvt connected to the virtual pin is already
> > > > > > different to the cvt connected to the pin 1. So we don't need to do
> anything.
> > > > > >
> > > > > > 4) Otherwise (the cvt is the same to pin 1), we need change the cvt.
> > > > > >
> > > > > > I will add more description for this function in the next version patch.
> > > > >
> > > > > One thing that is still unclear to me is how to deal with the
> > > > > unconfigured
> > > pins.
> > > > > I thought that the pins with port=non pincfg are still ignored
> > > > > in
> > > > > hdmi_add_pin() even after your patch.  So they won't be listed
> > > > > in the pins / nids arrays.
> > > >
> > > > Actually, MST code doesn't touch port=non code. It exists before.
> > > >
> > > > My understanding of this code is that port=non is HW connection
> > > > related. If this pin is not connected to any jack, it means it is
> > > > not lined out and the pin is useless for the special machine.
> > > >
> > > > >
> > > > > Now, your new code only loops over the enumerated pins, i.e.
> > > > > these unconfigured pins are ignored.  What if these pins are
> > > > > connected to the active converters?  I thought excluding such a
> > > > > connection is one of the purposes of this function, judging from the
> function description.
> > > >
> > > > If the pin is not lined out, no monitor will be connected to the pin.
> > > > So even the cvt is connected to the pin, it will impact nothing.
> > > > For MST mode, if it is not lined out, there will be never pcm
> > > > attached to the pin. This means you will never have chance to
> > > > operate the cvt
> > > connected to the pin.
> > > > Besides, I found if there is no monitor connected to the pin, the
> > > > connection list is not actually connecting to any cvt for the pin.
> > >
> > > But why the current function explicitly states that it does care
> > > about the unused pins?  There must be a reason to do so.  I vaguely
> > > remember that it was mentioned like that connecting to the unused
> > > pin causing some unexpected behavior.
> >
> > I don't know the story. Maybe in this situation, mute/unmute will be
> > messed. I will check with our internal team to see if someone knows
> > this reason.
> 
> Mengdong?

The patch of checking AC_JACK_PORT_NONE is from Stephen Warren,
who is from nvidia. I have checked with Mengdong, and she didn't 
know the patch. But it seems to be similar with intel_not_share_xxx()
function.

Regards,
Libin

> 
> 
> > You question reminds me that I should try to find a proper platform to
> > test the unused pin situation. My current test platforms can't cover
> > such situation.
> 
> Yes, a wider test coverage would be really appreciated.
> 
> 
> Takashi
