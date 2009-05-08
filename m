From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Fri, 8 May 2009 15:39:55 +0300
Message-ID: <200905081539.55217.peter.ujfalusi@nokia.com>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905081456.50445.peter.ujfalusi@nokia.com>
	<20090508123207.GA12895@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id BAC5C1038EF
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 14:39:58 +0200 (CEST)
In-Reply-To: <20090508123207.GA12895@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 08 May 2009 15:32:08 ext Mark Brown wrote:
> On Fri, May 08, 2009 at 02:56:50PM +0300, Peter Ujfalusi wrote:
> > Realistically we can not add 2581ms delay to the headsetl_event
> > function... We could keep the VMID enabled all the time (which increases
> > the idle power consumption by ~0.001A), but then the muting of the
> > headset
>
> Generally you want to leave VMID up all the time for exactly this reason
> - ramping it cleanly with that generation of hardware just takes too
> long to do it regularly during normal operation.
>
> > (HS_POP_GAIN:HSL_GAIN, HSR_GAIN =3D 0) will give the 'tuck'...
>
> Have you tried ramping the gain down gradually?  DAPM can do that for you
> automatically if the volume control is attached to the PGA.

I'll try that on Monday, but is it a problem that the =

HSL_GAIN and HSR_GAIN looks like this:
0 =3D=3D Off
1 =3D=3D 6 dB
2 =3D=3D 0 dB
3 =3D=3D -6 dB

-- =

P=E9ter
