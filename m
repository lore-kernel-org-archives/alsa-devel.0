From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Mon, 1 Jun 2015 10:43:58 +0530
Message-ID: <20150601051358.GI3140@localhost>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
 <20150529174115.GR21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 73AC92617A4
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 07:12:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150529174115.GR21577@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 29, 2015 at 06:41:15PM +0100, Mark Brown wrote:
> On Mon, May 11, 2015 at 04:24:03PM +0530, Vinod Koul wrote:
> 
> > +static void azx_free_streams(struct soc_hdac_bus *sbus)
> > +{
> > +	struct hdac_stream *s;
> > +	struct soc_hdac_stream *stream;
> > +	struct hdac_bus *bus = hdac_bus(sbus);
> > +
> > +	while (!list_empty(&bus->stream_list)) {
> > +		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
> > +		stream = stream_to_soc_hdac_stream(s);
> > +		list_del(&s->list);
> > +		kfree(stream);
> > +	}
> > +}
> 
> Why is this (and the equivalent link function) device specific code?
> They look very generic...
In HDA we will have only one stream, but here we can have multiple links so
need to free each of them.
Also if you notice most of the code in this patch uses hdac_xxx helpers to
do the actual job

> 
> > +static int azx_acquire_irq(struct soc_hdac_bus *sbus, int do_disconnect)
> > +{
> > +	struct hda_skl *hda = to_hda_skl(sbus);
> > +	struct hdac_bus *bus = hdac_bus(sbus);
> > +	int ret = 0;
> > +
> > +	ret = request_threaded_irq(hda->pci->irq, azx_interrupt,
> > +			azx_threaded_handler,
> > +			hda->msi ? 0 : IRQF_SHARED,
> > +			KBUILD_MODNAME, sbus);
> 
> Why not just always request the interrupt as shared - we don't seem to
> care in the interrupt handling code?
I think we can move this to shared only

-- 
~Vinod
