From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Mon, 5 Dec 2011 18:25:41 +0000
Message-ID: <20111205182540.GA7467@opensource.wolfsonmicro.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
 <20111202153401.GX8245@opensource.wolfsonmicro.com>
 <CANKRQngGHLD0Bam6sxCGPSkGutjkagbJMvGPTgkduXR6xmMw_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANKRQngGHLD0Bam6sxCGPSkGutjkagbJMvGPTgkduXR6xmMw_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2011 at 02:28:29PM +0900, Tomoya MORINAGA wrote:

> According to "machine.txt", I created this machine driver referring
> corgi.c/spitz.c.
> However, corgi.c/spitz.c. don't look obeying your saying.

You really need to look at current drivers to make sure you're following
current best practice - older drivers, particularly for obsolte hardware
like the Zaurus machines, may well not reflect the current best practices.
