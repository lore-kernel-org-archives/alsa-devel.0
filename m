From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/7] ASoC: ts3a227e: add acpi table
Date: Mon, 18 Sep 2017 09:06:09 +0530
Message-ID: <20170918033609.GE30097@localhost>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
 <20170908051309.19028-6-pierre-louis.bossart@linux.intel.com>
 <20170908132705.GH3053@localhost>
 <20292830-6f66-a67e-8030-a7eaf808c3fe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 06DB8266819
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 05:32:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20292830-6f66-a67e-8030-a7eaf808c3fe@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Thierry Escande <thierry.escande@collabora.com>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 08, 2017 at 08:30:37AM -0500, Pierre-Louis Bossart wrote:
> 
> >>+#ifdef CONFIG_ACPI
> >>+static struct acpi_device_id ts3a227e_acpi_match[] = {
> >>+	{ "104C227E", 0 },
> >>+	{},
> >>+};
> >>+MODULE_DEVICE_TABLE(acpi, ts3a227e_acpi_match);
> >>+#endif
> >
> >so this is not present for non ACPI system,... fine
> >
> >>+
> >>  static struct i2c_driver ts3a227e_driver = {
> >>  	.driver = {
> >>  		.name = "ts3a227e",
> >>  		.pm = &ts3a227e_pm,
> >>  		.of_match_table = of_match_ptr(ts3a227e_of_match),
> >>+		.acpi_match_table = ACPI_PTR(ts3a227e_acpi_match),
> >
> >but then this would give compiler error on those systems as .acpi_match_table is
> >defined in driver core... can you compile this on non acpi and check
> 
> This is not any different from what is done for other codecs.
> 
> static struct i2c_driver rt5677_i2c_driver = {
> 	.driver = {
> 		.name = "rt5677",
> 		.of_match_table = rt5677_of_match,
> 		.acpi_match_table = ACPI_PTR(rt5677_acpi_match),
> 	},
> 
> And the 0day checks did not report any issues, probably because the
> pre-processor takes the table out when CONFIG_ACPI is not enabled:
> 
> #define ACPI_PTR(_ptr)	(NULL)

Yeah thanks for pointing, missed this one :)

> so no change...

yup :)

-- 
~Vinod
