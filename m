From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 17:29:47 +0000
Message-ID: <20081126172946.GG6234@sirena.org.uk>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com> <20081126110854.GA6234@sirena.org.uk> <5e088bd90811260924u28a081bej62689470551b6982@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e088bd90811260924u28a081bej62689470551b6982@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 26, 2008 at 09:24:03AM -0800, Steve Sakoman wrote:

> I'm all for factoring out common code, but I think that this approach
> will become a maintenance nightmare over time.

I had formed the impression that an awful lot of the boards had very
similar audio subsystems and that even with DAPM support it'd be fairly
straightforward to do standard drivers for certain classes of system.
If that's not the case then doing this sort of shared machine driver
probably isn't worth it at all.
