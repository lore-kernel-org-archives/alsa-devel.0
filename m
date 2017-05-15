From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: codec: wm9860: avoid maybe-uninitialized warning
Date: Mon, 15 May 2017 16:03:37 +0200
Message-ID: <CAK8P3a0-1e7EnjP508MMyVNRj6kb2hL+06GUu=rUueARPYRr0g@mail.gmail.com>
References: <20170419170449.2965453-1-arnd@arndb.de> <20170514100524.7rxtz7v3omjwonzv@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170514100524.7rxtz7v3omjwonzv@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Baluta <daniel.baluta@nxp.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 14, 2017 at 12:05 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 19, 2017 at 07:04:20PM +0200, Arnd Bergmann wrote:
>> The new PLL configuration code triggers a harmless warning:
>
> This doens't apply against current code, please check and resend.

I can confirm that you have already merged Daniel's updated version,
and that this addresses the problem.

       Arnd
