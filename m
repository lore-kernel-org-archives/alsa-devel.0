From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Add GPIO support for jack
	reporting	interface
Date: Tue, 3 Mar 2009 11:16:40 +0000
Message-ID: <20090303111640.GC27155@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECD6D7C1@dlee07.ent.ti.com>
	<s5h63irp0qb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D894245AA
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 12:16:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h63irp0qb.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 03, 2009 at 07:41:16AM +0100, Takashi Iwai wrote:

> I prefer GPIO stuff built in conditionally.
> The jack layer is used also for non-ASoC codes, and GPIO isn't always
> present.

This is the jack wrapper in sound/soc rather in the generic sound/core
version so it should be safe to have it in unconditionally (I'd be
surprised if an ASoC platform didn't have gpiolib support), though
there's no harm in making it conditional on gpiolib either.
