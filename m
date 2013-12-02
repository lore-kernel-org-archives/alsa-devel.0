From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Add monaural audio support for
 non-ac97 interface
Date: Mon, 2 Dec 2013 23:21:31 +0800
Message-ID: <20131202152130.GB8609@MrMyself>
References: <1384532729-6588-1-git-send-email-b42378@freescale.com>
 <20131202115617.GV27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131202115617.GV27568@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: timur@tabi.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 02, 2013 at 11:56:17AM +0000, Mark Brown wrote:
> On Sat, Nov 16, 2013 at 12:25:29AM +0800, Nicolin Chen wrote:
> > The normal mode of SSI allows it to send/receive data to/from the first
> > slot of each period. So we can use this normal mode to trick I2S signal
> > by puting/getting data to/from the first slot only (the left channel)
> > so as to support monaural audio playback and recording.
> 
> This looks OK but doesn't apply against current code, can you please
> check and resend?

Ah, I rebased it on the dual-fifo set. Sorry I didn't make it clean.
I will resend it. Thank you.
