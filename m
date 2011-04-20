From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add EQ and filter to max98095 CODEC
 driver
Date: Wed, 20 Apr 2011 12:39:13 +0100
Message-ID: <1303299553.3436.5.camel@odin>
References: <1303262440-19412-1-git-send-email-peter.hsiang@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303262440-19412-1-git-send-email-peter.hsiang@maxim-ic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hsiang <cdefgab1288@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Hsiang <peter.hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jesse Marroquin <jesse.marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-04-19 at 18:20 -0700, Peter Hsiang wrote:
> This patch adds the equalizer and biquad filter controls.
> 
> Signed-off-by: Peter Hsiang <peter.hsiang@maxim-ic.com>
> ---
>  include/sound/max98095.h    |   28 +++
>  sound/soc/codecs/max98095.c |  391 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/max98095.h |   15 ++
>  3 files changed, 434 insertions(+), 0 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
