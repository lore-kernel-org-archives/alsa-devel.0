From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Wed, 07 Aug 2013 12:47:16 +0200
Message-ID: <520225B4.5050208@metafoo.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id A2D14261B11
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 12:47:03 +0200 (CEST)
In-Reply-To: <20130807093629.GU6427@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 08/07/2013 11:36 AM, Mark Brown wrote:
> On Wed, Aug 07, 2013 at 10:26:35AM +0200, Lars-Peter Clausen wrote:
>
>> That isn't really supported right now. If muting and unmuting the control is
>> such a complex sequence maybe it is better to stay with you previous
>> solution, without autodisable.
>
> Adding an event callback shouldn't be hard?
>

But tricky. The widget of course can have a event callback, but since the 
widget is created by the DAPM layer and not the codec driver there is currently 
no way to setup the callback. And then there is of course the question when do 
you want to run the callback, only if DAPM unmutes the control, if the user 
unmutes the control or both.

One thing that could work is to setup SND_SOC_DAPM_{PRE,POST}_REG events for 
the SWITCH widget. This callback gets called whenever user changes the control 
(and it is not disabled by DAPM). The next step then would be to set up an 
internal event callback for kcontrol widgets which then again calls the event 
callbacks for the kcontrol's widgets like we do in dapm_widget_update(). But 
I'm not convinced that this is the best way to solve this. I think it makes 
things more complicated than they need to be. I think having a OUTDRV widget 
along the path that runs the mute and unmute sequence might be a better option. 
And then have virtual switch control to let userspace disconnect the path, so 
that it is still possbile to manually mute it.

- Lars
