From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Analog
	bypass	implementation - try2
Date: Thu, 29 Jan 2009 18:25:58 +0000
Message-ID: <20090129182558.GA7032@sirena.org.uk>
References: <1233233870-22700-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090129135310.GE12179@sirena.org.uk>
	<200901291647.44780.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E9ED243C3
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 19:26:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901291647.44780.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 29, 2009 at 04:47:44PM +0200, Peter Ujfalusi wrote:

> You mean, that if one of the bypass is active, and the core wants to set the 
> codec to SND_SOC_BIAS_STANDBY, that the twl4030_set_bias_level should return 
> with false?

No.  The codec should always do exactly what it's told.  The core
shouldn't be bringing the codec down to STANDBY if there are any active
paths.
