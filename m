From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: TWL4030: Add shadow register
Date: Mon, 25 May 2009 11:05:44 +0300
Message-ID: <200905251105.44988.peter.ujfalusi@nokia.com>
References: <1243237479-18631-1-git-send-email-peter.ujfalusi@nokia.com>
	<1243237479-18631-3-git-send-email-peter.ujfalusi@nokia.com>
	<s5h3aatd3nm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E312810382A
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 10:05:48 +0200 (CEST)
In-Reply-To: <s5h3aatd3nm.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Monday 25 May 2009 10:48:13 ext Takashi Iwai wrote:
> At Mon, 25 May 2009 10:44:38 +0300,
>
> Peter Ujfalusi wrote:
> > Shadow, non HW register for dealing with the HandsfreeL/R
> > muting.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> >  sound/soc/codecs/twl4030.c |    7 ++++++-
> >  sound/soc/codecs/twl4030.h |    7 ++++++-
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> > index 17ddcb2..a59e817 100644
> > --- a/sound/soc/codecs/twl4030.c
> > +++ b/sound/soc/codecs/twl4030.c
> > @@ -115,6 +115,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] =
=3D {
> >  	0x00, /* REG_VIBRA_PWM_SET	(0x47)	*/
> >  	0x00, /* REG_ANAMIC_GAIN	(0x48)	*/
> >  	0x00, /* REG_MISC_SET_2		(0x49)	*/
> > +	0x00, /* REG_SW_SHADOW		(0x50)	- Shadow, non HW register */
>
> Isn't it 0x4a after 0x49?

Oops. Yes. Sorry. I'll resend...

>
>
> Takashi

-- =

P=E9ter
