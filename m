From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Fri, 9 Aug 2013 17:05:43 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935C6932CF@rtitmbs7.realtek.com.tw>
References: <1121E117AD4ECE49880A389A396215BB935C692E40@rtitmbs7.realtek.com.tw>
 <5200C369.6050607@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E62@rtitmbs7.realtek.com.tw>
 <5200CD0D.7030007@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
 <5200DE78.5060409@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692F72@rtitmbs7.realtek.com.tw>
 <5201FB09.1080105@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692FD9@rtitmbs7.realtek.com.tw>
 <520204BB.9080603@metafoo.de> <20130807093629.GU6427@sirena.org.uk>
 <520225B4.5050208@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 817AD26571F
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 11:05:53 +0200 (CEST)
In-Reply-To: <520225B4.5050208@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> One thing that could work is to setup SND_SOC_DAPM_{PRE,POST}_REG
> events for the SWITCH widget. This callback gets called whenever user
> changes the control (and it is not disabled by DAPM). The next step then would
> be to set up an internal event callback for kcontrol widgets which then again
> calls the event callbacks for the kcontrol's widgets like we do in
> dapm_widget_update(). But I'm not convinced that this is the best way to solve
> this. I think it makes things more complicated than they need to be. I think
> having a OUTDRV widget along the path that runs the mute and unmute
> sequence might be a better option.
> And then have virtual switch control to let userspace disconnect the path, so
> that it is still possbile to manually mute it.

Does "virtual switch control" mean a switch control which will not touch the codec's register actually?

> 
> - Lars
> 
> ------Please consider the environment before printing this e-mail.
