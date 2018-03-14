From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/47] ASoC: remove blackfin drivers
Date: Wed, 14 Mar 2018 17:26:26 +0100
Message-ID: <CAK8P3a3PMUEn7=g9kq+ncbd4kkswyDeg0bBiE9kNSSrcvDBg7w@mail.gmail.com>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-16-arnd@arndb.de>
 <20180314161212.GS2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314161212.GS2186@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 14, 2018 at 5:12 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Mar 14, 2018 at 04:35:28PM +0100, Arnd Bergmann wrote:
>
>> The blackfin architecture is getting removed, so the ASoC drivers
>> are all obsolete as well.
>
> This is going to cause loads of conflicts due to the ASoC platform to
> component refactoring - can you send me something that I can git am
> directly against my -next please, it seems better to apply it there so
> that nobody needs to see the conflicts?

Done.

      Arnd
