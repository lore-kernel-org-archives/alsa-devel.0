From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - try2] ASoC: Codec driver for Texas
	Instruments tlv320dac33 codec
Date: Thu, 15 Oct 2009 09:18:50 +0300
Message-ID: <200910150918.50869.peter.ujfalusi@nokia.com>
References: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910141556.50396.peter.ujfalusi@nokia.com>
	<20091014132402.GF20639@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id B49CA103823
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 08:18:58 +0200 (CEST)
In-Reply-To: <20091014132402.GF20639@rakim.wolfsonmicro.main>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 14 October 2009 16:24:02 ext Mark Brown wrote:
> > The interrupt is self cleaning on dac33 side (in the mode, which we are
> > using it, there is a mode, where additional write is needed to clear the
> > interrupt status).
> =

> That should be OK, someone can always add level triggering in future if
> they want to.
> =

> > Than on trigger STOP, I set the state to FLUSH and schedule the work, if
> > an interrupt comes, it is ignored, since the work has been scheduled.
> =

> Actually, you should just be able to queue the work since the state
> check will be done again in the workqueue and duplicate insertions don't
> hurt.  That'd also avoid the need to mask IRQs while fiddling with the
> state (which you're not doing at the minute but probably need to).

Yes... I have some plans for revisiting the nSample mode (or burst mode) =

handling, but first I want to make sure, that the current implementation is =

correct from ASoC point of view.
Since the code is in it's third iteration, I think it is getting better day=
-by-
day ;)

-- =

P=E9ter
