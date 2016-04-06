From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt5514: add rt5514 SPI driver
Date: Wed, 6 Apr 2016 11:30:25 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694FD0CE7@RTITMBSV03.realtek.com.tw>
References: <1457953101-19348-1-git-send-email-oder_chiou@realtek.com>
 <20160329215121.GP2350@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FCEA41@RTITMBSV03.realtek.com.tw>
 <20160331165048.GE2350@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FCF18D@RTITMBSV03.realtek.com.tw>
 <20160401141740.GY2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AD66226070F
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 13:30:34 +0200 (CEST)
In-Reply-To: <20160401141740.GY2350@sirena.org.uk>
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
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "pc.liao@mediatek.com" <pc.liao@mediatek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> > > Are you *positive* about that?  There look to be routing things going on for
> > > example which might be system dependant.
> 
> > They are the default settings for the our common hardware planning. If the
> > developer wants to modify the settings to match the different hardware
> > planning, they can consider to change the settings in the DSP firmware.
> 
> So if they do that the driver will not be compatible with their
> reconfigured firmware...  this needs to work on all systems, including
> end user ones with different system integrations.
> 
The DSP of ALC5514 is a programmable DSP, and it also can control the all
setting domain including routing path. So they can modify the different
setting on the same register address in DSP firmware. The default settings
also can be reference for the development of user's DSP firmware.
