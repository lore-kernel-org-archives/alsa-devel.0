From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 2/4] ASOC codec: add support for SSM2602 audio codec in ALSA SoC framework
Date: Thu, 28 Aug 2008 11:06:18 +0100
Message-ID: <20080828100615.GA11132@sirena.org.uk>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org> <1219829968-6431-3-git-send-email-cooloney@kernel.org> <20080827105456.GA10834@sirena.org.uk> <386072610808272255o7ef18860u29e10727e6e11a11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753528AbYH1KGh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <386072610808272255o7ef18860u29e10727e6e11a11@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: perex@perex.cz, lrg@kernel.org, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, khali@linux-fr.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 28, 2008 at 01:55:33PM +0800, Bryan Wu wrote:
> On Wed, Aug 27, 2008 at 6:54 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> > Current kernels have a Kconfig option SND_SOC_ALL_CODECS which should
> > have your codec added - this allows codec drivers to be built without
> > boards for test purposes.

> Is this option in alsa git tree or in the mainline? I fail to find it
> in upstream mainline.
> And do you mean I don't need to add SND_SOC_SSM2602 at all?

It's in ALSA git, queued for the 2.6.28 merge window.  See the
topic/asoc branch of:

        git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

for the current ASoC merge queue.  The other API changes will all be
queued there too.

There's quite a bit of churn in ASoC at the minute but additional API
changes will be taken care of by whoever does them once your driver is
merged so it should save you some work if you're able to get this in
soon.

> Yes, I will fix this issue by running checkpatch.pl. And for other API
> conflicts and I2C interface upgrading stuffs,
> I will leave them to Cliff.

OK.  Jean might be willing to do the I2C API conversion for you (I've
CCed him in).
