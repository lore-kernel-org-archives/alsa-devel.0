From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 0/7] Kirkwood ASoC updates
Date: Thu, 26 Jun 2014 20:10:12 +0200
Message-ID: <20140626181012.GE18520@lunn.ch>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 26, 2014 at 03:22:31PM +0100, Russell King - ARM Linux wrote:
> Mark,
> 
> Here are a set of patches I've had for a while as part of my DPCM work.
> I think it's worth getting these merged.

Hi Russell, Mark

I tested simple playback of WAV and MP3 files on a Kirkwood based HP
T5325 machine. No obvious regressions.

Tested-by: Andrew Lunn <andrew@lunn.ch>

> Patch 7 adds NO_PERIOD_WAKEUP support for kirkwood, permitting
> interrupt-less operation.

When using mpg123 to play back mp3 files, i get about 9 interrupts per
second for kirkwood-i2s. Does this sound right?

       Andrew
