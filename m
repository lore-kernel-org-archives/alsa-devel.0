From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] SOUND-OSS: Remove sh_dac_audio
Date: Wed, 22 Sep 2010 16:15:42 +0200
Message-ID: <201009221615.42710.arnd@arndb.de>
References: <1285156021-4973-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285156021-4973-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, ralf@linux-mips.org, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 22 September 2010, John Kacur wrote:
> Remove the SH DAC oss driver since there is an equivalent alsa driver.
> oss has been deprecated for years. Furthermore this driver has BKL code
> which we are trying to remove. Rather than attempt to fix this, simply
> remove the driver.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Takashi Iwai has already queued a patch from me to turn the BKL into a
driver specific mutex, the patch is now in linux-next.

There are still a few things that we may want to remove rather than
fix the BKL, but I don't think that's necessary here.

	Arnd
