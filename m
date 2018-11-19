From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] ASoC: Intel: Skylake: fix Kconfigs,
 make HDaudio codec optional
Date: Mon, 19 Nov 2018 11:03:37 +0100
Message-ID: <CAK8P3a3acuA5jkW5MBLEZT=sNsN0opBjowRGNwK-bXZWZquOmA@mail.gmail.com>
References: <20181118223809.23314-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FBE7267837
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2018 11:03:55 +0100 (CET)
Received: by mail-qk1-f196.google.com with SMTP id r71so47543696qkr.10
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2018 02:03:55 -0800 (PST)
In-Reply-To: <20181118223809.23314-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 18, 2018 at 11:38 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> The Skylake driver currently has a set of problems supporting
> load/unload modules. We need to make the HDaudio codec support
> optional to help narrow down the issues.
>
> Support for HDaudio codecs also leads to a Kconfig issue. We want the
> hdac_hda codec to be compilable independently of Skylake (e.g. with
> ALL_CODECS) but when Skylake is selected as built-in the hdac_hda
> codec needs to use the same option due a a code dependency
>
> Solve both problems by adding a user-selectable boolean Kconfig,
> select HDAC_HDA as needed and make the HDaudio codec support in the
> Skylake driver optional. Tests on a Chell Chromebook device without
> HDaudio show no regression for speaker and HDMI playback.
>
> This is submitted as an RFC to allow for comments and more validation.
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This looks correct to me to solve the problem I reported.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
