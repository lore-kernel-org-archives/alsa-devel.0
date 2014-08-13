From: Peter Chan <peter.chan@freescale.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: wm8962: Correct the bit offset to
 enable mono speaker output
Date: Wed, 13 Aug 2014 10:10:02 +0000
Message-ID: <c26b64bd035e49a7a145a0ac81b01f8e@DM2PR03MB384.namprd03.prod.outlook.com>
References: <1407412549-14983-1-git-send-email-nicoleotsuka@gmail.com>
 <20140807165836.GL17528@sirena.org.uk> <20140808082043.GB6333@MrMyself>
 <39712b9fd56546f8a943d605230a2f18@BL2PR03MB371.namprd03.prod.outlook.com>
 <20140811131949.GA28085@opensource.wolfsonmicro.com>
 <20140812082416.GA15833@opensource.wolfsonmicro.com>
 <20140812215742.GE17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140812215742.GE17528@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I found that in mono speaker mode, only the left channel is enable. The SPKOUTR_PGA_ENA bit remains 0 in this case. Thus when SPKOUTR_ENA is set, poor sound quality results.

-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: Wednesday, August 13, 2014 5:58 AM
To: Charles Keepax
Cc: CHAN Peter-B18700; alsa-devel@alsa-project.org; tiwai@suse.de; linux-kernel@vger.kernel.org; patches@opensource.wolfsonmicro.com; Wang Shengjiu-B02247; lgirdwood@gmail.com; Nicolin Chen; Chen Guangyu-B42378; rf@opensource.wolfsonmicro.com
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: Correct the bit offset to enable mono speaker output

On Tue, Aug 12, 2014 at 09:24:16AM +0100, Charles Keepax wrote:
> On Mon, Aug 11, 2014 at 02:19:49PM +0100, Charles Keepax wrote:

> > From the wording of "tie both outputs together" in the datasheet I 
> > would assume that means both should be fed the same audio? Was this 
> > done? I will try to give the hardware guys here a shout and see if I 
> > can get some clarification on mono mode on this device.

> I have had a word with the hardware team here and both channels do 
> need to be enabled but audio should only be fed to the left channel. 
> So the driver definitely needs updated for the mono case, but I am 
> unclear as to what is causing your poor audio quality issue.

Overdriving the speaker perhaps?
