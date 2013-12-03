From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8731: fix dsp mode configuration
Date: Tue, 3 Dec 2013 15:57:14 +0000
Message-ID: <20131203155713.GB23979@opensource.wolfsonmicro.com>
References: <1386065094-26018-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386065094-26018-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 03, 2013 at 06:04:54PM +0800, Bo Shen wrote:
> According to WM8731 "PD, Rev 4.9 October 2012" datasheet, when it
> works in DSP mode A, LRP = 1, while works in DSP mode B, LRP = 0.
> So, fix LRP for DSP mode as the datesheet specification.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
