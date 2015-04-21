From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Adds push button support
	for rt5650
Date: Tue, 21 Apr 2015 11:41:48 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701062EE9@RTITMBSV03.realtek.com.tw>
References: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
 <20150420204114.GI14892@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701062B62@RTITMBSV03.realtek.com.tw>
 <20150421104814.GF22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2027A2608ED
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 13:41:56 +0200 (CEST)
In-Reply-To: <20150421104814.GF22845@sirena.org.uk>
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
> Sent: Tuesday, April 21, 2015 6:48 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou; John Lin; koro.chen@mediatek.com;
> yang.a.fang@intel.com; zhengxing@rock-chips.com
> Subject: Re: [PATCH 1/2] ASoC: rt5645: Adds push button support for
> rt5650
> 
> On Tue, Apr 21, 2015 at 02:08:18AM +0000, Bard Liao wrote:
> 
> > > > -	{ 0xdd, 0x001b },
> 
> > > That's a bit weird, why is this in here?
> 
> > The default value of register 0xdd is different between rt5645 and
> rt5650.
> > And it is for button detection configuration. That's why I put it in
> > this patch instead of a separate patch.
> 
> OK, you probaly want to move to separate default tables per device.
> This is something that should have been called out in the commit log.

Do you mean we need to write it down in the commit log and send
another patch to use separate default tables for different device?
In fact, there are about 10 different registers which default value
are different between rt5645 and rt5650. We are planning to send
a separate patch for that after this patch is applied.

Regarding the different default tables, do you mean something like:
	case RT5645_DEVICE_ID:
		rt5645->codec_type = CODEC_TYPE_RT5645;
		dev_info(&i2c->dev,	"Codec type is: RT5645\n");
+		rt5645_regmap. reg_defaults = rt5645_reg;
		break;
	case RT5650_DEVICE_ID:
		rt5645->codec_type = CODEC_TYPE_RT5650;
		dev_info(&i2c->dev,	"Codec type is: RT5650\n");
+		rt5645_regmap. reg_defaults = rt5650_reg;
		break;

> 
> > > > +			switch (btn_type) {
> > > > +			case 0x8000:
> > > > +			case 0x4000:
> > > > +			case 0x2000:
> > > > +				report |= SND_JACK_BTN_0;
> > > > +				break;
> 
> > > Why do we mash all these values together?
> 
> > rt5650 can report the action of button (one click, double click or hold).
> > That is basically for Windows OS. For linux, we only care about
> > whether the button is pressed or released. So all of the three actions
> > are treated as button pressed.
> 
> OK, can we have a comment for that please?  We might want to extend
> this in the future as the userspace ABI grows richer (and depending on
> how things get reported we may need to synthesize at least a double press
> for userspace).

Do you mean comment in the source code?

> 
> ------Please consider the environment before printing this e-mail.
