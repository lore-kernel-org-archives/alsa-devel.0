From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] sound: soc: Add Cygnus audio driver
Date: Sat, 31 Oct 2015 00:28:52 +0100
Message-ID: <3878425.UJmmiCl69s@wuerfel>
References: <201510310722.jTEbgeBu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201510310722.jTEbgeBu%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Simran Rai <ssimran@broadcom.com>, kbuild-all@01.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lori Hikichi <lhikichi@broadcom.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Arun Parameswaran <arunp@broadcom.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday 31 October 2015 07:20:17 kbuild test robot wrote:
>  > 785          dev_dbg(rtd->cpu_dai->dev, "%s: size 0x%x @ 0x%p\n",
>    786                                  __func__, size, buf->area);
> 

Both reports are for the same bug: the "0x%x" should be "0x%zx".

There is another bug in the same line: "0x%p" should be "%pK",
to avoid the duplicate "0x" and to not leak the pointer when
kptr_restrict is set.

	Arnd
