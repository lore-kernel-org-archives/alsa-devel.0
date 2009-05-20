From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring
	and	Headset pop-attenuation fix
Date: Wed, 20 May 2009 09:51:21 +0100
Message-ID: <20090520085121.GA11459@rakim.wolfsonmicro.main>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090519103316.7b1ed16b.jhnikula@gmail.com>
	<20090519185806.GA3157@opensource.wolfsonmicro.com>
	<200905200856.32814.peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03057419D3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E0C49103894
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 10:51:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03057419D3@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 20, 2009 at 01:51:02PM +0530, Aggarwal, Anuj wrote:
> Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]:
> > On Tuesday 19 May 2009 21:58:06 ext Mark Brown wrote:

> > > It seems like the feedback has been pretty much OK so it should be OK
> > > apply the patches - Peter?
> > I also think, that it should be OK to apply this series.

Applied - thanks for your hard work on this!  

BTW, I don't know if you noticed the DAPM changes I pushed the other
day.  One commit in particular, 452c5eaa0d5162e02ffee742ea17540887bc2904, 
might be interesting for TWL4030 - it changes things so that we're in
BIAS_ON whenever there's a bias path active, not only when there's a DAC
or ADC path.  I've got a feeling some of the pop/click stuff may mean
that's not as useful as it might've been in the past.

> [Aggarwal, Anuj] Since different platforms are using different ramp
> values, how should it be handled via the same codec source code? How
> should this be done, without modifying the code base? Or should it be
> done every time user wants to play an audio file?

Since it's just a change in one parameter the driver should be able to
arrange to get that configuration value provided to it via platform
data.  It's still the same chip and needs the same driver, all that's
changing is configuration information.
