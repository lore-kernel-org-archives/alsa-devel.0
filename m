From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Modify codec default
	settings
Date: Thu, 28 Jan 2010 16:25:29 +0200
Message-ID: <201001281625.29439.peter.ujfalusi@nokia.com>
References: <1264687024-7241-1-git-send-email-peter.ujfalusi@nokia.com>
	<1264688045.3044.176.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id ED6D710385F
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 15:25:32 +0100 (CET)
In-Reply-To: <1264688045.3044.176.camel@odin>
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
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Liam,

On Thursday 28 January 2010 16:14:05 ext Liam Girdwood wrote:
> On Thu, 2010-01-28 at 15:57 +0200, Peter Ujfalusi wrote:
> > Change the legacy default register configuration, which left some
> > internal components on.
> > Now we have either DAPM, or other ways to control these bits,
> > so there is no need to enable them by default.
> >
> > The affected parts:
> > Disable ADCL and ADCR
> > Disable ARXL2 and ARXR2 analog PGA (playback)
> > Disable APLL by default
> =

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
> =

> Btw, should we be expecting more of these or does the twl4030 have full
> DAPM coverage now ?

Well, there are couple of small things that I'm not that satisfied with the =

current implementation:
Some outputs are enabled by default (Headset namely),
Few other defaults, which might not need to be enabled,
In OPTION register the RX2 and TX1 path enable bits are not handled by DAPM,
and there were something else also, which I can not recall...
All in all I think the twl4030 codec driver is now in a really good shape, =
but =

still needs some fine tuning to be close to perfect ;)

So yes, there will be more patches coming, but I'm not sure about the time =
line =

for those.

> Thanks
> =

> Liam
> =


-- =

P=E9ter
