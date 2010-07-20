From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - alsa-lib 1/3] tlv: Check out of range dB
	with SND_CTL_TLVT_DB_RANGE
Date: Tue, 20 Jul 2010 08:34:02 +0300
Message-ID: <201007200834.02997.peter.ujfalusi@nokia.com>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
	<1279523646-4987-2-git-send-email-peter.ujfalusi@nokia.com>
	<s5hfwzffp6x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 5450510387E
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 07:34:37 +0200 (CEST)
In-Reply-To: <s5hfwzffp6x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Monday 19 July 2010 18:48:06 ext Takashi Iwai wrote:
> > +		if (snd_tlv_get_dB_range(tlv, rangemin, rangemax,
> > +					 &dbmin, &dbmax))
> > +			return -EINVAL;
> > +		if (db_gain <=3D dbmin || db_gain >=3D dbmax) {
> > +			*value =3D db_gain <=3D dbmin ? rangemin : rangemax;
> > +			return 0;
> > +		}
> =

> The check looks good, but IMO, just plain two if's are more intuitive:
> =

> 		if (db_gain <=3D dbmin) {
> 			*value =3D rangemin;
> 			return 0;
> 		} else if (db_gain >=3D dbmax) {
> 			*value =3D rangemax;
> 			return 0;
> 		}

I will change the check, and resubmit the patch (or the series)

> thanks,
> =

> Takashi


Thank you,
P=E9ter
