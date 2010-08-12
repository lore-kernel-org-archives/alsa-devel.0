From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Thu, 12 Aug 2010 16:01:45 +0100
Message-ID: <20100812150145.GC11362@sirena.org.uk>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
	<20100812125625.GA27749@pengutronix.de>
	<AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C8E62446E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 17:01:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 12, 2010 at 10:59:19PM +0800, Randolph Chung wrote:

> I will double check tomorrow, but I have another version of the code
> that checks all the return values and I am quite sure the set_channels
> didn't fail....

Actually, if the interval between the time periods doubles in the
failure case that suggests that the hardware may have decided to start
running in mono mode...
