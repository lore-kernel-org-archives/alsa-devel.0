From: Songhee Baek <sbaek@nvidia.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: Add support for multi register mux
Date: Thu, 27 Mar 2014 11:24:22 -0700
Message-ID: <D6C615D3E4730340AE82D5BD856631C0A26CB31B84@HQMAIL02.nvidia.com>
References: <1395792156-4178-1-git-send-email-aruns@nvidia.com>
 <53332CC7.6060800@metafoo.de>
 <D6C615D3E4730340AE82D5BD856631C0A26CB319B2@HQMAIL02.nvidia.com>
 <5333ED3A.7040908@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5333ED3A.7040908@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Arun Shamanna Lakshmi <aruns@nvidia.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Thursday, March 27, 2014 2:20 AM
> To: Songhee Baek
> Cc: Arun Shamanna Lakshmi; lgirdwood@gmail.com; broonie@kernel.org;
> swarren@wwwdotorg.org; alsa-devel@alsa-project.org; tiwai@suse.de;
> linux-kernel@vger.kernel.org
> Subject: Re: [alsa-devel] [PATCH] ASoC: Add support for multi register mux
> 
> On 03/26/2014 11:41 PM, Songhee Baek wrote:
> >> -----Original Message-----
> >> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> >> Sent: Wednesday, March 26, 2014 12:39 PM
> >> To: Arun Shamanna Lakshmi
> >> Cc: lgirdwood@gmail.com; broonie@kernel.org;
> swarren@wwwdotorg.org;
> >> Songhee Baek; alsa-devel@alsa-project.org; tiwai@suse.de; linux-
> >> kernel@vger.kernel.org
> >> Subject: Re: [alsa-devel] [PATCH] ASoC: Add support for multi
> >> register mux
> >>
> >> On 03/26/2014 01:02 AM, Arun Shamanna Lakshmi wrote:
> >>> If the mux uses 1 bit position per input, and requires to set one
> >>> single bit at a time, then an N bit register can support up to N
> >>> inputs. In more recent Tegra chips, we have at least greater than
> >>> 64 inputs which requires at least 2 .reg fields in struct soc_enum.
> >>>
> >>> Signed-off-by: Arun Shamanna Lakshmi <aruns@nvidia.com>
> >>> Signed-off-by: Songhee Baek <sbaek@nvidia.com>
> >>
> >> The way you describe this it seems to me that a value array for this
> >> kind of mux would look like.
> >>
> >> 0x00000000, 0x00000000, 0x00000001
> >> 0x00000000, 0x00000000, 0x00000002
> >> 0x00000000, 0x00000000, 0x00000003
> >> 0x00000000, 0x00000000, 0x00000004
> >> 0x00000000, 0x00000000, 0x00000008
> >> ...
> >>
> >> That seems to be extremely tedious. If the MUX uses a one hot
> >> encoding how about storing the index of the bit in the values array
> >> and use (1 << value) when writing the value to the register?
> >
> > If we store the index of the bit, the value will be duplicated for each
> registers inputs since register has 0 to 31bits to shift, then we need to
> decode the index to interpret value for which registers to set. If we need to
> interpret the decoded value of index, it is better to have custom put/get
> function in our driver, isn't it?
> >
> 
> I'm not sure I understand. If you use (val / 32) to pick the register and (val %
> 32) to pick the bit in the register this should work just fine. Maybe I'm missing
> something. Do you have a real world code example of of the this type of
> enum is used?
> 

I can use val/32 and val%32 for this multi register mux.

> >>> -	int reg;
> >>> +	int reg[SOC_ENUM_MAX_REGS];
> >>>    	unsigned char shift_l;
> >>>    	unsigned char shift_r;
> >>>    	unsigned int items;
> >>> -	unsigned int mask;
> >>> +	unsigned int mask[SOC_ENUM_MAX_REGS];
> >>
> >> If you make mask and reg pointers instead of arrays this should be
> >> much more flexible and not be limited to 3 registers.
> >>
> >
> > To use pointers instead of arrays, it will be flexible but I need to update
> SOC_ENUM SINGLE/DOUBLE macros.
> > It will changes a lot in current soc-core.c and soc-dapm.c.
> 
> In the existing macros you can do something like this:
> 	...
> 	.reg = &(unsigned int){(xreg)},
> 	...
> 

Ok, I will update SINGLE/DOUBLE macro with this way.

> >
> >>>    	const char * const *texts;
> >>>    	const unsigned int *values;
> >>> +	unsigned int num_regs;
> >>>    };
> >>>
> >
