From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: DMA over run on playback
Date: Wed, 13 May 2009 18:48:05 +0100
Message-ID: <20090513174804.GA27909@sirena.org.uk>
References: <9e4733910905130608u63a924cam25dca6af929ec82b@mail.gmail.com>
	<alpine.LNX.2.00.0905131510480.25064@eeebox2.perex-int.cz>
	<9e4733910905130638y4de40cc1vdd7b682fef867f95@mail.gmail.com>
	<s5hiqk5vvbz.wl%tiwai@suse.de>
	<9e4733910905131029u2dc43d50y178daccf66d59524@mail.gmail.com>
	<9e4733910905131037l1489e8efu372d030ee35fa8ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BAD781038D7
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 19:48:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905131037l1489e8efu372d030ee35fa8ab@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 01:37:03PM -0400, Jon Smirl wrote:

> You don't want this logic in an app, it needs to be in the kernel. You
> want the kernel to remember the longest observed latency. You don't
> want each app to have to rediscover this value.

Remember that the applications all talk to the kernel via the ALSA
libaray - it doesn't automatically follow that anything has to be done
in kernel.
