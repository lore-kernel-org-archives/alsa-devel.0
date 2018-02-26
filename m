From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: Applied "ASoC: topology: Fix logical inversion in set_link_hw_format()" to the asoc tree
Date: Mon, 26 Feb 2018 19:34:07 +0100
Message-ID: <20180226183407.22335-1-k.marinushkin@gmail.com>
References: <E1eqGmV-0005Rk-Jt@debutante>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <E1eqGmV-0005Rk-Jt@debutante>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Mark Brown, Pan Xiuli,

As far as I understand, the suggested commit *breaks* the functionality instead
of fixing it, and should not be applied. Please correct me if I am wrong.


1. The existing functionality works correctly, nothing to fix here.

Below is a comment from include/sound/soc-dai.h:77

~~~~
/*
 * DAI hardware clock masters.
 *
 * This is wrt the codec, the inverse is true for the interface
 * i.e. if the codec is clk and FRM master then the interface is
 * clk and frame slave.
 */
#define SND_SOC_DAIFMT_CBM_CFM		(1 << 12) /* codec clk & FRM master */
#define SND_SOC_DAIFMT_CBS_CFM		(2 << 12) /* codec clk slave & FRM master */
#define SND_SOC_DAIFMT_CBM_CFS		(3 << 12) /* codec clk master & frame slave */
#define SND_SOC_DAIFMT_CBS_CFS		(4 << 12) /* codec clk & FRM slave */
~~~~

According to the comment, the existing functionality works correctly "WRT the
interface". The suggested commit doesn't fix the behaviour: instead, it reverts
the logic to "WRT the codec". But the existing implementation is also valid.


2. The suggested commit breaks the existing ASoC.

The existing functionality already works with several existing ASoC by
Intel. The suggested commit will break it for the following reason:

The ALSA topology mechanism loads the binary topology file into ASoC. The
suggested commit modifies the parser, but the binaries are already created for
the existing functionality. As a result, all existing binaries will be parsed
incorrectly.


3. The suggested commit should not go into stable.

For the reasons explained earlier, applying the suggested commit into stable
kernel will break the stable kernel.

As I am not in the mailing list, I will not be able to stop Greg K-H
<gregkh@linuxfoundation.org> when he will ask "If you, or anyone else, feels it
should not be added to the stable tree, please let <stable@vger.kernel.org> know
about it."

@Mark Brown could you please add me to the thread if such situation happens, so
that I could share my point for the stable patches.

Best Regards,
Kirill
