From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [PATCH v2 4/6] ASoC: codecs: msm8916-wcd-analog: add MBHC support
Date: Thu, 3 Aug 2017 08:53:55 -0400
Message-ID: <20170803125355.l5m5mk5utl4nlbwk@workotop.localdomain>
References: <20170802170930.26083-1-srinivas.kandagatla@linaro.org>
 <20170802170930.26083-5-srinivas.kandagatla@linaro.org>
 <20170802233323.blx36uutaytdexvb@workotop.localdomain>
 <56b54da2-0e87-a466-6184-ffbd85f631c4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56b54da2-0e87-a466-6184-ffbd85f631c4@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 03, 2017 at 12:11:04PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 03/08/17 00:33, Damien Riegel wrote:
> > Hi Srinivas,
> > 
> > 
> > On Wed, Aug 02, 2017 at 07:09:28PM +0200, srinivas.kandagatla@linaro.org wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > MBHC (MultiButton Headset Control) support is available in pm8921 in two
> > > blocks, one to detect mechanical headset insertion and removal and other
> > > block to support headset type detection and 5 button detection and othe
> > > features like impedance calculation.
> > > 
> > > This patch adds support to:
> > > 1> Support to NC and NO type of headset Jacks.
> > > 2> Mechanical insertion and detection of headset jack.
> > > 3> Detect a 3 pole Headphone and a 4 pole Headset.
> > > 4> Detect 5 buttons.
> > > 
> > > Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
> > > headset/headphones.
> > 
> 
> > Good news! This version has better results. I still have an issue where
> > a headphone is reported as a headset when I do this sequence:
> 
> Hi Damien,
> 
> Thanks for testing..
> 
> 
> > 	1. connect headset
> > 	2. disconnect headset
> > 	3. connect headphone
> 
> > Following headphone connections/disconnections are reported correctly.
> > Note that I don't press the media key, it's wrongly detected when I pull
> > off the cable.
> 
> If you do step 3 slowly there is a chance that we get KEY_MEDIA events, as
> headphone is a 3 pole, during hp inserting we would end up shorting the MIC
> and GND lines on the connector, as 3-pole connectors have longer GND
> pole/connector length, this action is same as pressing MEDIA KEY.
> 
> The logic in the driver uses this MEDIA KEY press release as advantage to
> detect the accessory type before hs insertion, but this logic could break if
> we are inserting headphone slowly, which is not a normal usecase.
> 
> Any solution to this issue can be always break if we are doing slow
> insertion of hs or we endup making the driver complex. I will think about
> this once again and see how other drivers handle this usecase.

Understood, and you're right we should keep this driver as simple as
possible.

I get the KEY_MEDIA event when doing step 2 (disconnecting headset), and
I understand why it's doing that (and I think it's okay if we don't
filter out that spurious event), but we should at least get a KEY_MEDIA
release event at the same time as SW_{MICROPHONE,HEADPHONE}_INSERT
removal. It doesn't really matter if I disconnect it fast or slowly,
sometimes I'll get the KEY_MEDIA, some other times I won't.

Shouldn't mbhc_btn0_pressed be reset to false when physical removal is
detected? I think that would solve the issue of headphone being detected
as headset.


Regards,
-- 
Damien
