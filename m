From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: mediatek: Add AFE platform driver
Date: Fri, 12 Jun 2015 09:37:57 +0200
Message-ID: <1434094677.2271.125.camel@x220>
References: <1433946276-25969-1-git-send-email-koro.chen@mediatek.com>
	 <1433946276-25969-2-git-send-email-koro.chen@mediatek.com>
	 <1434006187.24094.40.camel@x220> <1434074158.10969.5.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434074158.10969.5.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel@vger.kernel.org, s.hauer@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, galak@codeaurora.org, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-06-12 at 09:55 +0800, Koro Chen wrote:
> On Thu, 2015-06-11 at 09:03 +0200, Paul Bolle wrote:
> > (What does negating a bool twice do?)
> > 
> Because bool actually can be unsigned char, although actually in this
> driver, the caller always passes "true" or "false" to this function.

bool is _Bool in the kernel (see include/linux/types.h). So whenever you
see a bool in the kernel you can assume it's either 0 or 1. Are there
any cases where this conveniently simple rule doesn't hold?

But here the discussion is moot, because as you say, the function will
only be passed false or true so we know "enable" is either 0 or 1 and
double negating will do nothing.

> Do you think if this is the case, should I still need to do !!?

So you should not, as it's confusing at best.

Thanks,


Paul Bolle
