From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 10/14] ASoC: SOF: Add userspace ABI
	support
Date: Fri, 21 Dec 2018 13:10:10 +0200
Message-ID: <CAEnQRZC5YR_+GaynK-1iWAZ5ztiJVtrcLHA4S2o0Ws8OwoWXUw@mail.gmail.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-11-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-11-pierre-louis.bossart@linux.intel.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

<snip>
I have one question here, it is more related to the design of address
space you are using.

> --- /dev/null
> +++ b/include/uapi/sound/sof/fw.h

> +/*
> + * Firmware module is made up of 1 . N blocks of different types. The
> + * Block header is used to determine where and how block is to be copied in the
> + * DSP/host memory space.
> + */

> +enum snd_sof_fw_blk_type {
> +       SOF_BLK_IMAGE   = 0,    /* whole image - parsed by ROMs */
> +       SOF_BLK_TEXT    = 1,
> +       SOF_BLK_DATA    = 2,
> +       SOF_BLK_CACHE   = 3,
> +       SOF_BLK_REGS    = 4,
> +       SOF_BLK_SIG     = 5,
> +       SOF_BLK_ROM     = 6,
> +       /* add new block types here */
> +};
> +
> +struct snd_sof_blk_hdr {
> +       enum snd_sof_fw_blk_type type;
> +       uint32_t size;          /* bytes minus this header */
> +       uint32_t offset;        /* offset from base */
> +} __packed;

This assumes that all sections of the firmware are placed in the same
"type" of memory area, right?

We can go with that for the moment.

On our side, because OCRAM is pretty small we found it useful to place
some parts of the binary in SDRAM.

So, I'm wondering if you considered that? I think with the current design
is fairly easy to support that. Just add inside snd_sof_blk_hdr also the "base",
make the loader.c correctly parse that. Also, make rimage aware of this.

thanks,
Daniel.
