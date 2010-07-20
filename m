From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/3] ASoC: twl4030/tpa6130a2:?DB_RANGE
	mapping fixes
Date: Tue, 20 Jul 2010 08:39:16 +0300
Message-ID: <201007200839.16372.peter.ujfalusi@nokia.com>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100719103038.GA9203@rakim.wolfsonmicro.main>
	<s5h4ofvfnfw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D357F10389A
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 07:39:22 +0200 (CEST)
In-Reply-To: <s5h4ofvfnfw.wl%tiwai@suse.de>
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
Cc: ext Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Monday 19 July 2010 19:25:55 ext Takashi Iwai wrote:
> At Mon, 19 Jul 2010 11:30:38 +0100,
> =

> Mark Brown wrote:
> > On Mon, Jul 19, 2010 at 12:14:49PM +0300, Peter Ujfalusi wrote:
> > > I see, but I still don't see problem with this:
> > Meh, that works but I guess my brain can't imagine concepts that ugly :)
> =

> TLV_DB_MINMAX would be slightly easier to parse:
> =

> static const unsigned int tlv[] =3D {
>         TLV_DB_RANGE_HEAD(3),
>         1, 3, TLV_DB_MINMAX_ITEM(0, 400),
>         3, 4, TLV_DB_MINMAX_ITEM(400, 500)
>         4, 6, TLV_DB_MINMAX_ITEM(500, 900),
> };

I agree, that the TLV_DB_MINMAX might be easier to digest, but I want to ke=
ep =

the TLV_DB_SCALE in these drivers (tpa6130a2, and tlw4030).
I might need to limit the volume range, and that is not really possible wit=
h the =

MINMAX (the ASoC volume limiting only works with TLV_DB_SCALE type).

-- =

P=E9ter
