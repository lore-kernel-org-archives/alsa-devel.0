From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_0/2=5D_ASoC=3A_TWL4030=3A_DA?=
 =?iso-8859-1?q?PM_restructuring=09and_Headset_pop-attenuation_fix?=
Date: Wed, 20 May 2009 12:12:52 +0300
Message-ID: <200905201212.52380.peter.ujfalusi@nokia.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03057419D3@dbde02.ent.ti.com>
	<20090520085121.GA11459@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id CA7F5103864
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 11:13:14 +0200 (CEST)
In-Reply-To: <20090520085121.GA11459@rakim.wolfsonmicro.main>
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
To: alsa-devel@alsa-project.org
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "sakoman@gmail.com" <sakoman@gmail.com>, "getarunks@gmail.com" <getarunks@gmail.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 20 May 2009 11:51:21 ext Mark Brown wrote:
>
> Applied - thanks for your hard work on this!
>
> BTW, I don't know if you noticed the DAPM changes I pushed the other
> day.  One commit in particular, 452c5eaa0d5162e02ffee742ea17540887bc2904,
> might be interesting for TWL4030 - it changes things so that we're in
> BIAS_ON whenever there's a bias path active, not only when there's a DAC
> or ADC path.  I've got a feeling some of the pop/click stuff may mean
> that's not as useful as it might've been in the past.

I will look at this change.
BTW: I just got the Beagle board, it will take some time to get familiar wi=
th =

it, but than I can really use the latest and greatest of ASoC...

> > [Aggarwal, Anuj] Since different platforms are using different ramp
> > values, how should it be handled via the same codec source code? How
> > should this be done, without modifying the code base? Or should it be
> > done every time user wants to play an audio file?
>
> Since it's just a change in one parameter the driver should be able to
> arrange to get that configuration value provided to it via platform
> data.  It's still the same chip and needs the same driver, all that's
> changing is configuration information.

As for now, storing the mixer settings and restoring those at boot time wou=
ld =

be the way.
I will look at the possibility to add platform data parameter to twl4030 co=
dec =

to set the board specific initial ramp delay value.

-- =

P=E9ter
