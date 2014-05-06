From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Tue, 6 May 2014 12:04:27 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D73D68A0@RTITMBSV03.realtek.com.tw>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
 <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
 <20140418103715.GJ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D056C2610A5
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 14:04:33 +0200 (CEST)
In-Reply-To: <20140418103715.GJ12304@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, April 18, 2014 6:37 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de; Flove;
> Oder Chiou; Gustaw Lewandowski
> Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
> 
> On Thu, Apr 17, 2014 at 05:39:08AM +0000, Bard Liao wrote:
> 
> > > You can implement non-register DAPM widgets - look at the virtual
> > > controls in the core, or things using SND_SOC_NOPM.
> 
> > It means dapm widget will not control the codec directly, right?
> > I.e. Everything will be done by _event?
> 
> The framework won't do anything directly, yes.
> 

I have a question about the virtual controls.

Virtual controls assume there is no related register related to the controls, so codec
doesn't need to set anything when the control's value is changed in general cases.
But rt286 need to do something when the control's value is changed especially mux
settings.

I have no idea when should codec driver set the corresponding registers of the controls.
The SND_SOC_DAPM_POST_REG event seems not works in virtual controls. Also, I didn't
find a suitable API to get a virtual control's value. Look like dapm_kcontrol_get_value
can do that, but dapm_kcontrol_get_value is not exported.

I am trying to define a .put function in snd_kcontrol_new, so that I can set corresponding 
registers to the control. But I don't know how to update dapm path's connect status. I don't
know if snd_soc_dapm_mux_update_power can do that.

Do you have any suggestion for setting corresponding registers of a virtual control?

Thanks.

> 
> ------Please consider the environment before printing this e-mail.
