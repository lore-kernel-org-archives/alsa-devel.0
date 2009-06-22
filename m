From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice filters
	for voice sidetone
Date: Mon, 22 Jun 2009 09:25:40 +0300
Message-ID: <200906220925.40839.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
	<20090619095808.GD5270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F5D32455D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 08:25:57 +0200 (CEST)
In-Reply-To: <20090619095808.GD5270@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 19 June 2009 12:58:08 ext Mark Brown wrote:
> On Fri, Jun 19, 2009 at 03:23:41AM -0500, Lopez Cruz, Misael wrote:
> > Digital voice loopback (sidetone) requires voice filters
> > to be enabled: VTXL, VTXR, VRX.
>
> Is it possible to handle this by inserting DAPM widgets for these
> filters into the bypass paths and letting DAPM power them up? =


I think for the Voice interface this is feasible.

> I'm also wondering if with the new bias level management stuff which keeps
> the codec in BIAS_ON while any DAPM widgets are powered some of the bypass
> mode stuff can be removed or simplified?

I have been wondering about the same, but in the HiFi path it is not that =

simple. Most probably it is possible to add DAPM widget for the Audio Filte=
r =

L1/R1 (which is at the moment always enabled), but for the L2/R2 it is not =

that simple.
Simplifying the twl4030_mute function should be possible at this point, I =

think, by moving those output mutes as DAPM_PGA_E widgets on the paths. Thi=
s =

is in my to-do list... Although I have to check that such a change should n=
ot =

cause any 'clicks' on the outputs.

>
> I'm OK with the change if Peter acks it, I've not got detailed knowledge
> of the TWL4030.

I think this patch is not good. See my comment on the patch.

-- =

P=E9ter
