From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: Names for ALSA controls
Date: Fri, 13 Jun 2008 12:08:31 +0200
Message-ID: <200806131208.31381.jbe@pengutronix.de>
References: <200806121158.20112.jbe@pengutronix.de>
	<s5hmylr0wwc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id E245224486
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 12:08:36 +0200 (CEST)
In-Reply-To: <s5hmylr0wwc.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thursday 12 June 2008 12:29, Takashi Iwai wrote:
> At Thu, 12 Jun 2008 11:58:19 +0200,
> Juergen Beisert wrote:
> > Hi,
> >
> > when I register these mixer controls:
> >
> > Line Playback Switch
> > Line Playback Route
> > Mono Playback Switch
> > Mono Playback Route
> > Phone Playback Switch
> > Phone Playback Route
> > Headphone Playback Switch
> > Headphone Playback Route
> > PCM Playback Switch
> > PCM Playback Volume
> > Line Bypass Capture Switch
> > Line Bypass Capture Volume
> > ADC Capture Route
> >
> > Running "alsamixer" fails with:
> >
> >  ALSA lib simple_none.c:1218:(simple_add1) helem (MIXER,'Headphone
> > Playback Switch',0,0,0) appears twice or more
> >
> > It seems there are restrictions what kind of control name I can use for
> > each control, but what restrictions? Are there better names for my outp=
ut
> > amplifiers? Each of it I can enable/disable (-> Switch) and select a
> > source (-> Route) independently.
>
> You can use "xxx Source" instead of "xxx Route", I guess, as a
> workaround.

I changed my controls to a single enumerated type instead of a switch and =

route. Now with shown words like "Off", "Source1", "Source2" its easier to =

understand, what this control does. Thanks for your hint.

Juergen

-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
