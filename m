From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: TWL4030 driver support multi channel	playback
Date: Tue, 2 Jun 2009 10:37:07 +0100
Message-ID: <20090602093707.GB4046@sirena.org.uk>
References: <ef0d8a250906010720n144bb53bl4c6cc3e79e0f8db9@mail.gmail.com>
	<200906020816.41806.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2353C244FA
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 11:37:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906020816.41806.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Naveen Krishna Ch <naveenkrishna.ch@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2009 at 08:16:41AM +0300, Peter Ujfalusi wrote:

> Well, I think this is not going to be an easy ride. It is not that hard, but 
> takes some time. I could think of two approaches to get the twl4030 codec work 
> backported (plus one):
> 1. Backport the the whole ASoC changes to 2.6.28
> 2. Backport the twl4030 codec driver with minimal amount of ASoC changes
> 3. Convince whoever you need to convince that you need to move to 2.6.30 ;)
> 
> 1. Since ASoC has been dramatically changed since 2.6.28 this is not going to 
> be easy, but you will have the current ASoC features and it will be easier to 
> follow upstream.

I'd recommend just backporting ASoC in its entirety - it is relatively
well insulated against changes in the rest of the kernel other that any
arch code the machine drivers rely on so this process normally goes
fairly smoothly.  It's much easier than trying a partial backport.
