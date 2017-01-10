From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: tm2_wm5110: include gpio/consumer.h
Date: Tue, 10 Jan 2017 17:48:06 +0100
Message-ID: <CAK8P3a2MNkqWFePUh0_yM1xhNZgdmzKJnpHWM90EME5z_mjX5Q@mail.gmail.com>
References: <20170110153104.3143248-1-arnd@arndb.de> <20170110164042.d6yb3j6ucdito7mq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110164042.d6yb3j6ucdito7mq@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Inha Song <ideal.song@samsung.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 10, 2017 at 5:40 PM, Mark Brown <broonie@kernel.org> wrote:
> This doesn't apply against current code, it looks like someone already
> made the same change.Ok, I was sending out m

y final set of patches that I found build-testing v4.10-rc, which
still needs the change,
and have moved on to linux-next testing now.

In case you have queued up that change for v4.11 but not also v4.10,
maybe move it into the fixes branch.

    Arnd
