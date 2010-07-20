From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - alsa-lib 2/3] tlv: Handle 'holes' in
	SND_CTL_TLVT_DB_RANGE array
Date: Tue, 20 Jul 2010 09:06:58 +0300
Message-ID: <201007200906.58913.peter.ujfalusi@nokia.com>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
	<1279523646-4987-3-git-send-email-peter.ujfalusi@nokia.com>
	<s5heiezfp1c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 223421037F8
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 08:07:30 +0200 (CEST)
In-Reply-To: <s5heiezfp1c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Takashi Iwai <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

On Monday 19 July 2010 18:51:27 ext Takashi Iwai wrote:
> At Mon, 19 Jul 2010 10:14:05 +0300,
> =

> Peter Ujfalusi wrote:
> > When converting from dB to raw value, and DB_RANGE is
> > used with non overlapping map, dB value in between the
> > sub ranges will be not found.
> > =

> > For example, if the control has the following:
> > 0: -10dB
> > 1: -5dB
> > 2: 0dB
> > 3: 2dB
> > 4: 4dB
> > =

> > static const unsigned int nonoverlapping_tlv[] =3D {
> > =

> >         TLV_DB_RANGE_HEAD(2),
> >         0, 2, TLV_DB_SCALE_ITEM(-1000, 500, 0),
> >         3, 4, TLV_DB_SCALE_ITEM(200, 200, 0),
> > =

> > };
> > =

> > Range 1: -10 .. 0dB
> > Range 2: 2 .. 4dB
> > =

> > If user asks for 1dB the snd_tlv_convert_from_dB will not find
> > the raw value, since the 1dB is not part of either range.
> =

> In the case above, can't you set like
> =

> 	TLV_DB_RANGE_HEAD(2),
> 	0, 2, TLV_DB_SCALE_ITEM(-1000, 500, 0),
> 	2, 4, TLV_DB_SCALE_ITEM(0, 200, 0)
> =

> ??

This is exactly what I submitted for the drivers I maintain.
Mark suggested that instead of doing this in driver, I should fix this in a=
lsa-
lib level.
This patch tries to do exactly that.
Personally I do prefer the way I patched the drivers, and you are also =

suggesting, but Mark has different opinion, so this has to be worked out.

-- =

P=E9ter
