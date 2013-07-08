From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: add headset detection
	function
Date: Mon, 8 Jul 2013 21:12:06 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB8A897A3E83@rtitmbs7.realtek.com.tw>
References: <1373265189-24917-1-git-send-email-bardliao@realtek.com>
 <20130708112644.GR27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C53D265334
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 15:12:14 +0200 (CEST)
In-Reply-To: <20130708112644.GR27646@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, July 08, 2013 7:27 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou;
> swarren@nvidia.com; swarren@wwwdotorg.org
> Subject: Re: [PATCH] ASoC: rt5640: add headset detection function
> 
> On Mon, Jul 08, 2013 at 02:33:09PM +0800, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > Add headset detection function to rt5640 codec driver.
> 
> No, use the standard soc-jack framework for reporting accessories.

Do you mean call snd_soc_jack_report in rt5640_headset_detect to report the jack type?

> 
> ------Please consider the environment before printing this e-mail.
