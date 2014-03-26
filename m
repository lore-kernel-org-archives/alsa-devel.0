From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add support for multi register mux
Date: Wed, 26 Mar 2014 20:38:47 +0100
Message-ID: <53332CC7.6060800@metafoo.de>
References: <1395792156-4178-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395792156-4178-1-git-send-email-aruns@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, swarren@wwwdotorg.org, Songhee Baek <sbaek@nvidia.com>, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/26/2014 01:02 AM, Arun Shamanna Lakshmi wrote:
> If the mux uses 1 bit position per input, and requires to set one
> single bit at a time, then an N bit register can support up to N
> inputs. In more recent Tegra chips, we have at least greater than
> 64 inputs which requires at least 2 .reg fields in struct soc_enum.
>
> Signed-off-by: Arun Shamanna Lakshmi <aruns@nvidia.com>
> Signed-off-by: Songhee Baek <sbaek@nvidia.com>

The way you describe this it seems to me that a value array for this kind of 
mux would look like.

0x00000000, 0x00000000, 0x00000001
0x00000000, 0x00000000, 0x00000002
0x00000000, 0x00000000, 0x00000003
0x00000000, 0x00000000, 0x00000004
0x00000000, 0x00000000, 0x00000008
...

That seems to be extremely tedious. If the MUX uses a one hot encoding how 
about storing the index of the bit in the values array and use (1 << value) 
when writing the value to the register?

[...]
>   /* enumerated kcontrol */
>   struct soc_enum {

There doesn't actually be any code that is shared between normal enums and 
wide enums. This patch doubles the size of the soc_enum struct, how about 
having a separate struct for wide enums?

> -	int reg;
> +	int reg[SOC_ENUM_MAX_REGS];
>   	unsigned char shift_l;
>   	unsigned char shift_r;
>   	unsigned int items;
> -	unsigned int mask;
> +	unsigned int mask[SOC_ENUM_MAX_REGS];

If you make mask and reg pointers instead of arrays this should be much more 
flexible and not be limited to 3 registers.

>   	const char * const *texts;
>   	const unsigned int *values;
> +	unsigned int num_regs;
>   };
>
