From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] SOUND-OSS: Remove sh_dac_audio
Date: Wed, 22 Sep 2010 16:17:00 +0200
Message-ID: <201009221617.00195.arnd@arndb.de>
References: <1285156021-4973-1-git-send-email-jkacur@redhat.com> <20100922124747.GD9546@linux-sh.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100922124747.GD9546@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: John Kacur <jkacur@redhat.com>, lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, ralf@linux-mips.org, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 22 September 2010, Paul Mundt wrote:
> On Wed, Sep 22, 2010 at 01:47:01PM +0200, John Kacur wrote:
> > Remove the SH DAC oss driver since there is an equivalent alsa driver.
> > oss has been deprecated for years. Furthermore this driver has BKL code
> > which we are trying to remove. Rather than attempt to fix this, simply
> > remove the driver.
> > 
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Since I thought I had already removed this ages ago but appear to have
> been imagining things:
> 
> Acked-by: Paul Mundt <lethal@linux-sh.org>

Oh well, nevermind my comment about keeping it then.

	Arnd
