From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH 0/3] support DP MST audio
Date: Wed, 28 Sep 2016 08:18:10 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D194FA305E4@SHSMSX103.ccr.corp.intel.com>
References: <1474878938-10260-1-git-send-email-libin.yang@linux.intel.com>
 <s5hlgyebssi.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D194FA2EDC7@SHSMSX103.ccr.corp.intel.com>
 <s5hintipn2f.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D194FA3011E@SHSMSX103.ccr.corp.intel.com>
 <s5hr385ojt8.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D194FA30164@SHSMSX103.ccr.corp.intel.com>
 <s5hinthohn7.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D194FA3050F@SHSMSX103.ccr.corp.intel.com>
 <s5h8tuco3sb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B6B52668AE
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 10:18:19 +0200 (CEST)
In-Reply-To: <s5h8tuco3sb.wl-tiwai@suse.de>
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

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, September 28, 2016 3:57 PM
> To: Yang, Libin <libin.yang@intel.com>
> Cc: libin.yang@linux.intel.com; alsa-devel@alsa-project.org; Lin, Mengdong
> <mengdong.lin@intel.com>
> Subject: Re: [alsa-devel] [RFC PATCH 0/3] support DP MST audio
> 
> On Wed, 28 Sep 2016 04:50:53 +0200,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > > > > If so, now my question again: for devid!=0, which connections
> > > > > are given statically?  In other words, how many devid would be
> passed?
> > > >
> > > > For the connection list, it is static. It will be initialized at bootup.
> > >
> > > So this is only about devid=0, right?  For devid!=0, there wouldn't
> > > be anything else than pin/cvt connections, correct?
> >
> > Devid != 0 is the same as devid = 0. And there is only pin/cvt connections.
> >
> > My basic idea is:
> > 1. Every device entry use a virtual pin
> 
> OK.
> 
> > 2. Each device entry will be initialized at bootup even it is not in MST mode.
> 
> Here starts unclearness.  How "*each* device entry" will be enumerated at
> boot up time?  The device id can be arbitrary numbers, per spec.

This is a good question. We really met such issue. We currently is to judge
whether it is support MST or not (if it is haswell_plus, then it supports MST).
We didn't use snd_hda_get_num_devices() to get the device number.

And if it is MST, then everything works well, each per_pin represents a device
entry.

If it is NON-MST, the device id means nothing, and snd_hda_set_dev_select()
does nothing. So we will use the first device entry (dev_id = 0) to represent
the pin.

> 
> And "even it is not in MST" means the devices that aren't capable MST (like
> SandyBridge HDMI/DP)?  Or it's meant "even when no monitor is connected
> via MST"?

I mean " even when no monitor is connected via MST". Actually, when
initialization, driver will judge the platform supports MST or not (for intel,
only haswell_plus support MST).

> 
> >     This means after bootup, mode change will not add/remove the per_pin.
> 
> What here "mode" means exactly?

Mode means MST mode or NON_MST mode.

> 
> > 3. All device entries under the same pin will use the same connection list.
> >     And the connection list is initialized at bootup. It will be saved in
> >     per_pin->mux_nids. This will never be changed after bootup.
> >     (However the pin-cvt connection is dynamically assigned when
> > necessary.)
> >
> > >
> > > > For the pin and cvt actual connection, it is dynamically assigned.
> > >
> > > ... but you still want to cache this to an (ever-growing) array for
> > > the standard connection lists.  That's what I was concerned.
> >
> > Do you mean codec->conn_list? If we don't use the dev_id and all the
> > device entries under the same pin use the same one, it will be exactly
> > the same as before.
> 
> But you touch the whole codes doing the connection list caching even by
> adding the dev_id field.  Why this is needed if you don't use the dev_id...?
> 
> Again, try not to mess up the core code as a start.  The virtual pin concept is
> OK as long as it's self-contained in the HDMI codec driver.  And adding some
> basic calls to handle the device id is fine.
> But the way to change as in patch 1 can't be included without the enough
> justification.

Yes, I understand and I will refine the patch and not touch the 
connection list core code in next patchset. In the new patch, dev_id 
will not be used in connection list. I will totally remove the patch 1.

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
