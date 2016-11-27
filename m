From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC: Intel: Enabling LPE audio over I2S on Intel
 Atom E3815
Date: Sun, 27 Nov 2016 12:02:21 -0600
Message-ID: <1774ba95-807b-c85f-6505-7b7ed7eeb52a@linux.intel.com>
References: <1479878542.5675.7.camel@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A70AC266801
 for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2016 19:02:23 +0100 (CET)
In-Reply-To: <1479878542.5675.7.camel@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shrirang Bagul <shrirang.bagul@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/22/16 11:22 PM, Shrirang Bagul wrote:
> Hi,
>
> I'm attempting to enable audio on Intel Atom E3815. I have a board with RT5660
> codec from Realtek connected to the SoC over I2S2. The codec can be configured
> over I2C bus. The board supports External Mic In and Line Out connections for
> audio.
>
> I am running Ubuntu 16.04 LTS with kernel v4.4.
>
> To support RT5660 codec, I have backported patches -
> d01580c ASoC: rt5660: enable MCLK detection
> 2b26dd4 ASoC: rt5660: add rt5660 codec driver
> from https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> topic/rt5660 branch
>
> To support I2S_CLK using MCLK I've also backported the patch to support PMC
> platform clocks -
> [13/17] clk: x86: Add Atom PMC platform clocks (https://patchwork.kernel.org/pat
> ch/9277989/)
>
> To understand the I2S over LPE architecture for audio I'm referring to the Intel
> Atom Processor E3800: Datasheet (http://www.intel.com/content/dam/www/public/us/
> en/documents/datasheets/atom-e3800-family-datasheet.pdf) and discussions on
> alsa-devel mailing list thread: http://mailman.alsa-project.org/pipermail/alsa-d
> evel/2015-November/100303.html
>
> After implementing the machine driver byt-rt5660.c (by referring to byt-
> rt5640.c), the CPU DAI baytrail-pcm-audio is registered successfully and the
> fw_sst_0f28.bin-48kHz_i2s_master firmware also is loaded without any errors. It
> is possible to configure the codec controls using alsamixer.
>
> However, an attempt to record results in an empty PCM file and no audio is heard
>  if I try to playback using aplay.
>
> I'm clueless on how to proceed from this point onward in getting the audio to
> work on this board. The ouput of alsa-info.sh, clk_summary & gpio config from
> debugfs and dmesg log is attached with this message. I have published the source
> code here: http://kernel.ubuntu.com/git/snb/ubuntu-xenial.git/log/?h=x-master-au
> dio-test

You are mixing different drivers here. if you started from byt-rt5640.c 
then you started from a legacy driver that no one uses any longer in any 
products and which does not enable the 19.2 MHz MCLK which is easier to use.
You should start from bytcr_rt5640 which does handle the MCLK and is 
more robust against BIOS issues.
