From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Add Cometlake PCI IDs
Date: Wed, 8 May 2019 09:51:18 -0700
Message-ID: <CAE=gft4sDo1cLeU8Cm1CRZu2PzVG0iu-b7UaWxWVrsUeZ=SYhQ@mail.gmail.com>
References: <20190507215359.113378-1-evgreen@chromium.org> <20190507215359.113378-3-evgreen@chromium.org>
 <866afac2-e457-375b-d745-88952b11d75e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <866afac2-e457-375b-d745-88952b11d75e@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Ben Zhang <benzh@chromium.org>, Rajat Jain <rajatja@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Guenter Roeck <groeck@chromium.org>, Yu Zhao <yuzhao@google.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 7, 2019 at 3:31 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> On 5/7/19 4:53 PM, Evan Green wrote:
> > Add PCI IDs for Intel CometLake platforms, which from a software
> > point of view are extremely similar to Cannonlake platforms.
>
> Humm, I have mixed feelings here.
>
> Yes the hardware is nearly identical, with the exception of one detail
> that's not visible to the kernel, but there is no support for DMICs with
> the Skylake driver w/ HDaudio, and Chrome platforms are only going with
> SOF, so is it wise to add these two CometLake platforms to the default
> SND_SOC_INTEL_SKYLAKE selector, which is used by a number of distributions?
>
> I don't mind if we add those PCI IDs and people use this driver if they
> wish to, but it may be time for an explicit opt-in? The
> SND_SOC_INTEL_SKYLAKE definition should even be pruned to mean SKL, APL,
> KBL and GLK, and we can add DMI-based quirks for e.g. the Up2 board and
> GLK Chromebooks which work with SOF.

I don't have the context here, so feel free to ignore me. But it seems
like such a tiny amount of extra bits to add to make Cometlake work,
and then there's no hassle for the distributions when Cometlake
devices start showing up in the wild. So while things are more or less
the same, why not continue piggypacking off the default?
Or are you saying that the lack of DMIC support means the default
should be to use a different driver?
-Evan
