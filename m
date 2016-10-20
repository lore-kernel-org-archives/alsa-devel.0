From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v4] clk: x86: Add Atom PMC platform clocks
Date: Thu, 20 Oct 2016 23:52:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610202349200.4938@nanos>
References: <1476735320-4315-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476735320-4315-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-clk@vger.kernel.org, x86@kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Ingo Molnar <mingo@redhat.com>, Michael Turquette <mturquette@baylibre.com>, "H. Peter Anvin" <hpa@zytor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, LKML <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Darren Hart <dvhart@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Oct 2016, Irina Tirdea wrote:
> The patch has already been reviewed by Stephen Boyd [1].
> The only remaining question is the one pointed out by Stephen:
> "Will there be problems if this merges through clk tree? If so we
> could take the clk driver part and the platform data include part
> could be duplicated into both trees. Or clk tree could be pulled
> into x86?" [1]

The proper thing to do is:

Move all that cruft including arch/x86/platform/atom/pmc_atom.c into
drivers/platform/x86. There is nothing architecture specific in these
files. It's pure peripheral driver enablement. So drivers/platform/x86 is
the proper location for this. Please discuss this with Darren Hart (cc'ed).

Thanks,

	tglx
