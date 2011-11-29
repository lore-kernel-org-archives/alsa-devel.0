From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] sound/soc/codecs: add LAPIS Semiconductor ML26124
Date: Tue, 29 Nov 2011 12:50:29 +0000
Message-ID: <20111129125029.GN2851@opensource.wolfsonmicro.com>
References: <1322569736-16782-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322569736-16782-1-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 29, 2011 at 09:28:56PM +0900, Tomoya MORINAGA wrote:
> ML26124-01HB/ML26124-02GD is 16bit monaural audio CODEC which has high
> resistance to voltage noise. On chip regulator realizes power supply rejection
> ratio be over 90dB so more than 50dB is improved than ever. ML26124-01HB/

Given the questions you just asked myself and Lars-Peter it seems fairly
clear that the review comments from the previous version so I'm not
going to review this, please resend once the review comments have been
addressed.  Lars-Peter concern seemed especially serious, I'd expect
large sections of the audio functionality to not work without being
connected to the DAPM map.

In general if resubmitting code that has outstanding review issues you
should highlight the known issues and explain why you are resending;
usually if there's an active discussion in progress it's better to wait
for that to die down.
