From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix data delay
	configuration
Date: Fri, 30 Jan 2015 13:52:17 +0100
Message-ID: <20150130125217.GA16659@amd>
References: <1422621751-30484-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 792AF260417
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 13:52:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1422621751-30484-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi!

> Fix the issue introduced by:
> 368494093354 ASoC: tlv320aic3x: Add TDM support
> 
> The CTRLC register were not receiving the correct delay configuration,
> which will corrupt DSP_A audio mode.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks for a fix!

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
