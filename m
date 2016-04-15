From: Vedang Patel <vedang.patel@intel.com>
Subject: Re: [PATCH 1/3] ASoC: hdac_hdmi: Increase loglevel of
 hex dump printed
Date: Fri, 15 Apr 2016 12:13:01 -0700
Message-ID: <1460747581.10382.20.camel@intel.com>
References: <1460498902-30454-1-git-send-email-vedang.patel@intel.com>
 <1460498902-30454-2-git-send-email-vedang.patel@intel.com>
 <570D9C3D.5060407@sakamocchi.jp> <1460646950.10382.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B91C72615C0
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 21:13:03 +0200 (CEST)
In-Reply-To: <1460646950.10382.1.camel@intel.com>
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

On Thu, 2016-04-14 at 08:15 -0700, Vedang Patel wrote:
> On Wed, 2016-04-13 at 10:09 +0900, Takashi Sakamoto wrote:
> > Hi,
> > 
> > On Apr 13 2016 07:08, vedang.patel@intel.com wrote:
> > > From: Vedang Patel <vedang.patel@intel.com>
> > > 
> > > The hdac_hdmi codec driver prints the ELD information everytime
> > > an
> > > external monitor is connected. Make it so that the information is
> > > only
> > > printed when someone trying to debug the driver explicitly
> > > enables
> > > it.
> > 
> > For this purpose, I think it better to use Linux tracing framework,
> > instead of such an ancient fashion. The type of '__dynamic_array'
> > is 
> > suitable for your aim.
> > 
> > As a quick glance of ASOC, there're several usage of the framework
> > (see 
> > include/trace/events/asoc.h). So overall, I believe it's OK to use
> > the 
> > framework.
> > 
> > I also have the same advice for your patch 3/3.
> > 
> 
> Thanks Takashi for the input. I will work on it and send out the new
> patches soon.
> 
> -Vedang
> 
Hi Takashi, 

I modified the dynamic tracing framework for this. But, i could not
find a way to present the debug messages. 

Following is how it was printed using print_hex_dump: 

Module params:00000000: 000186a0 000000c0 00000180 00000000
Module params:00000010: 0000bb80 00000010 ffffff10 00000001
Module params:00000020: 00000000 00001002 0000bb80 00000020
Module params:00000030: ffffff10 00000001 00000000 00002002
Module params:00000040: 00000000 00000000 00000300 00000000
Module params:00000050: 00000000

>From the tracing framework, I used __dynamic_array along with
__print_hex as follows: 

TP_printk("%s: %s",
	__get_str(prefix),
	__print_array(__get_dynamic_array(hex_data), 
			__entry->length, 4))

and I got: 

cras-1410  [002] ...1   640.673815: skl_adsp_module_params_dump: Module
params: a0 86 01 00 80 01 00 00 80 01 00 00 00 00 00 00 80 bb 00 00 20
00 00 00 10 ff ff ff 01 00 00 00 00 00 00 00 02 18 00 00 80 bb 00 00 20
00 00 00 10 ff ff ff 01 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00 02
0c 00 00 00 03 00 00 15 00 00 00 00 00 00 00 10 ff ff ff 32 ff ff ff 10
32 ff ff 10 32 ff ff 10 32 ff ff 10 32 ff ff 10 32 ff ff 10 32 ff ff 37
09 d0 81 00 00 70 c0 00 00 00 00 00 00 99 02 03 00 00 00 03 00 00 00 02
40 00 00 00 00 00 00 00 0f 07 07 20 00 00 00 01 00 00 00 ff 0f 00 00 00
00 00 00

Ignoring the endianness problem , I think that the previous format is
more readable compared to the one in tracing framework. Also, I just
found out that there is a print_hex_dump_debug function which can also
be enabled dynamically. Do you think using print_hex_dump_debug is a
good idea in this scenario?

Thanks,
Vedang

> > > print_hex_dump uses printk(KERN_DEBUG,... which is different from
> > > dev_db
> > > g used elsewhere in the driver: it's always enabled at
> > > compile-time. Add
> > > #ifdef DEBUG condition for logging consistency.
> > > 
> > > Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> > > ---
> > >   sound/soc/codecs/hdac_hdmi.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/sound/soc/codecs/hdac_hdmi.c
> > > b/sound/soc/codecs/hdac_hdmi.c
> > > index aaa038f..653fd9e 100644
> > > --- a/sound/soc/codecs/hdac_hdmi.c
> > > +++ b/sound/soc/codecs/hdac_hdmi.c
> > > @@ -1066,8 +1066,10 @@ static void hdac_hdmi_present_sense(struct
> > > hdac_hdmi_pin *pin, int repoll)
> > >   > > > 	> > > 	> > > 	> > > 	> > > snd_jack_report(pcm->jack,
> > > SND_JACK_AVOUT);
> > >   > > > 	> > > 	> > > 	> > > }
> > > 
> > > +#ifdef DEBUG
> > >   > > > 	> > > 	> > > 	> > > print_hex_dump_bytes("ELD: ",
> > > DUMP_PREFIX_OFFSET,
> > >   > > > 	> > > 	> > > 	> > > 	> > > 	> > > pin->eld.eld_buffer, pin
> > > ->eld.eld_size);
> > > +#endif
> > >   > > > 	> > > 	> > > } else {
> > >   > > > 	> > > 	> > > 	> > > pin->eld.monitor_present = false;
> > >   > > > 	> > > 	> > > 	> > > pin->eld.eld_valid = false;
> > 
> > 
> > Regards
> > 
> > Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
