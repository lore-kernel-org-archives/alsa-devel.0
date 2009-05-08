From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Fri, 8 May 2009 15:14:17 +0300
Message-ID: <200905081514.18044.peter.ujfalusi@nokia.com>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090508094044.0c85e86a.jhnikula@gmail.com>
	<200905081456.50445.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id B9F921038A9
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 14:14:23 +0200 (CEST)
In-Reply-To: <200905081456.50445.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "getarunks@gmail.com" <getarunks@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 08 May 2009 14:56:50 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> On Friday 08 May 2009 09:40:44 ext Jarkko Nikula wrote:
> > It really does fix the power-up & -down pops on Beagle. By listening
> > carefully I can hear slight power-up and -down pops but only if really
> > focusing on it.
> >
> > But now the audio output is distorted and volume level is a little bit
> > lower. Without the patch it plays fine. Is it possible that now the
> > output voltage is not correctly biased? Worth to check with a scope.
>
> Well, that's what you get, when you are testing audio with /dev/zero and
> /dev/urandom... I have not noticed that the random noise got more random =
;)
> What you have described is correct, it is heavily distorted.
>
> But I have debugged this further and I believe I know what is going on:
> The sequence for disable according to the documentation:
> HS_POP_SET:RAMP_EN =3D 0
> HS_POP_GAIN:HSL_GAIN, HSR_GAIN =3D 0
> HS_POP_SET:VMID_EN =3D 0
>
> Now what is missing from this is that after setting the HS_POP_SET:RAMP_EN
> =3D 0 it will take RAMP_DELAY time for the VMID to reach 0.
> Since we are not waiting between RAMP_EN =3D 0 and VMID_EN =3D 0, the VMI=
D has
> been cut, which causes the 'tuck' on the headset output.
>
> In case of the Beagle board the ramp delay can be configured(MCLK=3D26MHz=
):
> 20ms - 2581ms, by default it is 20ms.
> To verify this I have added mdelay(30) after the RAMP_EN =3D 0, and there
> were no 'tuck'. However when I increased the RAMP_DELAY (to 40ms, or
> longer) the 'tuck' reappeared.
>
> How to solve this?
> Realistically we can not add 2581ms delay to the headsetl_event function.=
..
> We could keep the VMID enabled all the time (which increases the idle pow=
er
> consumption by ~0.001A), but then the muting of the headset
> (HS_POP_GAIN:HSL_GAIN, HSR_GAIN =3D 0) will give the 'tuck'...
> In power consumption the difference between
> HS_POP_GAIN:HSL_GAIN, HSR_GAIN =3D=3D 0 and
> HS_POP_GAIN:HSL_GAIN, HSR_GAIN !=3D 0 is about ~0.01A, which is significa=
nt
> in my opinion.
> Using a timer to finish the ramp down?
>
> Anyways, this seams quite bad. I will think about it over the weekend...
>
> Any ideas?

We could fixate the RAMP_DELAY to 0 (27/20/14 ms, MCLK =3D 19.2/26/38.4 MHz=
) and =

add mdelay(28/21/15) in the headsetl_event function... But I'm not sure is =
it =

allowed, at least it looks hackish. Mark?

-- =

P=E9ter
