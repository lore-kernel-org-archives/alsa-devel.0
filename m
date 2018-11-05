From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
Date: Mon, 5 Nov 2018 15:35:45 +0200
Message-ID: <20181105133545.GF10650@smile.fi.intel.com>
References: <20181102112456.780127-1-arnd@arndb.de>
 <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
 <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Naveen Manohar <naveen.m@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 04, 2018 at 10:45:17AM -0600, Pierre-Louis Bossart wrote:

> So yes indeed we have to add a select HDAC_HDA statement under the SKYLAKE
> config - i just don't know of any other means to say "don't build HDAC_HDA
> as a module when SKYLAKE is buit-in"

We have this ("strange") lines over the drivers:

config BAR
depends on FOO || FOO=n

which guarantees that FOO will be not module when BAR is built-in.

-- 
With Best Regards,
Andy Shevchenko
