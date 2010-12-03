From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 2/2] ASoC: tlv320dac33: Request for reordered
	update power sequence
Date: Fri, 3 Dec 2010 11:36:27 +0200
Message-ID: <201012031136.27104.peter.ujfalusi@nokia.com>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
	<201012021452.04720.peter.ujfalusi@nokia.com>
	<20101202131505.GE859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 01511243C1
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 10:36:33 +0100 (CET)
In-Reply-To: <20101202131505.GE859@rakim.wolfsonmicro.main>
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

On Thursday 02 December 2010 15:15:06 ext Mark Brown wrote:
> On Thu, Dec 02, 2010 at 02:52:04PM +0200, Peter Ujfalusi wrote:
> > Back to the naming.. What about reorder_dapm_update_power, and move the
> > flag to the snd_soc_dapm_widget struct?
> =

> If we're going down this route I'd rather have a name that reflected the
> new ordering rather than the fact that there's an ordering change.  Not
> that any ideas occur to me right now.

How about:
route_change_before_powerup

A bit long, but this describes well the meaning.

I think it is kind of silly to have a function, which just sets this flag, =
and I =

think having yet another DAPM widgets for this type is again a bad idea.
Do we have helper function, which can find a widget by name, and return the =

pointer to the snd_soc_dapm_widget?
I think if we have that, drivers can use that to get the widget they want t=
o =

change the power up order, and set this flag.
If we ever need other new flags for widgets, this can be used for that purp=
ose.
We could have an inline function, which uses the dapm_find_widget(), and se=
ts =

the flag, to minimize duplicated code all over the place.

So I can move the flag per widget, and we are going to have pretty interfac=
e =

too.

What do you think?

-- =

P=E9ter
