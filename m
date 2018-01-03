From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget
	type to supply.
Date: Wed, 3 Jan 2018 12:45:49 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7027552DE@RTITMBSV02.realtek.com.tw>
References: <20180102185314.17189-1-hdegoede@redhat.com>
 <20180102185314.17189-2-hdegoede@redhat.com>
 <20180103105053.GA5603@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id E42E62668F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 13:45:55 +0100 (CET)
In-Reply-To: <20180103105053.GA5603@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, January 03, 2018 6:51 PM
> To: Hans de Goede
> Cc: Bard Liao; Oder Chiou; Takashi Iwai; alsa-devel@alsa-project.org
> Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget type to supply.
> 
> On Tue, Jan 02, 2018 at 07:53:09PM +0100, Hans de Goede wrote:
> 
> > Register "micbias1" and "micbias2" to supply widegts as modern drivers do.
> 
> > -	SND_SOC_DAPM_MICBIAS("micbias1", RT5645_PWR_ANLG2,
> > -			RT5645_PWR_MB1_BIT, 0),
> > -	SND_SOC_DAPM_MICBIAS("micbias2", RT5645_PWR_ANLG2,
> > -			RT5645_PWR_MB2_BIT, 0),
> > +	SND_SOC_DAPM_SUPPLY("micbias1", RT5645_PWR_ANLG2,
> > +			RT5645_PWR_MB1_BIT, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY("micbias2", RT5645_PWR_ANLG2,
> > +			RT5645_PWR_MB2_BIT, 0, NULL, 0),
> 
> This is a good change to make but we have machines with the rt5645, are
> we sure none of them use microphones?  The two widget types work
> differently so it needs some checking and possibly machine driver
> updates to convert.

It's late today. I will check it tomorrow. I will send patches for
those machine driver and device tree which use rt5645 or rt5650
micbias.


> 
> ------Please consider the environment before printing this e-mail.
