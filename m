From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC: SND_SOC_DAPM_LINE behavior
Date: Tue, 29 Sep 2009 15:59:46 +0300
Message-ID: <200909291559.46631.peter.ujfalusi@nokia.com>
References: <200909291536.39792.peter.ujfalusi@nokia.com>
	<20090929124439.GA8632@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C617010387C
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 14:59:52 +0200 (CEST)
In-Reply-To: <20090929124439.GA8632@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 29 September 2009 15:44:40 ext Mark Brown wrote:
> On Tue, Sep 29, 2009 at 03:36:39PM +0300, Peter Ujfalusi wrote:
> > The DAPM routing is something like this in the codec driver:
> > |DAC|------------->|              |
> > |
> >                    |Playback Mixer|->|OUTPUT|
> > |
> > |INPUT|->|Bypass|->|              |
> > |
> >          |SWITCH|
> >
> > Now if in the machine driver I create the following DAPM widget:
> > SND_SOC_DAPM_LINE("Line In", NULL),
> >
> > and than connect this DAPM_LINE to the codec's INPUT (LINE-IN):
> > {"LINE-IN", NULL, "Line In"},
> >
> > Than the codec bias level would be always in ON state, regardless of the
> > state of the Bypass Switch (it is off by default).
> =

> That shouldn't happen, turning off the bypass switch should break the
> path and let the bias sit at standby.  I'd need to check the code but I
> expect that the fact that LINE can be either an input or an output is
> confusing things and we need to split it into two widgets, one for input
> and one for output.

It seams that the LINE itself confusing DAPM, since if I connect a LINE to =
the =

OUTPUT that will also keep the codec bias ON all the time.

Most probably separating the LINE to LINEIN and LINEOUT in dapm would solve=
 the =

problem. This needs however change in the existing machine drivers as well,=
 but =

it should not be too big of a problem.

> The easiest thing for an actual system would just be to not bother with
> the external widget if you're not doing anything with it.  It'll only
> make things work better, there's no need for the external widgets unless
> you're switching them.

Yes, that is true.

Thanks,
P=E9ter
