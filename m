From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: twl4030 asoc kcontrols and widgets
Date: Thu, 20 Nov 2008 16:02:43 +0200
Message-ID: <200811201602.44035.peter.ujfalusi@nokia.com>
References: <ef0d8a250811200138y36fc840dn9978dd862214dec4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 3170324371
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 15:02:47 +0100 (CET)
In-Reply-To: <ef0d8a250811200138y36fc840dn9978dd862214dec4@mail.gmail.com>
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
Cc: ext naveen krishna ch <naveenkrishna.ch@gmail.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I have been also working on the twl4030 codec driver for some time now.
Altrough my patchset is not yet ready, but I'd like to be heard early
enough:
My plan is to add _all_ (ok, almost all) the features we can get with
TWLx030...
So instead of having 'only' one possible route from DACl2/DACR2, I have
implemented in a reverse order:
For all outputs (HSOL/R, PreDriveL/R, HFL/R IHFL/R, EAR) one can select
from where the audio is routed.
For example:
PreDriveL can output audio from Voice, DACL1, DACL2, DACR2
PreDriveR can output audio from Voice, DACR1, DACR2, DACL2
HSOL can output audio from Voice, DACL1, DACL2
HSOR can output audio from Voice, DACR1, DACR2
and the list goes on...
With this mode one can enable whatever combination of routing he/she
needs from TWL.

Since these channels are really 'independent' inside of TWL, making the
routing/mixing flexible (you might say extremely flexible) could make
sense.

CCing: Steve Sakoman who actually wrote the driver - could cc Mark Brown
as well, but it seams that he is reading alsa-devel quite frequently ;)

What do you think?

-- =

P=E9ter

On Thursday 20 November 2008 11:38:33 ext naveen krishna ch wrote:
> Hi Alsa devel,
> =

> I have been working on TWL4030 codec driver for ALSA SOC.
> I have taken sound/soc/codec/twl4030.c as reference from main line
> =

> This Patch adds some kcontrols, widgets and interconnection map for some =
of
> the TWL4030 ASOC codec
> I was building it for a custom board as it was for OVERO
> =

> =

> Suggestions on the DAPM part of the driver would be helpful
> =

> Thanks in advance.
> =

> The patch is as follows.
> I need suggestions on the DAPM part of the driver.
> =

> Thanks and Regards,
> =

> (: Naveen Krishna Ch :)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =
