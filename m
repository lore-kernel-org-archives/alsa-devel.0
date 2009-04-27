From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 10:25:14 +0100
Message-ID: <20090427092514.GB1760@sirena.org.uk>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
	<9e4733910904261114u20e8376ci26a13a5210a4aa0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E258103803
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 11:25:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904261114u20e8376ci26a13a5210a4aa0b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 02:14:44PM -0400, Jon Smirl wrote:

> Yes, it wants continuous memory. I added SNDRV_PCM_HW_PARAM_PERIODS
> and things are working better.
> That was a better solution than breaking up operations into multiple
> DMA requests.

Does that patch need merging for 2.6.30 (you said I2S was broken)?
