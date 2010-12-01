From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/5] ASoC: tpa6130a2: Make DAPM
	registration optional, and direct interface
Date: Wed, 1 Dec 2010 10:07:57 +0200
Message-ID: <201012011007.57750.peter.ujfalusi@nokia.com>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101130143013.GM7403@rakim.wolfsonmicro.main>
	<201012010854.20201.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 00AAC1038EB
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 09:08:01 +0100 (CET)
In-Reply-To: <201012010854.20201.peter.ujfalusi@nokia.com>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wednesday 01 December 2010 08:54:20 Ujfalusi Peter (Nokia-MS/Tampere) wr=
ote:
> On Tuesday 30 November 2010 16:30:13 ext Mark Brown wrote:
> > On Tue, Nov 30, 2010 at 04:00:04PM +0200, Peter Ujfalusi wrote:
> > > Users can choose to not add the DAPM routes provided by the
> > > amp driver, but use the direct enable/disable interface
> > > from machine driver with SND_SOC_DAPM_HP's event callback.
> > > In some cases this method must be used to make the audio
> > > path pop noise free.
> > =

> > Is there any situation where it would undesirable to do this?  If not
> > it'd seem better to just make the driver do this always.
> =

> You mean to not have DAPM widgets/routes in the tpa6130a2 driver, and only
> have a function, which can be used to turn on/off the amp?
> The original [1] (first version) of the tpa6130a2 driver only had DAPM_HP
> widget. It has been changed based on the comments.

I think the simplest thing would be to actually remove all DAPM widgets, =

routings from this driver, and provide only the funtion, which enable the a=
mp in =

stereo mode.
As it is now, we do not have user for this amp in upstream, so I'm not that =

worried about braking machine drivers ;)
The problem with tpa6130a2 provided DAPM_HP is that at least in one machine=
, I =

have to introduce delay before I enable the amp, otherwise I have really ba=
d pop =

at stream start. The codec in this case alone does not produce that bad pop=
, but =

it seams the sequence, and timing in the whole system makes the pop bad.
On other setups I have not encountered such a problem.

So:
I would remove all dapm related things from the tpa6130a2 driver, and offer=
 only =

the:
int tpa6130a2_stereo_enable(snd_soc_codec, *codec, int enable);
Function for users (machine drivers).

If there's a need I can re-introduce tpa6130a2 provided DAPM_HP widget to r=
educe =

duplicated code in machine drivers (when we have enough users for it).

What do you think?

-- =

P=E9ter
