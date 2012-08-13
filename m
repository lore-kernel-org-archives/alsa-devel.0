From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 1/3] ALSA: hda - show ICT/KAE control bits
Date: Mon, 13 Aug 2012 07:56:29 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48900FF4427A@SHSMSX102.ccr.corp.intel.com>
References: <1344838271-3528-1-git-send-email-xingchao.wang@intel.com>
 <s5hr4rbw8bd.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48900FF4424F@SHSMSX102.ccr.corp.intel.com>
 <s5hmx1zw7l1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 612FE26528C
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 09:26:47 +0200 (CEST)
In-Reply-To: <s5hmx1zw7l1.wl%tiwai@suse.de>
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



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, August 13, 2012 3:54 PM
> To: Wang, Xingchao
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH 1/3] ALSA: hda - show ICT/KAE control bits
> 
> At Mon, 13 Aug 2012 07:49:40 +0000,
> Wang, Xingchao wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: alsa-devel-bounces@alsa-project.org
> > > [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi
> > > Iwai
> > > Sent: Monday, August 13, 2012 3:38 PM
> > > To: Wang, Xingchao
> > > Cc: alsa-devel@alsa-project.org
> > > Subject: Re: [alsa-devel] [PATCH 1/3] ALSA: hda - show ICT/KAE
> > > control bits
> > >
> > > At Mon, 13 Aug 2012 14:11:09 +0800,
> > > Wang Xingchao wrote:
> > > >
> > > > Enable two debug options for S/PDIF Converter Control.
> > > > KAE: Keep Alive Enable; ICT: IEC Coding Type.
> > > >
> > > > Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
> > > > ---
> > > >  sound/pci/hda/hda_codec.h |    4 ++++
> > > >  sound/pci/hda/hda_proc.c  |    4 ++++
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
> > > > index c422d33..141b3b8 100644
> > > > --- a/sound/pci/hda/hda_codec.h
> > > > +++ b/sound/pci/hda/hda_codec.h
> > > > @@ -386,6 +386,10 @@ enum {
> > > >  /* DIGITAL2 bits */
> > > >  #define AC_DIG2_CC			(0x7f<<0)
> > > >
> > > > +/* DIGITAL3 bits */
> > > > +#define AC_DIG3_ICT			(0xf<<0)
> > > > +#define AC_DIG3_KAE			(1<<23)
> > >
> > > For DIG3, it should be 1<<7.  (dig3 begins from bit 16.)
> >
> > Okay.
> > >
> > > > +
> > > >  /* Pin widget control - 8bit */
> > > >  #define AC_PINCTL_EPT			(0x3<<0)
> > > >  #define AC_PINCTL_EPT_NATIVE		0
> > > > diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
> > > > index 7e46258..a222aae 100644
> > > > --- a/sound/pci/hda/hda_proc.c
> > > > +++ b/sound/pci/hda/hda_proc.c
> > > > @@ -419,9 +419,13 @@ static void print_digital_conv(struct
> > > > snd_info_buffer
> > > *buffer,
> > > >  		snd_iprintf(buffer, " Pro");
> > > >  	if (digi1 & AC_DIG1_LEVEL)
> > > >  		snd_iprintf(buffer, " GenLevel");
> > >
> > > Comparing dig1 and dig3 bitmask looks strange.
> >
> > What about also add digi2 to specify AC_DIG1_LEVEL and CC? They are bit
> 7:14.
> 
> These are DIG1_LEVEL is dig1.
> DIG2_CC isn't _compared_ with dig1.  But it would be clearer if it's deduced
> from dig2, yes.

Yeah, I made the v2 change. 

Thanks
--xingchao
