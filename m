From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Adds push button support
	for rt5650
Date: Tue, 21 Apr 2015 02:08:18 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701062B62@RTITMBSV03.realtek.com.tw>
References: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
 <20150420204114.GI14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CD58260696
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 04:08:26 +0200 (CEST)
In-Reply-To: <20150420204114.GI14892@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, April 21, 2015 4:41 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou; John Lin; koro.chen@mediatek.com;
> yang.a.fang@intel.com; zhengxing@rock-chips.com
> Subject: Re: [PATCH 1/2] ASoC: rt5645: Adds push button support for
> rt5650
> 
> On Mon, Apr 20, 2015 at 10:37:21AM +0800, Bard Liao wrote:
> 
> > --- a/sound/soc/codecs/rt5645.c
> > +++ b/sound/soc/codecs/rt5645.c
> > @@ -198,7 +198,6 @@ static const struct reg_default rt5645_reg[] = {
> >  	{ 0xda, 0x0000 },
> >  	{ 0xdb, 0x0003 },
> >  	{ 0xdc, 0x0049 },
> > -	{ 0xdd, 0x001b },
> >  	{ 0xdf, 0x0008 },
> >  	{ 0xe0, 0x4000 },
> >  	{ 0xe6, 0x8000 },
> 
> That's a bit weird, why is this in here?

The default value of register 0xdd is different between rt5645 and rt5650.
And it is for button detection configuration. That's why I put it in this
patch instead of a separate patch.


> 
> > +	if (rt5645->btn_jack && rt5645->codec_type ==
> CODEC_TYPE_RT5650) {
> 
> Can we have a switch statement for the device type so it's easier to add
> other devices if there's new derivatives please?
> 
> > +			btn_type = rt5645_button_detect(rt5645->codec);
> > +			switch (btn_type) {
> > +			case 0x8000:
> > +			case 0x4000:
> > +			case 0x2000:
> > +				report |= SND_JACK_BTN_0;
> > +				break;
> 
> Why do we mash all these values together?

rt5650 can report the action of button (one click, double click or hold).
That is basically for Windows OS. For linux, we only care about whether
the button is pressed or released. So all of the three actions are treated
as button pressed.

> 
> ------Please consider the environment before printing this e-mail.
