From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] ASoC: twl4030 - Add VDL path support
Date: Wed, 25 Mar 2009 11:20:13 +0000
Message-ID: <20090325112013.GD20936@sirena.org.uk>
References: <49C8D933.5020303@samsung.com>
	<200903250821.25185.peter.ujfalusi@nokia.com>
	<49CA116D.4090004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 98181103853
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 12:20:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49CA116D.4090004@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: '?????????' <kyungmin.park@samsung.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ????????? <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 25, 2009 at 08:11:41PM +0900, Joonyoung Shim wrote:

> What does mean the digital bypass? I could find only the volume control of
> ATX2ARXR_PGA. I think also the digital bypass seems just "Digital loop".

Not specifically related to the TWL4030 (I've never particularly looked
at that device) but many devices have the ability to do paths where the
audio flows from an analogue input to an analogue output via an ADC and
a DAC, possibly with some sort of signal processing going on in the
digital domain.
