From: John Lin <john.lin@realtek.com>
Subject: Re: [PATCH] ASoC: rt5616: add kcontrol for headphone
	channel switch
Date: Thu, 3 Mar 2016 02:45:32 +0000
Message-ID: <14AE6189BDA733429BF8455FEEF632980110FFD1@RTITMBSV02.realtek.com.tw>
References: <1456910320-6979-1-git-send-email-john.lin@realtek.com>
 <20160302103535.GH18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A8D426066B
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 03:45:50 +0100 (CET)
In-Reply-To: <20160302103535.GH18327@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, "zhengsq@rock-chips.com" <zhengsq@rock-chips.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, March 02, 2016 6:36 PM
> To: John Lin
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Bard Liao; Flove;
> Oder Chiou; zhengsq@rock-chips.com
> Subject: Re: [PATCH] ASoC: rt5616: add kcontrol for headphone channel switch
> 
> On Wed, Mar 02, 2016 at 05:18:40PM +0800, John Lin wrote:
> 
> >  	SOC_DOUBLE("HP Playback Switch", RT5616_HP_VOL,
> >  		   RT5616_L_MUTE_SFT, RT5616_R_MUTE_SFT, 1, 1),
> > +	SOC_DOUBLE("HP Channel Switch", RT5616_HP_VOL,
> > +		   RT5616_VOL_L_SFT, RT5616_VOL_R_SFT, 1, 1),
> 
> What does "Channel Switch" mean?  It looks like this is a mute control
> in which case it shoiuld be HP Playback Switch or similar like other
> mute controls.
> 

Yes, It is another mute control that is missing on current driver.
This mute control is for headphone volume mute. Is it OK to rename it to
'Headphone Volume Playback Switch'?


> ------Please consider the environment before printing this e-mail.
