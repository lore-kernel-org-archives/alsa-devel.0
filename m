From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: add headset detection
	function
Date: Thu, 25 Jul 2013 11:36:42 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935C48A2B2@rtitmbs7.realtek.com.tw>
References: <1374562469-5190-1-git-send-email-bardliao@realtek.com>
 <20130723130016.GA9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 87DD8265578
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 05:36:48 +0200 (CEST)
In-Reply-To: <20130723130016.GA9858@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, July 23, 2013 9:00 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou
> Subject: Re: [PATCH] ASoC: rt5640: add headset detection function
> 
> On Tue, Jul 23, 2013 at 02:54:29PM +0800, bardliao@realtek.com wrote:
> 
> > + * @codec: SoC audio codec device.
> > + * @jack_insert: Jack insert or not.
> > + *
> > + * Detect whether is headset or not when jack inserted.
> > + *
> > + * Returns detect status.
> > + */
> > +int rt5640_headset_detect(struct snd_soc_codec *codec,
> > +				struct snd_soc_jack *jack, int jack_insert)
> 
> This doesn't look like it implements jack detection, it looks like it's some sort of
> callback.  I'd expect to see some sort of interrupt for example...
> 
> What's going on here?

Usually, our customers use cpu's gpio as the interrupt pin of jack insert/remove.
So we assume they will handle the interrupt event in machine driver.
When machine driver get a jack insert/remove event, it will call this function to know the jack type(headset or headphone).
Should I handle the interrupt event in codec driver?


> 
> ------Please consider the environment before printing this e-mail.
