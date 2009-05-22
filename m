From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Disabling HFL/R outputs in twl4030
Date: Fri, 22 May 2009 14:03:28 +0300
Message-ID: <200905221403.28771.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F6AC2661@dlee07.ent.ti.com>
	<200905221248.28656.peter.ujfalusi@nokia.com>
	<20090522103603.GA8542@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D0123103908
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 13:03:35 +0200 (CEST)
In-Reply-To: <20090522103603.GA8542@sirena.org.uk>
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
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 22 May 2009 13:36:04 ext Mark Brown wrote:
> On Fri, May 22, 2009 at 12:48:28PM +0300, Peter Ujfalusi wrote:
> > I guess ASoC does not have support for per codec_dai DAPM routing, or
> > let's put it differently: binding DAPM controls to specific codec_dai.
>
> It should do - the active stream names are matched against the stream
> name (second argument) for the DAC to decide if DACs are active.  This
> then feeds through to the rest of the output path.  The code for this is
> in snd_soc_dapm_stream_event().
>
> Looking at the twl4030 driver the names for the streams need some
> adjustment.  I'm vaugely surprised that the HiFi streams match as is but
> I think I'm just missing something there.

So changing the stream names in the twl4030_dai:
for HiFi:
.stream_name =3D "HiFi Playback" and leave the "Capture"
and for voice:
.stream_name =3D "Voice Playback" and leave the "Capture"

since there is no HiFi or Voice dedicated ADC...

Than changing the DAPM_DACs stream names for the HiFi stream:
"Right Front HiFi Playback", "Left Front HiFi Playback", "Right Rear HiFi =

Playback", "Left Rear HiFi Playback"

Should do the trick?

-- =

P=E9ter
