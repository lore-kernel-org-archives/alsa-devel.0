From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Mon, 12 Aug 2013 15:27:49 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935C693433@rtitmbs7.realtek.com.tw>
References: <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
 <5200DE78.5060409@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692F72@rtitmbs7.realtek.com.tw>
 <5201FB09.1080105@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692FD9@rtitmbs7.realtek.com.tw>
 <520204BB.9080603@metafoo.de> <20130807093629.GU6427@sirena.org.uk>
 <520225B4.5050208@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C6932CF@rtitmbs7.realtek.com.tw>
 <5204F0AA.1070209@metafoo.de> <20130809145846.GD6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AE817260304
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 09:28:00 +0200 (CEST)
In-Reply-To: <20130809145846.GD6427@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, August 09, 2013 10:59 PM
> To: Lars-Peter Clausen
> Cc: Bard Liao; Oder Chiou; alsa-devel@alsa-project.org; swarren@nvidia.com;
> swarren@wwwdotorg.org; lgirdwood@gmail.com; Flove
> Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: change
> widgetsequencefordepop
> 
> On Fri, Aug 09, 2013 at 03:37:46PM +0200, Lars-Peter Clausen wrote:
> > On 08/09/2013 11:05 AM, Bard Liao wrote:
> 
> > > Does "virtual switch control" mean a switch control which will not touch
> the codec's register actually?
> 
> > Yes. But Mark seems to prefer the solution using {PRE,POST}_REG events.
> 
> I don't mind that much, neither way should be a problem for the framework.

Does SOC_DAPM_SINGLE_AUTODISABLE support SND_SOC_DAPM_{PRE,POST}_REG event?
It seems SND_SOC_DAPM_{PRE,POST}_REG event is supported in SOC_DAPM_SINGLE but not in SOC_DAPM_SINGLE_AUTODISABLE.

> 
> ------Please consider the environment before printing this e-mail.
