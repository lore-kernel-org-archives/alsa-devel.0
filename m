From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 01/12] ALSA: hdac: Add codec helper library
Date: Mon, 29 Aug 2016 19:03:57 +0530
Message-ID: <20160829133357.GF28002@subhransu-desktop>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
 <1472451806-10605-2-git-send-email-subhransu.s.prusty@intel.com>
 <s5hr398t1al.wl-tiwai@suse.de>
 <20160829124714.GA28002@subhransu-desktop>
 <s5h60qju436.wl-tiwai@suse.de>
 <20160829131750.GD28002@subhransu-desktop>
 <s5hvayjsnzw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D8030266A7F
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 19:04:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvayjsnzw.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2016 at 03:28:35PM +0200, Takashi Iwai wrote:
> On Mon, 29 Aug 2016 15:17:50 +0200,
> Subhransu S. Prusty wrote:
> > 
> > On Mon, Aug 29, 2016 at 02:55:41PM +0200, Takashi Iwai wrote:
> > > On Mon, 29 Aug 2016 14:47:33 +0200,
> > > Subhransu S. Prusty wrote:
> > > > 
> > > > On Mon, Aug 29, 2016 at 10:41:22AM +0200, Takashi Iwai wrote:
> > > > > On Mon, 29 Aug 2016 08:23:15 +0200,
> > > > > Subhransu S. Prusty wrote:
> > > > > > 
> > > > > > Add hdac helpers to enumerate the HDA widgets and fill connection
> > > > > > lists for each.
> > > > > > 
> > > > > > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > > > > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > > > > > ---
> > > > > >  include/sound/hdaudio.h    |   1 +
> > > > > >  sound/hda/ext/Makefile     |   3 +-
> > > > > >  sound/hda/ext/hdac_codec.c | 182 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  sound/hda/ext/hdac_codec.h |  53 +++++++++++++
> > > > > >  4 files changed, 238 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 sound/hda/ext/hdac_codec.c
> > > > > >  create mode 100644 sound/hda/ext/hdac_codec.h
> > > > > > 
> > > > > > diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> > > > > > index 93e63c5..79502dc 100644
> > > > > > --- a/include/sound/hdaudio.h
> > > > > > +++ b/include/sound/hdaudio.h
> > > > > > @@ -71,6 +71,7 @@ struct hdac_device {
> > > > > >  			 unsigned int flags, unsigned int *res);
> > > > > >  
> > > > > >  	/* widgets */
> > > > > > +	struct list_head widget_list;
> > > > > >  	unsigned int num_nodes;
> > > > > >  	hda_nid_t start_nid, end_nid;
> > > > > 
> > > > > Any reason to add this to hdac_device although it's used only by
> > > > > hda/ext?
> > > > 
> > > > Hi Takashi,
> > > > 
> > > > Added this in the hdac_device, as this looked to be the more suitable data
> > > > structure for the widget_list and is more specific to the hdac device. 
> > > 
> > > Doesn't struct hdac_ext_device fit better?
> > 
> > The snd_hdac_parse_widgets helper defined in hdac_codec.c populates members
> > of hdac_device structure like num_nodes, start_nid etc. Even though
> > widget_list is used in hda/ext, this looked generic to be added in
> > hdac_device.
> 
> If it's used only in hda/ext, why it's generic, i.e. putting to the
> place used commonly for legacy drivers?  I don't follow this logic...
> 
> > I am inclined to add these helpers in hdac_device.c or may be
> > move hdac_codec.c to sound/hda if you are ok.
> 
> Even if we put it in hdac_device, initializing in another function is
> wrong.  It must be initialized in snd_hdac_device_init(), if it's a
> part of the common struct.

Ok, got it. Will move this to hdac_ext_device.

Regards,
Subhransu
-- 
