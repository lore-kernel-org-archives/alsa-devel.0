From: Songhee Baek <sbaek@nvidia.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: Add support for multi register mux
Date: Wed, 26 Mar 2014 15:41:08 -0700
Message-ID: <D6C615D3E4730340AE82D5BD856631C0A26CB319B2@HQMAIL02.nvidia.com>
References: <1395792156-4178-1-git-send-email-aruns@nvidia.com>
 <53332CC7.6060800@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53332CC7.6060800@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Wednesday, March 26, 2014 12:39 PM
> To: Arun Shamanna Lakshmi
> Cc: lgirdwood@gmail.com; broonie@kernel.org; swarren@wwwdotorg.org;
> Songhee Baek; alsa-devel@alsa-project.org; tiwai@suse.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [alsa-devel] [PATCH] ASoC: Add support for multi register mux
> 
> On 03/26/2014 01:02 AM, Arun Shamanna Lakshmi wrote:
> > If the mux uses 1 bit position per input, and requires to set one
> > single bit at a time, then an N bit register can support up to N
> > inputs. In more recent Tegra chips, we have at least greater than
> > 64 inputs which requires at least 2 .reg fields in struct soc_enum.
> >
> > Signed-off-by: Arun Shamanna Lakshmi <aruns@nvidia.com>
> > Signed-off-by: Songhee Baek <sbaek@nvidia.com>
> 
> The way you describe this it seems to me that a value array for this kind of
> mux would look like.
> 
> 0x00000000, 0x00000000, 0x00000001
> 0x00000000, 0x00000000, 0x00000002
> 0x00000000, 0x00000000, 0x00000003
> 0x00000000, 0x00000000, 0x00000004
> 0x00000000, 0x00000000, 0x00000008
> ...
> 
> That seems to be extremely tedious. If the MUX uses a one hot encoding
> how about storing the index of the bit in the values array and use (1 << value)
> when writing the value to the register?

If we store the index of the bit, the value will be duplicated for each registers inputs since register has 0 to 31bits to shift, then we need to decode the index to interpret value for which registers to set. If we need to interpret the decoded value of index, it is better to have custom put/get function in our driver, isn't it?

> 
> [...]
> >   /* enumerated kcontrol */
> >   struct soc_enum {
> 
> There doesn't actually be any code that is shared between normal enums
> and wide enums. This patch doubles the size of the soc_enum struct, how
> about having a separate struct for wide enums?
> 

We are using DAPM widgets for these muxes and DAPM uses soc_enum struct inside APIs, so we couldn't use additional struct for that. If there is the way to use additional struc in dapm, please guide me.

> > -	int reg;
> > +	int reg[SOC_ENUM_MAX_REGS];
> >   	unsigned char shift_l;
> >   	unsigned char shift_r;
> >   	unsigned int items;
> > -	unsigned int mask;
> > +	unsigned int mask[SOC_ENUM_MAX_REGS];
> 
> If you make mask and reg pointers instead of arrays this should be much
> more flexible and not be limited to 3 registers.
>
 
To use pointers instead of arrays, it will be flexible but I need to update SOC_ENUM SINGLE/DOUBLE macros.
It will changes a lot in current soc-core.c and soc-dapm.c.

> >   	const char * const *texts;
> >   	const unsigned int *values;
> > +	unsigned int num_regs;
> >   };
> >
