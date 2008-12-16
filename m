From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: help needed for capture DAPM (twl4030)
Date: Tue, 16 Dec 2008 09:43:33 +0000
Message-ID: <20081216094332.GA24405@sirena.org.uk>
References: <200812161117.49928.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E94B2459F
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 10:43:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812161117.49928.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 16, 2008 at 11:17:49AM +0200, Peter Ujfalusi wrote:

> I'm thinking of creating a new type for soc based on the soc_enum. This new 
> type would store the valid enum texts and the corresponding value in the 
> register (with mask). This could be used in very flexible way. It can be also 
> be used instead of the normal enum types (altrough it does not make sense).
> But this can wait for now.

That's possibly worthwhile.

> I have been thinking to create four 'ghost ADC' for the four channel. Than 
> when building the route the real ADCs can receive switches to handle the 
> power management. 

That should work, or creating virtual ADCs for the digimic paths might
do the job too (not a million miles from what's going on, either).
