From: Vedang Patel <vedang.patel@intel.com>
Subject: Re: [PATCH 1/3] ASoC: hdac_hdmi: Increase loglevel of
 hex dump printed
Date: Thu, 14 Apr 2016 08:15:50 -0700
Message-ID: <1460646950.10382.1.camel@intel.com>
References: <1460498902-30454-1-git-send-email-vedang.patel@intel.com>
 <1460498902-30454-2-git-send-email-vedang.patel@intel.com>
 <570D9C3D.5060407@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E971260870
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 17:15:53 +0200 (CEST)
In-Reply-To: <570D9C3D.5060407@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, jeeja.kp@intel.com, marc.herbert@intel.com, subhransu.s.prusty@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-04-13 at 10:09 +0900, Takashi Sakamoto wrote:
> Hi,
> 
> On Apr 13 2016 07:08, vedang.patel@intel.com wrote:
> > From: Vedang Patel <vedang.patel@intel.com>
> > 
> > The hdac_hdmi codec driver prints the ELD information everytime an
> > external monitor is connected. Make it so that the information is
> > only
> > printed when someone trying to debug the driver explicitly enables
> > it.
> 
> For this purpose, I think it better to use Linux tracing framework, 
> instead of such an ancient fashion. The type of '__dynamic_array' is 
> suitable for your aim.
> 
> As a quick glance of ASOC, there're several usage of the framework
> (see 
> include/trace/events/asoc.h). So overall, I believe it's OK to use
> the 
> framework.
> 
> I also have the same advice for your patch 3/3.
> 

Thanks Takashi for the input. I will work on it and send out the new
patches soon.

-Vedang

> > print_hex_dump uses printk(KERN_DEBUG,... which is different from
> > dev_dbg used elsewhere in the driver: it's always enabled at
> > compile-time. Add #ifdef DEBUG condition for logging consistency.
> > 
> > Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> > ---
> >   sound/soc/codecs/hdac_hdmi.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/sound/soc/codecs/hdac_hdmi.c
> > b/sound/soc/codecs/hdac_hdmi.c
> > index aaa038f..653fd9e 100644
> > --- a/sound/soc/codecs/hdac_hdmi.c
> > +++ b/sound/soc/codecs/hdac_hdmi.c
> > @@ -1066,8 +1066,10 @@ static void hdac_hdmi_present_sense(struct
> > hdac_hdmi_pin *pin, int repoll)
> >   				snd_jack_report(pcm->jack,
> > SND_JACK_AVOUT);
> >   			}
> > 
> > +#ifdef DEBUG
> >   			print_hex_dump_bytes("ELD: ",
> > DUMP_PREFIX_OFFSET,
> >   					pin->eld.eld_buffer, pin
> > ->eld.eld_size);
> > +#endif
> >   		} else {
> >   			pin->eld.monitor_present = false;
> >   			pin->eld.eld_valid = false;
> 
> 
> Regards
> 
> Takashi Sakamoto
