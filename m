From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 3/4] ASoC: Intel: bytcht_es8316: fix HID
	handling
Date: Tue, 9 Jan 2018 10:18:08 +0530
Message-ID: <20180109044808.GM18649@localhost>
References: <20180105205536.10366-1-pierre-louis.bossart@linux.intel.com>
 <20180105205536.10366-4-pierre-louis.bossart@linux.intel.com>
 <20180108044321.GX18649@localhost>
 <43e8b08e-f519-280c-ea72-5344e24b896b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id ACE422674CE
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 05:43:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <43e8b08e-f519-280c-ea72-5344e24b896b@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: jeremy@jcline.org, alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 08, 2018 at 02:23:19PM -0600, Pierre-Louis Bossart wrote:

> >>+	/* fixup codec name based on HID */
> >>+	i2c_name = snd_soc_acpi_find_name_from_hid(mach->id);
> >>+	if (i2c_name) {
> >>+		snprintf(codec_name, sizeof(codec_name),
> >>+			"%s%s", "i2c-", i2c_name);
> >>+		byt_cht_es8316_dais[dai_index].codec_name = codec_name;
> >>+	}
> >
> >this looks good, but I though we had few other places where this was done,
> >esp the BSW based chromebooks, if so would it make send to have a macro in
> >soc-acpi which updates the dai name based on the result from
> >snd_soc_acpi_find_name_from_hid()
> 
> Well snd_soc_acpi_find_name_from_hid() will be replaced by an ACPI generic
> util (see proposal from Andy last week).
> 
> The idea was to add this first patch, and then do a replacement across all
> machine drivers when Andy's patch is available.
> 
> Andy also had another idea to add a helper which would take care of the for
> loop (which would indeed simplify the code further).
> 
> If that's alright with everyone, I'd like to add this patch first as is so
> that folks with the es8316 hardware get working audio, then do the two
> cleanups later.

Yeah sounds fair to me :)

-- 
~Vinod
