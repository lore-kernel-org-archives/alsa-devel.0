From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Problem adding support for digital mixer in codec
Date: Thu, 25 Mar 2010 09:17:59 +0200
Message-ID: <201003250917.59531.peter.ujfalusi@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A1A41038BA
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 08:18:18 +0100 (CET)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
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
Cc: "ext Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thursday 25 March 2010 04:33:54 ext Candelaria Villarreal, Jorge wrote:
> Hi,
> =

> I am trying to add support for a digital mixer. The digital mixer is
> connected like the following example:
> =

> =

> Path 1 -------\
> Path 2 --------\
>                    MIXER ------> DAC----> ...
> Path 3 --------/
> Path 4 -------/
> =

> =

> =

> However, I think ALSA does not support this configuration, as the DAC
> should be the first element in a route. I tried adding the DAC to the
> route first, and connected its output to the mixer inputs, like this:
> =

> 	  {"Mixer", "Multimedia Ext Switch", "HSDAC Left"},
>         {"Mixer", "Multimedia Ext Switch", "HSDAC Right"},
> =

>         {"Mixer", "Voice Switch", "HSDAC Left"},
>         {"Mixer", "Voice Switch", "HSDAC Right"},
> =

>         {"Mixer", "Multimedia Uplink Switch", "HSDAC Left"},
>         {"Mixer", "Multimedia Uplink Switch", "HSDAC Right"},
> =

>         {"Mixer", "Multimedia Switch", "HSDAC Left"},
>         {"Mixer", "Multimedia Switch", "HSDAC Right"},
> =

> But this does not seem to work. Can anyone give me some tips? Any comment
> would be appreciated.

Hmm, how these paths are connected, and where?
What I mean is I suppose you have one path, which is connected to the main =
CPU, =

than I suspect you have a connection to a modem (voice?), than you have =

possibility to connect some other components via digital link?

What I did with the TWL4030 codec, is that I have moved the actual DAC powe=
r =

control from the DAPM_DAC to different widget (the DAPM_DAC is kind of a fa=
ke =

one). This was needed to support the digital loopback functionality.

So if you reorder the DAPM widgets (making sure that the switch order still=
 OK), =

than I think you can treat one of the paths as normal playback path (fake =

DAPM_DAC -> mixer (have the DAC power bit handled here) -> ...).
Than you might consider of adding the rest of the paths as DAPM_INPUT, and =

connect them to the mixer (which after the fake DAC).
So you kind of have digital loopback from those to the analog domain.

> =

> Thanks,
> Jorge

-- =

P=E9ter
