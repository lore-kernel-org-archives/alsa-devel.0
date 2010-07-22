From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 13:57:16 +0300
Message-ID: <201007221357.16840.peter.ujfalusi@nokia.com>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EC18103992
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 12:57:23 +0200 (CEST)
In-Reply-To: <20100722094832.GC4737@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, ext Takashi Iwai <tiwai@suse.de>
Cc: "Aaltonen Matti.J (Nokia-MS/Tampere)" <matti.j.aaltonen@nokia.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thursday 22 July 2010 12:48:32 ext Mark Brown wrote:
> > I principle I of course agree. But it seems - also discussed with the
> > local ALSA specialist - that using static constraints does not work
> > here. HALF_DUPLEX is not one of the SNDRV_PCM_HW_PARAM_'s... or
> > something like that. As a ALSA non-specialist I'd be willing to this
> > leave as it is...
> =

> Could you please get whoever the expert is to get involved in this
> thread?  If this is not currently possible it should probably be.

I think the whole SNDRV_PCM_INFO_HALF_DUPLEX bit cleaning/setting can be le=
ft =

out as such.
My point is, that in wl1273_startup, the driver anyway will refuse the non =

correct stream for FM mode. It is checking, that only playback can be start=
ed, =

when the FM is in TX mode, and allows only capture, if the chip has been =

configured to FM RX mode. In BT mode the codec can work in full duplex.

And to the issue:
I'm not really sure about it, but at least I have not seen the constraint A=
PI =

used for anything, but for hw_params (access mode, formats, sizes, times)...
As I looked at the ALSA core, I don't really noticed, that we can use the =

constraint API for this.

So let's ask Takashi:
Is it possible to use the constraint API for placing HALF_DUPLEX on a strea=
m =

(modifying bits in the info_flags)?

-- =

P=E9ter
