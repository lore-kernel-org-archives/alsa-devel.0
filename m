From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.37
Date: Mon, 27 Sep 2010 09:58:53 +0100
Message-ID: <1285577933.4658.6.camel@dplaptop>
References: <20100927002429.GB10992@opensource.wolfsonmicro.com>
	<s5htylbiu70.wl%tiwai@suse.de> <1285575674.4658.5.camel@dplaptop>
	<s5hhbhbio60.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7DA7210380A
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 10:58:56 +0200 (CEST)
In-Reply-To: <s5hhbhbio60.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-09-27 at 10:30 +0200, Takashi Iwai wrote:
> Yeah, I do understand the initial intention, but size_t for such a
> case (just for an index of a small fixed size array) is obviously too
> much.  If it must be size_t, it shouldn't be a variable name like "i"
> but a more specific name.

I see your point. Makes sense.

Cheers,
Dimitrios
