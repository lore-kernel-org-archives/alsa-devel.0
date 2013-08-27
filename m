From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 1/4] ALSA: hda - add flags and routines
 to get devices selection info for DP1.2 MST
Date: Tue, 27 Aug 2013 08:41:43 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8013268B5@SHSMSX101.ccr.corp.intel.com>
References: <1377467051-21579-1-git-send-email-mengdong.lin@intel.com>
 <s5hppt0lizi.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80132617B@SHSMSX101.ccr.corp.intel.com>
 <s5h38pvis5q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 473CC2610C6
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 10:41:47 +0200 (CEST)
In-Reply-To: <s5h38pvis5q.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I revised the patches to use u8 to contain the raw value of device list entry. Please review.

Thanks
Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, August 27, 2013 2:07 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH v2 1/4] ALSA: hda - add flags and routines to get devices
> selection info for DP1.2 MST
> 
> At Tue, 27 Aug 2013 03:16:50 +0000,
> Lin, Mengdong wrote:
> >
> > Hi Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Monday, August 26, 2013 8:44 PM
> > > >
> > > > +/* display pin's device list entry */ struct  hda_devlist_entry {
> > > > +	unsigned int present_detect:1;
> > > > +	unsigned int eld_valid:1;
> > > > +	unsigned int inactive:1;
> > > > +};
> > >
> > > Can't it be simply an unsigned int containing the raw value?
> > > You defined the bit flag in the above, and copying the bit field
> > > from/to the bit flag looks redundant.
> > >
> >
> > How about using "u8"?
> > Since each device entry is only 4 bits in the response to "Get Device List
> Entry" Control.
> 
> Yeah, u8 should be fine.
> 
> 
> Takashi
