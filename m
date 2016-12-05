From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [PATCH 04/12] ALSA: hda: check stream decoupled
	register state
Date: Mon, 5 Dec 2016 12:22:42 +0530
Message-ID: <20161205065241.GA8021@kpjeeja-desk>
References: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
 <1480700509-23380-5-git-send-email-jeeja.kp@intel.com>
 <s5hoa0u17d5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6196E266B24
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 07:42:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hoa0u17d5.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 02, 2016 at 08:03:18PM +0100, Takashi Iwai wrote:
> On Fri, 02 Dec 2016 18:41:41 +0100,
> jeeja.kp@intel.com wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > Check stream decoupled register value with requested value
> > before decoupling/coupling the stream.
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > ---
> >  sound/hda/ext/hdac_ext_stream.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
> > index 3be051a..bd8187b 100644
> > --- a/sound/hda/ext/hdac_ext_stream.c
> > +++ b/sound/hda/ext/hdac_ext_stream.c
> > @@ -128,14 +128,17 @@ void snd_hdac_ext_stream_decouple(struct hdac_ext_bus *ebus,
> >  {
> >  	struct hdac_stream *hstream = &stream->hstream;
> >  	struct hdac_bus *bus = &ebus->bus;
> > +	u32 val;
> > +	int mask = AZX_PPCTL_PROCEN(hstream->index);
> >  
> >  	spin_lock_irq(&bus->reg_lock);
> > -	if (decouple)
> > -		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, 0,
> > -				AZX_PPCTL_PROCEN(hstream->index));
> > -	else
> > -		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL,
> > -					AZX_PPCTL_PROCEN(hstream->index), 0);
> > +	val = ((readw(bus->ppcap + AZX_REG_PP_PPCTL) & mask) >> mask);
> > +
> > +	if (decouple && (val == 0))
> > +		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, 0, mask);
> > +	else if (!decouple && (val > 0))
> > +		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, mask, 0);
> > +
> 
> The usage of snd_hdac_updatel() looks strange.
> The third argument must be the mask bits and the fourth be the value
> bits.  So, usually for clearing a bit
> 
> 	snd_hdac_update(pcap, REG, mask, 0);
> 
> and for setting a bit
> 
> 	snd_hdac_update(pcap, REG, mask, mask);
> 
> Passing 0 to the mask bits means to replace the whole bits.
> 
> This usage pattern is found already in the old code, so it's not new,
> and I'm not sure whether this behavior is intentional...

Agreed, the correct way to set a bit is to pass third and fourth argument
as mask. Will fix this overall usage of this macro and send it in another
patch series.

> 
> 
> thanks,
> 
> Takashi

-- 
