From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 3/7] ASoC: hda - add soc hda codec
	driver wrapper
Date: Fri, 17 Apr 2015 17:04:54 +0530
Message-ID: <20150417113454.GB30624@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
 <1429262000-21517-4-git-send-email-vinod.koul@intel.com>
 <s5htwwfxf9s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 592E8260586
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 13:39:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htwwfxf9s.wl-tiwai@suse.de>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2015 at 11:42:07AM +0200, Takashi Iwai wrote:
> At Fri, 17 Apr 2015 14:43:16 +0530,
> Vinod Koul wrote:
> > +/*
> > + * find a matching vendor id
> > + */
> > +static int hda_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
> > +{
> > +	struct hda_soc_codec_driver *driver =
> > +		container_of(drv, struct hda_soc_codec_driver, core);
> > +
> > +	if (driver->id_table) {
> > +		const struct hda_soc_device_id *id  = driver->id_table;
> > +
> > +		while (id->name[0]) {
> > +			if (dev->vendor_id == id->id)
> > +				return 1;
> > +			id++;
> 
> Does checking only the vendor id suffice?  In the legacy driver, we
> had to check sometimes the revision number.  (Or, some Realtek codecs
> give different names depending on the revision id, etc.)
Rightly pointed so, we definately need revision id too

I will fix this up
-- 
~Vinod
