From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY?on
	headsetl_event: POST_PMD
Date: Fri, 15 May 2009 09:30:08 +0300
Message-ID: <200905150930.08224.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905141544.47934.peter.ujfalusi@nokia.com>
	<20090514125333.GA9471@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 27CD324460
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 08:30:14 +0200 (CEST)
In-Reply-To: <20090514125333.GA9471@rakim.wolfsonmicro.main>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 14 May 2009 15:53:34 ext Mark Brown wrote:
> On Thu, May 14, 2009 at 03:44:47PM +0300, Peter Ujfalusi wrote:
> > On Thursday 14 May 2009 12:56:21 ext Mark Brown wrote:
> > > The event could check the current setup and do whatever's appropriate?
> >
> > I have to think about this, but at first sight it does look awfully
> > complicated thing to do (4 PGA, 7 output with mixers, 2+1 output mux)...
>
> It might help to have the mixers and muxes maintain some state when they
> change?  It's just a suggestion, I'm not familiar enough with the codec
> to know if it's a sensible one for this device or if it's more trouble
> than it's worth.

I have given this one a though and it might be not that problematic. What I=
'm =

afraid is that there are some corner cases, which might need some special =

attention.

>
> > I think I don't want to fixate the ramp delay to any value (meaning that
> > the delay would last around 50ms). This seams to be also board specific,
> > so I would rather leave this to the user to find the best value for the
> > given board.
>
> Ah, right.  Possibly worth making it platform data, I suppose, but
> that'd be a pain when experimenting to find the values.

In the future I can add platform data for the initial ramp delay value, whi=
ch =

can be passed from the board file, but still the user will be able to chang=
e =

that if he/she wanted to.

-- =

P=E9ter
