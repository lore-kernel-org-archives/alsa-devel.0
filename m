From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
	auxiliary dailess codecs
Date: Fri, 26 Nov 2010 15:55:34 +0200
Message-ID: <201011261555.34396.peter.ujfalusi@nokia.com>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<20101126153548.a5a5f3c6.jhnikula@gmail.com>
	<20101126134151.GF30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 03591103D3C
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 14:56:00 +0100 (CET)
In-Reply-To: <20101126134151.GF30360@rakim.wolfsonmicro.main>
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

On Friday 26 November 2010 15:41:52 ext Mark Brown wrote:
> On Fri, Nov 26, 2010 at 03:35:48PM +0200, Jarkko Nikula wrote:
> > Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > > If DAPM core knows which widget belongs to which component, than I see
> > > no real problem with this method. The DAPM would work just fine. The
> > > PCM operatins would only apply to component with DAI.
> > =

> > Actually these are already well separated in current ASoC. Like my RFC
> > patch didn't not need touch soc-dapm.c at all and efectively other
> > changes were around codec probing/removal and by not registering the
> > PCM.
> =

> That's pretty much where I'm coming from - we already have most of the
> infrastructure, we just need to get the devices into the system but once
> we do that we should be able to cope with everything already.

So, if let's say I rewrite the tpa6130a2 driver as DAIless CODEC driver, an=
d =

connect to a system, where we already have a proper codec. What should I ex=
pect?
Can this work with 'reasonable' ;) amount of work (or non) on the core side?

-- =

P=E9ter
