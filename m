From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v1 0/2] ASoC: Intel: Add Cometlake PCI IDs
Date: Mon, 6 May 2019 15:56:18 -0700
Message-ID: <CAE=gft6HNYqm7Jvh4hwgCLEaRVZ+95AJdYEncRKsq_ZmBidiqg@mail.gmail.com>
References: <20190506225321.74100-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506225321.74100-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Naveen M <naveen.m@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Ben Zhang <benzh@chromium.org>, Rajat Jain <rajatja@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Guenter Roeck <groeck@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 6, 2019 at 3:53 PM Evan Green <evgreen@chromium.org> wrote:
>
>
> This small series adds PCI IDs for Cometlake platforms, for a
> dazzling audio experience.
>
>
> Evan Green (2):
>   ASoC: SOF: Add Comet Lake PCI ID
>   ASoC: Intel: Skylake: Add Cometlake PCI IDs
>
>  sound/soc/intel/Kconfig                |  9 +++++++++
>  sound/soc/intel/skylake/skl-messages.c |  8 ++++++++
>  sound/soc/intel/skylake/skl.c          |  5 +++++
>  sound/soc/sof/intel/Kconfig            | 16 ++++++++++++++++
>  sound/soc/sof/sof-pci-dev.c            |  4 ++++
>  5 files changed, 42 insertions(+)
>
> --
> 2.20.1
>

I should have mentioned that I based this off of linux-next next-20190506.
-Evan
