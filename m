From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 3/5] arch/x86/platform/atom: Move pmc_atom to
 drivers/platform/x86
Date: Wed, 18 Jan 2017 10:28:09 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1701181027490.3464@nanos>
References: <1484690270-28425-1-git-send-email-pierre-louis.bossart@linux.intel.com> <1484690270-28425-4-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484690270-28425-4-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Jan 2017, Pierre-Louis Bossart wrote:

> From: Irina Tirdea <irina.tirdea@intel.com>
> 
> The pmc_atom driver does not contain any architecture specific
> code. It only enables the SoC Power Management Controller driver
> for BayTrail and CherryTrail platforms.
> 
> Move the pmc_atom driver from arch/x86/platform/atom to
> drivers/platform/x86. Also clean-up and reorder include files by
> alphabetical order in pmc_atom.h
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
