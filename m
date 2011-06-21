From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Max98095: Fix logging of hardware revision.
Date: Wed, 22 Jun 2011 00:28:46 +0100
Message-ID: <20110621232846.GB8791@opensource.wolfsonmicro.com>
References: <1308596072-17158-1-git-send-email-thutt@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308596072-17158-1-git-send-email-thutt@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taylor Hutt <thutt@chromium.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 11:54:32AM -0700, Taylor Hutt wrote:
> The base hardware revision of the Maxim 98095 part is 0x40; the code
> which outputs the revision of the hardware has been updated to
> properly use uppercase alphabetic values for the revision numbers.
> 
> Also, the use of a constant for the length 'max98095_dai' has been
> replaced with ARRAY_SIZE().

Applied.  Like I said in my previous mail please do try to split your
patches up better and make sure the changelogs are accurate.
