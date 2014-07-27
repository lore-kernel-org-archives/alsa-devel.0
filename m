From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] ASoC: rsnd: Protect register accesses with a spinlock
 instead of a mutex
Date: Sun, 27 Jul 2014 11:36:47 +0100
Message-ID: <53D4D63F.6010701@codethink.co.uk>
References: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 23/07/14 22:19, Laurent Pinchart wrote:
> The hardware registers are accessed from atomic contexts (the
> rsnd_soc_dai_trigger function, for instance, is called with the PCM
> substream spinlock held). They thus can't be protected by a mutex.
> 
> Protect regmap register accesses with a spinlock instead of a mutex by
> setting the fast_io flag.

I reported this ages ago.

I ended up removing regmap entirely, it just locks the machine
solid and provides no useful functionality for the driver.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
