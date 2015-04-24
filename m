From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power amplifiers
Date: Fri, 24 Apr 2015 06:52:01 -0700
Message-ID: <CAJzqFtZ3wMHHoAesUZws0b4csArsjeZTKeB7FbU7OSSbmCT1nA@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org> <20150418113632.GE26185@sirena.org.uk>
 <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
 <CAJzqFtYZ8=k7ETGyXYoDTpjNdPQ7oRrMxO+kG++3diFif6Ox1g@mail.gmail.com> <20150424092839.GI22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150424092839.GI22845@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2015 at 2:28 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 23, 2015 at 05:47:49PM -0700, Kevin Cernekee wrote:
>
>> This is mostly working OK, but regcache_sync() assumes that the
>> hardware registers have been reset back to the default values.  The
>> "pdn" GPIO doesn't actually reset the state of the tas571x; it just
>> makes I2C inaccessible and inhibits audio output.  So if the factory
>> default for mute is 0, corner cases like this fail:
>
> ...
>
>> Aside from unnecessarily pulsing the reset GPIO when transitioning
>> back from SND_SOC_BIAS_OFF or overriding regcache_default_sync(), can
>> you think of a way to work around this?
>
> Do you need to work around it?  If the register map is being perserved
> you don't need to sync so just don't do it - it's just that the normal
> expectation would be that power down would cause the register map to be
> reset.

How do I tell regcache to write out any updates that happened while
the hardware was inaccessible?  I see that regmap->cache_dirty is 1,
but nothing flushes it automatically when exiting cache_only mode.
