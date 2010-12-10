From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Power down digital
	parts, when not needed
Date: Fri, 10 Dec 2010 13:21:10 +0200
Message-ID: <201012101321.10329.peter.ujfalusi@nokia.com>
References: <1291976089-4839-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101210104449.GA3200@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 45D5724432
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 12:21:20 +0100 (CET)
In-Reply-To: <20101210104449.GA3200@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 10 December 2010 12:44:49 ext Mark Brown wrote:
> On Fri, Dec 10, 2010 at 12:14:49PM +0200, Peter Ujfalusi wrote:
> > If the following scenarion has been followed:
> > 1. Enable analog bypass
> > amixer sset 'Analog Left Bypass' on
> > amixer sset 'Analog Right Bypass' on
> =

> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> =

> It'd have been nice to have mentioned how the digital gets turned back
> on in the changelog!

Currently the codec is going to be reset at every stream start, since it ca=
n get =

confused, if I fail to do that, especially, when the FIFO is enabled.
In case, when the bypass was not enabled the codec anyway will hit BIAS_OFF=
, so =

next time, when we power it on, it is going through the power-up sequence.

I do have some plans to actually remove the need for this reset requirement=
 at =

every stream start (it adds considerable amount of latency, and other unwan=
ted =

side effects).

I can resend the patch with updated changelog.

-- =

P=E9ter
