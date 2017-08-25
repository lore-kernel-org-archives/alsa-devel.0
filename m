From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Fri, 25 Aug 2017 16:56:47 +0300
Message-ID: <1503669407.25945.102.camel@linux.intel.com>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503453106-5564-1-git-send-email-trini@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

+John

On Tue, 2017-08-22 at 21:51 -0400, Tom Rini wrote:
> Not all devices with ACPI and this combination of sound devices will
> have the required information provided via ACPI.  Reintroduce the I2C
> device ID to restore sound functionality on on the Chromebook 'Samus'
> model.

Tom, one more question.

Apparently you are the one who tested the commit
	89128534f925 ("ASoC: rt5677: Add ACPI support")
year ago.

The commit states that ACPI properties that are used in Chromebook Pixel
2015 is non-standard (not the same as for DT).

However, DSDT shows the opposite!

I would like to ask yuo and John what is the status of that currently?
Do we have any publicly available laptop with non-standard properties?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
