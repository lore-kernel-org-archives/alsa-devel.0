From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: TWL4030 Line In/Out Loopback issue
Date: Mon, 8 Aug 2011 11:56:36 +0300
Message-ID: <12887655.ftkdM18k2N@barack>
References: <8CE237920E8878A-21B8-2B9F7@webmail-d033.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A124103815
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 10:56:38 +0200 (CEST)
In-Reply-To: <8CE237920E8878A-21B8-2B9F7@webmail-d033.sysops.aol.com>
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
Cc: Almohanad Fayez <alfayez@aol.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Monday 08 August 2011 02:27:45 Almohanad Fayez wrote:
>  I'verealized that there is a loopback dependency between the
> audioinput/output dependency with the 2.6.38 kernel running on a gumstix
> overo and also using the 2.6.35 kernel running on the Beaglenboard.

I can not recall seeing such an issue.

> You can replicate this issue by plugging some music into the Line injack =
and
> then fire up alsamixer.  Then you would need to modify theDAC2 Dig level,
> the one on the right no the left.  As you lower thevolume you'll hear your
> music input decreasing and as you increase itthe music level would
> increase.  If you lower it enough you can captureaudio from the input jack
> without hearing it out of your speaker butthe bad thing is that also
> controls your speaker output so if you tryto play some sound out of
> gumstix/beagleboard you won't be able to do because youneed to increase
> your DAC2 Dig level in alsamixer ... it's a catch22!!  I couldn't find any
> solutions readily.

Have you checked the state of the Left/Right Digital Loopback? Is it set to=
 0?

> I am running a console-only Angstrom image on both boards.  I've used the
> Beagleboard's line in/out capabilities with no issues using the 2.6.29
> kernel in the past so is there an update in the TWL4030 ALSA driver that I
> should take into account?  thanks

Could you post the content of the
/sys/devices/platform/soc-audio/wl4030-codec/dapm_widget
file to see what's going on?

-- =

P=E9ter
