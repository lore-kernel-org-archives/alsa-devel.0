From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 0/2] ASoC: core: Option to reorder widget
	power sequence
Date: Fri, 3 Dec 2010 09:33:28 +0200
Message-ID: <201012030933.28559.peter.ujfalusi@nokia.com>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101202130516.GC859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 33BAB103B02
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 08:33:35 +0100 (CET)
In-Reply-To: <20101202130516.GC859@rakim.wolfsonmicro.main>
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

On Thursday 02 December 2010 15:05:16 ext Mark Brown wrote:
> On Thu, Dec 02, 2010 at 02:03:08PM +0200, Peter Ujfalusi wrote:
> > The first patch implements a new flag for the core to reorder the
> > sequence to: 1. User enable the bypass
> > 2. The bit enabling the bypass got changed.
> > 3. DAPM power up sequence takes place
> > 3.1 codec DAPM widgets got powered on, codec is enabled
> > 3.2 External speaker enabled
> =

> Is this OK on power down? On power down we'll adjust the input path to
> the widget then power down the output path so noise introduced by
> switching away from the current source will get amplified.  Keeping the
> current sequence for power down seems more consistent with what you're
> trying to do.

The power down sequence is kept as it was, only the power up sequence has b=
een =

changed:
1. User disable the bypass
2. DAPM power down sequence takes place
2.1 External speaker disabled
2.1 codec DAPM widgets got powered down, codec is powered down
3. The bit for the bypass got changed.

> =

> Looking at the mailing list archive the issues previously were partly
> things being obscured by this being in terms of the then very

Yes, I know that the old patch changed it for up, and down. I did learnet m=
y =

lesson, so I only changed the power up sequence.

> non-standard TWL4030 code and also this:
> | I think there's something useful we can do with DAPM here (independantly
> | of anything in TWL4030), probably involving splitting up the routing
> | change walk to run power down first and then power up but the current
> | patch feels like it's going to cause at least as many problems as it
> | solves.
> =

> We've now got the split power down/power up sequences - ideally what
> we'd be able to do here is get the route update to happen in between the
> power down and power up sequences.

What do you mean?
IMHO using differnet sequence of register write/dapm update power on path e=
nable =

and disable shall be enough.

Also: this patch only solving the pop noise in my case, when the codec is =

powered on, because the bypass got enabled/disabled.
If the bypass is enabled during active audio (aplay /dev/zero), than the po=
p =

from the bypass switch is there, but honestly I can not do anything about i=
t. It =

is a hardware bug, and user space has to deal with it in some way.

-- =

P=E9ter
