From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] ASoC: TLV320AIC23B Support more sample
	rates
Date: Thu, 6 Nov 2008 10:49:06 +0000
Message-ID: <20081106104905.GA26469@sirena.org.uk>
References: <20081105185220.GA10816@rakim.wolfsonmicro.main>
	<1225911211-22474-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hiqr1hpxm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 88E4A244DE
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2008 11:49:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiqr1hpxm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 05, 2008 at 09:35:01PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > +		return score;

> > +	return 0xffffffff;

> -1 would be simpler and safer (for possible missing f's).

I'm not sure that'd add to the clarity - the goal isn't to have all bits
set, the goal is to have a much larger score than could ever otherwise
be achieved so putting in a very large constant expresses that much more
directly.
