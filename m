From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ASoC: rt5651: use msleep for large delays
Date: Wed, 11 Jan 2017 03:55:49 -0800
Message-ID: <1484135749.12006.23.camel@perches.com>
References: <1484135376-482-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484135376-482-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>, Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2017-01-11 at 12:49 +0100, Nicholas Mc Guire wrote:
> ulseep_range() uses hrtimers and provides no advantage over msleep()
> for larger delays. Fix up the 75/85ms delays here to use msleep() and
> reduce the load on the hrtimer subsystem.

If this is useful, why not convert all the large value
usleep_range uses in sound/soc/ ?
