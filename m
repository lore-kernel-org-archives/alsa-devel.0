From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_1/2=5D_ASoC=3A_Set_up_debugf?=
 =?iso-8859-1?q?s_only_once=09per_CODEC?=
Date: Fri, 13 Aug 2010 13:49:46 +0300
Message-ID: <201008131349.46624.peter.ujfalusi@nokia.com>
References: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201008130742.45006.peter.ujfalusi@nokia.com>
	<20100813090249.GA32249@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id D442E2414F
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 12:49:47 +0200 (CEST)
In-Reply-To: <20100813090249.GA32249@sirena.org.uk>
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

On Friday 13 August 2010 12:02:49 ext Mark Brown wrote:
> Sure, but the big problem there is that these aren't really CODEC
> specific objects.

Sure, but those widgets are directly connected to the CODEC's widgets.
And even if we have more than one codec under a single card, the widgets fr=
om =

the machine driver are kind of attached to the codec's chain (plus the =

interconnect routes between the multiple codecs if any).

> > > Since most of this stuff is actually for the card we should refactor
> > > but this can come later.
> > =

> > Sure, refactoring will help, but with this change we have missing debug=
fs
> > files for widgets, which is kind of confusing.
> =

> Meh, it's a debug facility and I hope it'll be sorted out within a week
> or so anyway.

Well, than it does not matter that much (the missing debugfs widget entries=
), =

if you have plans for this.

> Besides, you're not really loosing much information since
> there tends to be no interesting routing outside the CODEC.

Yeah. True. I have seen machines where there were some widgets of interest =

coming from the machine driver, but it is really only causes problems =

(inconvenience) with the debugfs.

Just wanted to mention the short term effect of this patch.

-- =

P=E9ter
