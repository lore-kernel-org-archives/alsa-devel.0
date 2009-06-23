From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice filters
 for voice sidetone
Date: Tue, 23 Jun 2009 11:16:16 +0100
Message-ID: <20090623101615.GG5422@sirena.org.uk>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
	<200906220925.40839.peter.ujfalusi@nokia.com>
	<67059DBF19D7214F9C66BB0EA91BA90E3555FB3B@dlee04.ent.ti.com>
	<200906230838.20351.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A9E7D2463F
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 12:16:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906230838.20351.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 23, 2009 at 08:38:20AM +0300, Peter Ujfalusi wrote:

> Now if you start an audio playback (which will enable the ARXL1, even if we 
> are in Option2), than you stop it: the ARXL1 (which is VRX in Option2) bit 
> will be turned off... Now I'm not sure how this will be handled by the ASoC 
> core.
> What I mean is: One path enabled this bit, than another path also enables the 
> same bit, than it disables it. Will the first path notice it? Or will it think 
> that the bit is still enabled?

Sounds like a possible case for a supply widget, though the fact that
you've got both option 1 and option 2 is fun.  If the driver were a
proper platform driver you could select between option 1 and option 2 in
platform data (assuming that's sensible) and register different widgets
depending on which was in use.
