From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Mon, 15 May 2017 13:02:55 +0100
Message-ID: <20170515120255.GL1594@localhost.localdomain>
References: <20160513114136.GM1646@localhost.localdomain>
 <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
 <20160515101308.GN1646@localhost.localdomain>
 <CAJcYhpaFiDrMYmbS1cUWL=ix-L2crjnNekpCXjjdHVThwp2Xag@mail.gmail.com>
 <20170508082422.GJ1594@localhost.localdomain>
 <CAJcYhpb0amzyug01nN3TUWBFSgGWfZcfOVfMgV01rxgTnbNnHg@mail.gmail.com>
 <7c35cd21-35a4-726d-71b5-1ef9f096fbee@linux.intel.com>
 <CAJcYhpb9yOJjDwG6ZGEYFQTiLXtkHNgmVkmF2ssQp6QPOX0ueA@mail.gmail.com>
 <6615d589-9124-5f71-0d6d-e634caf2fdaa@linux.intel.com>
 <CAJcYhpatsrYyC0CRu-0quA0=NYOObMC2nro5sDE-2ssTTu83rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A403266DFE
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 14:01:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJcYhpatsrYyC0CRu-0quA0=NYOObMC2nro5sDE-2ssTTu83rA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paulo Sergio <pstglia@gmail.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Android-x86 development <android-x86-devel@googlegroups.com>, Chih-Wei Huang <cwhuang@android-x86.org>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sat, May 13, 2017 at 02:11:31AM -0300, Paulo Sergio wrote:
> Remarks:
> 
> * setting pll/fll using snd_soc_dai_set_pll didn't work. I had to map
> the codec member from snd_soc_dai struct and use
>    snd_soc_codec_set_pll instead (used the same constants used on
> Lenovo source code)
> 

Yes this is correct you will need to call snd_soc_codec_set_pll
to configure the FLLs on the chip. As the FLLs are not tied to a
particular DAI it doesn't really make sense to configure them
from dai_set_pll.

>  - Had also to set sysclk to  codecs, not only to dai's using
> snd_soc_codec_set_sysclk
> 

Again this also makes sense snd_soc_codec_set_sysclk is how you
configure the sysclk on this device. Again here the sysclk is
chip wide.

> * This device (Lenovo Yoga 2 1051F) is a bytcr device. However bios
> status returned by iosf_mbi_read is
>     1000000001000000000000101000000 (bits 26:27 disabled).
>    Had to force  bytcr flag to be true  in order to apply correct MCLK
> frequency (25Mhz) and use SSP0
> 
> * Used commands from rt5640 UCM file, removing 5640 specifics and
> using Wolfson ones (thanks to Charles for point this out previously):
> cset name='HPOUT1L Input 1' AIF1RX1
> cset name='HPOUT1R Input 1' AIF1RX2
> cset name='HPOUT1 Digital Switch' on
> 
> 
> cset name='Headphone Switch'  on
> 
> * Used some patches to enable wm5102 ACPI detection (credits to
> Christian Hartmann)
> 
> * Added a voltage supplier needed to wm5102 (added to arizona-ldo
> directly - Lenovo and rpi register a platform with these)

Should probably look at splitting that out into its own regulator
and making it the supply for the LDO.

> * hardcoded ldoena, reset and irq_gpio on arizona-core (tried to get
> those from gpio, but they didn't give me the correct values. Lack of
> knowledge... )
> 

Not sure on this front I am afraid.

> * The codec chip uses SPI, not IC2 like 5640 (don't know if this is
> relevant for machine driver code)

This should not matter from the machine driver it should all be
hidden behing regmap at that level.

Thanks,
Charles
