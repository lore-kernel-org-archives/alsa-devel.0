From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] conf: topology: Add topolgy for skylake
	i2s configuration
Date: Thu, 11 Feb 2016 09:22:58 +0530
Message-ID: <20160211035258.GU19598@localhost>
References: <1454903756-2075-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5ha8naxhge.wl-tiwai@suse.de>
 <20160209114749.GA7243@subhransu-desktop>
 <s5h1t8mxfnk.wl-tiwai@suse.de>
 <20160209131415.GA26322@subhransu-desktop>
 <s5hpow6vx6l.wl-tiwai@suse.de> <20160209133432.GN19598@localhost>
 <s5hh9hivvt7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B125260644
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 04:49:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hh9hivvt7.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 09, 2016 at 02:48:36PM +0100, Takashi Iwai wrote:
> > > Well, the question is whether this IP is a programmed data block, not
> > > some simple numbers.  If yes, it's always a question whether it's
> > > compatible with GPL.  Although alsa-lib is LGPL, putting the binary
> > > blob in the *code tree* doesn't look good to me.
> > 
> > Hi Takashi,
> > 
> > This is simple numbers only. Numbers which identify the data for firmware,
> > its resources, ids, pipe number, module number and for controls default
> > values etc. Basically this struct
> > 
> > struct skl_dfw_module {
> >         char uuid[SKL_UUID_STR_SZ];
> > 
> >         u16 module_id;
> >         u16 instance_id;
> >         u32 max_mcps;
> >         u32 mem_pages;
> >         u32 obs;
> >         u32 ibs;
> >         u32 vbus_id;
> > 
> >         u32 max_in_queue:8;
> >         u32 max_out_queue:8;
> >         u32 time_slot:8;
> >         u32 core_id:4;
> >         u32 rsvd1:4;
> > 
> >         u32 module_type:8;
> >         u32 conn_type:4;
> >         u32 dev_type:4;
> >         u32 hw_conn_type:4;
> >         u32 rsvd2:12;
> > 
> >         u32 params_fixup:8;
> >         u32 converter:8;
> >         u32 input_pin_type:1;
> >         u32 output_pin_type:1;
> >         u32 is_dynamic_in_pin:1;
> >         u32 is_dynamic_out_pin:1;
> >         u32 is_loadable:1;
> >         u32 rsvd3:11;
> > 
> >         struct skl_dfw_pipe pipe;
> >         struct skl_dfw_module_fmt in_fmt[MAX_IN_QUEUE];
> >         struct skl_dfw_module_fmt out_fmt[MAX_OUT_QUEUE];
> >         struct skl_dfw_module_pin in_pin[MAX_IN_QUEUE];
> >         struct skl_dfw_module_pin out_pin[MAX_OUT_QUEUE];
> >         struct skl_dfw_module_caps caps;
> > } __packed;
> 
> OK, but how did you create it?  Via a hex editor?  If you used some
> converter, you'd better provide the readable source, too.
> 
> > > IMO, this should go to firmware tree instead, unless you can give the
> > > source code to build the binary.
> > 
> > Okay that should be fine, where do we add the source?
> 
> In alsa-lib.  It's not necessarily to be in form as all build-ready
> there, but providing the capability is important for future
> development.

Okay so we will add a intel-topology.c file to alsa-lib, this will also
include a file which will contain the above structure values for each module
in C style.

This way anyone can edit it easily and we can build blobs from alsa lib and
then run topology tool on it.

Do you have recommendation for location of these two files in alsa-lib?

Thanks
-- 
~Vinod
