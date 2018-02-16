From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2] ASoC: dmic: Add optional wakeup delay
Date: Fri, 16 Feb 2018 09:09:05 -0800
Message-ID: <20180216170905.GD99727@google.com>
References: <20180216022416.208265-1-mka@chromium.org>
 <20180216112801.GA5886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180216112801.GA5886@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Dylan Reid <dgreid@chromium.org>, huang lin <hl@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

El Fri, Feb 16, 2018 at 11:28:01AM +0000 Mark Brown ha dit:

> On Thu, Feb 15, 2018 at 06:24:16PM -0800, Matthias Kaehlcke wrote:
> > On some systems a delay is needed after switching on the clocks, to allow
> > the output to stabilize and avoid a popping noise at the beginning of
> > the recording. Add the optional device tree property 'wakeup-delay-ms'
> 
> This doesn't apply against current code, please check and resend.

Sorry about that, apparently 6d6c3946d877 ("ASoC: dmic: replace codec
to component") was merged just after syncing my tree. Will rebase and
resend.
