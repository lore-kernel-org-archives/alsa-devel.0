From: Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH] ASoC: rt5677: use more of the volume range from DACs
Date: Fri, 4 Jan 2019 13:51:32 -0700
Message-ID: <20190104205132.GA106594@google.com>
References: <20181220232555.90030-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181220232555.90030-1-zwisler@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dylan Reid <dgreid@chromium.org>, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Hsinyu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 20, 2018 at 04:25:55PM -0700, Ross Zwisler wrote:
> From: Dylan Reid <dgreid@chromium.org>
> 
> The DACs volume can go over 0, both according to the data sheet and
> real world testing.  The control can go up to +30dB.
> 
> This was tested by playing audio at full volume on a samus chromebook.
> 
> Signed-off-by: Dylan Reid <dgreid@chromium.org>
> Reviewed-by: Hsinyu Chao <hychao@chromium.org>
> Signed-off-by: Ross Zwisler <zwisler@google.com>

Ping on this patch.
