From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt298: remove idle_bias_off = true
Date: Fri, 3 Jun 2016 03:09:32 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701163D65@RTITMBSV03.realtek.com.tw>
References: <1464850312-18069-1-git-send-email-bardliao@realtek.com>
 <20160602234019.GV2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D0FD226520A
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 05:09:41 +0200 (CEST)
In-Reply-To: <20160602234019.GV2282@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "Koul, Vinod" <vinod.koul@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, "senthilnathanx.veppur@intel.com" <senthilnathanx.veppur@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, June 03, 2016 7:40 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> lars@metafoo.de; Flove; Oder Chiou; senthilnathanx.veppur@intel.com;
> ramesh.babu@intel.com
> Subject: Re: [PATCH] ASoC: rt298: remove idle_bias_off = true
> 
> On Thu, Jun 02, 2016 at 02:51:52PM +0800, Bard Liao wrote:
> 
> > Codec will not go into suspend if there is any widget forced on with
> > idle_bias_off true. We want codec go into suspend when the system is
> > suspend. Also, we don't do anything in bias level OFF case. So it is
> > actually no different in bias level STANDBY or OFF case.
> 
> Hrm.  This feels like something that the framework might be doing
> wrong here.  We should either suspend the CODEC all the time even if
> there are widgets enabled or we should never suspend the CODEC even if
> there are widgets enabled but having it depend on idle_bias_off seems
> like the wrong thing here.  My expectation would be that we would not
> suspend with widgets on since the widgets being on implies the CODEC
> being on and we'd expect suspend to do things like cutting the device
> level power.
> 
> Could you talk through the use case in more detail - what's the widget
> and why is it still OK for suspend to run even with widgets on?

We need to force on "LDO1" widget when a jack is plugged in. That
is for push button detection(not implement yet). Also, all jack related
functions such as headphone playback, headset capture need "LDO1"
on. However, we don't need these functions in suspend. Also, it seems
the external power will be cut down in suspend even codec suspend
function is not called. In that case, codec will lost its register setting.
I.e. Codec registers will be cleaned. And we need to sync with cache.

> 
> ------Please consider the environment before printing this e-mail.
