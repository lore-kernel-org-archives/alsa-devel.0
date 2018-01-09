From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/4] ASoC: Intel: bytcht_es8316: fix HID
	handling
Date: Tue, 09 Jan 2018 12:40:49 +0200
Message-ID: <1515494449.7000.817.camel@linux.intel.com>
References: <20180105205536.10366-1-pierre-louis.bossart@linux.intel.com>
 <20180105205536.10366-4-pierre-louis.bossart@linux.intel.com>
 <20180108044321.GX18649@localhost>
 <43e8b08e-f519-280c-ea72-5344e24b896b@linux.intel.com>
 <20180109044808.GM18649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2069E26717C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 11:40:53 +0100 (CET)
In-Reply-To: <20180109044808.GM18649@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, jeremy@jcline.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-01-09 at 10:18 +0530, Vinod Koul wrote:
> On Mon, Jan 08, 2018 at 02:23:19PM -0600, Pierre-Louis Bossart wrote:

> > Well snd_soc_acpi_find_name_from_hid() will be replaced by an ACPI
> > generic
> > util (see proposal from Andy last week).
> > 
> > The idea was to add this first patch, and then do a replacement
> > across all
> > machine drivers when Andy's patch is available.
> > 
> > Andy also had another idea to add a helper which would take care of
> > the for
> > loop (which would indeed simplify the code further).
> > 
> > If that's alright with everyone, I'd like to add this patch first as
> > is so
> > that folks with the es8316 hardware get working audio, then do the
> > two
> > cleanups later.
> 
> Yeah sounds fair to me :)

No objections from my side either.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
