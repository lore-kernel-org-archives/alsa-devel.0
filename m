From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: Do DAPM control updates in the
	middle of DAPM sequences
Date: Thu, 16 Dec 2010 15:51:13 +0200
Message-ID: <201012161551.13096.peter.ujfalusi@nokia.com>
References: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292349202-25538-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id CD7B424449
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 14:51:11 +0100 (CET)
In-Reply-To: <1292349202-25538-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 December 2010 19:53:22 ext Mark Brown wrote:
> Attempt to minimise audible effects from mixer and mux updates by
> implementing the actual register changes between powering down widgets
> that have become unused and powering up widgets that are newly used.
> =

> This means that we're making the change with the minimum set of widgets
> powered, that the input path is connected when we're powering up widgets
> (so things like DC offset correction can run with their signal active)
> and that we bring things down to cold before switching away.  Since
> hardware tends to be designed for the power on/off case more than for
> dynamic reconfiguration this should minimise pops and clicks during
> reconfiguration while active.
> =

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =

> Peter, I think this will address your widget reordering issue - I'd
> appreciate it if you could test and let me know if it helps.  If this
> works it avoids the need for the the widget to know anything about the
> particular algorithm implemented by DAPM which seems more robust to me.
> =

> Sorry about how long it took to get this done.

Well, it is good, and bad.
It behaves mostly OK, but there's a strange side effect:
I noticed a pop on playback stream start on the twl4030 codec.
I'll look into it, but I do not see how this patch can affect the stream st=
art..
Could you hold this patch for some time, so I can look at this?

Thanks,
P=E9ter
