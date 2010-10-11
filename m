From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Mon, 11 Oct 2010 09:34:45 +0800
Message-ID: <AANLkTi=go5q_+zw2EMh7fSa6SesNG3s8ZXjEJHsU=B--@mail.gmail.com>
References: <s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org> <4CA46E98.10402@ladisch.de>
	<4CA4A844.7060403@colin.guthr.ie>
	<20100930164753.GB9431@sirena.org.uk>
	<s5hr5gb9k83.wl%tiwai@suse.de> <4CA5834D.5030408@ladisch.de>
	<4CA59976.2020306@colin.guthr.ie> <4CA5A38A.7050006@ladisch.de>
	<i8ce5u$fj3$1@dough.gmane.org> <4CAD7F3D.3090205@ladisch.de>
	<4CAF1AF2.3060907@colin.guthr.ie> <4CAF1FA3.5000402@ladisch.de>
	<4CAF2533.1060102@colin.guthr.ie> <4CAF27B7.9080909@colin.guthr.ie>
	<4CAF2DD1.5050306@ladisch.de> <4CAF37DE.8070205@colin.guthr.ie>
	<4CAF3DA0.9020908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 66B43243EC
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 03:34:48 +0200 (CEST)
Received: by ewy9 with SMTP id 9so39977ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 18:34:48 -0700 (PDT)
In-Reply-To: <4CAF3DA0.9020908@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/8 Clemens Ladisch <clemens@ladisch.de>

> Colin Guthrie wrote:
> > What is odd about this tho', is that the flag for min is mute (0x10000)
> > is checked on tlv[3] which is also used here for the "max" value.
>
> SND_CTL_TLVT_DB_SCALE uses a flag in tlv[3] to indicate min-is-mute, but
> SND_CTL_TLVT_DB_MINMAX has a variant SND_CTL_TLVT_DB_MINMAX_MUTE.
> (The HDA driver uses DB_SCALE).
>
> > +       if (db_gain <= min) {
> >                 *value = rangemin;
> > +               if (xdir > 0 && (tlv[3] & 0x10000) && db_gain >
> SND_CTL_TLV_DB_GAIN_MUTE)
> > +                       *value = rangemin + 1;
>
> This should go at the same place in the SND_CTL_TLVT_DB_SCALE branch.
>
>
> Regards,
> Clemens
>


How about softvol plugin , the dB scale seem wrong, it alwaysl mute at
min_dB even if I change min_dB to -21 ?

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
