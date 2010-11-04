From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Thu, 4 Nov 2010 16:18:03 +0200
Message-ID: <201011041618.07655.peter.ujfalusi@nokia.com>
References: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101104134354.GA1201@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id CD013103854
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 15:18:10 +0100 (CET)
In-Reply-To: <20101104134354.GA1201@opensource.wolfsonmicro.com>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 04 November 2010 15:43:54 ext Mark Brown wrote:
> On Thu, Nov 04, 2010 at 10:16:45AM +0200, Peter Ujfalusi wrote:
> > The exisiting card->mutex can not be used for this purpose,
> > since it has been taken in probe time in the
> > snd_soc_instantiate_card function. Through probe calls from
> > this function eventually dapm_power_widgets will be called,
> > which will lead to dead lock.
> =

> Hrm.  You're right that the card mutex has issues here but just adding a
> lock here leaves us with a race - whenever we make a change to widget
> power we're doing a read/modify/write cycle and those aren't locked at
> all.  I'm not sure if we need a lower level lock to fix that, or a
> higher level lock which would make this one redundant but we ought to
> think about it and make sure we've picked the right way.

It is really hard to see what is actually happening, but based on my observ=
ation =

the root is this:
the widget's power_list going to be modified during the dapm_power_widgets =
call.
If the previous call to dapm_power_widgets did not finished, and it is goin=
g =

through the widget's power_list, another call to dapm_power_widgets might c=
ause =

the power_list to be changed. This leads to a crash.
It is possible that the list which existed in the first dapm_power_widgets =
call =

got distroyed by the second call while the first instance was going through =

that.
IMHO in most cases the new mutex is not going to add much delay, since it i=
s =

really rare case, when we can hit this bug.

I did not find lower level point where I can safely deal with this problem.

-- =

P=E9ter
