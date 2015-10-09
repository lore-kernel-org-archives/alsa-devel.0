From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 4/4] ASoC: hdac_hdmi: Setup and start
	infoframe
Date: Fri, 9 Oct 2015 15:51:59 +0100
Message-ID: <20151009145157.GA3609@vkoul-mobl.iind.intel.com>
References: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
 <1444393729-19745-5-git-send-email-vinod.koul@intel.com>
 <20151009124929.GQ32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4971D2606E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 16:52:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151009124929.GQ32532@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 09, 2015 at 01:49:29PM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 09, 2015 at 01:28:49PM +0100, Vinod Koul wrote:
> > From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
> > 
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/codecs/hdac_hdmi.c | 133 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> > 
> > diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> > index 309d84122c72..2aca9ce6f423 100644
> > --- a/sound/soc/codecs/hdac_hdmi.c
> > +++ b/sound/soc/codecs/hdac_hdmi.c
> > @@ -63,6 +63,39 @@ struct hdac_hdmi_priv {
> >  	struct hdac_hdmi_dai_pin_map dai_map[3];
> >  };
> >  
> > +struct hdmi_audio_infoframe {
> > +	u8 type; /* 0x84 */
> > +	u8 ver;  /* 0x01 */
> > +	u8 len;  /* 0x0a */
> > +
> > +	u8 checksum;
> > +
> > +	u8 CC02_CT47;	/* CC in bits 0:2, CT in 4:7 */
> > +	u8 SS01_SF24;
> > +	u8 CXT04;
> > +	u8 CA;
> > +	u8 LFEPBL01_LSV36_DM_INH7;
> > +};
> 
> Any reason not to use the infrastructure in drivers/video/hdmi.c for
> generating the HDMI infoframes?  I know this is a fairly simple driver
> but I'd guess this is going to become more featureful when you move
> to supporting multichannel audio.

Only reason that we didn't look and we should have.
Mark did tell me about it yesterday, but I wanted to get the discussion
kicked off on ML before catching the plane, so posted without looking :)

I did look at these now and yes looks like we don't need these, so I will
drop this now and use it.

This actually helps me to implment multi-channel faster, thanks

-- 
~Vinod
