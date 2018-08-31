From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Date: Fri, 31 Aug 2018 13:58:57 -0700
Message-ID: <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
References: <20180606193811.16007-1-malat@debian.org>
 <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
 <20180831203752.37rsceiwotcmeses@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831203752.37rsceiwotcmeses@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 31, 2018 at 01:37:52PM -0700, Paul Burton wrote:
> Further to that, this series doesn't seem to work for me. With
> v4.19-rc1, with the patch from [1] & then this series applied I see the
> following when booting a ci20_defconfig kernel:
> 
>   [    0.846684] ALSA device list:
>   [    0.849642]   No soundcards found.

D'oh! Apparently I haven't drunk enough coffee today - missing link can
be found below:

[1] https://www.spinics.net/lists/linux-gpio/msg31965.html

Thanks,
    Paul
