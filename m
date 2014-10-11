From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 11/12] ASoC: txx9: use dmaengine_terminate_all() API
Date: Sat, 11 Oct 2014 18:21:47 +0200
Message-ID: <5439591B.4020701@metafoo.de>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com> <1413042040-28222-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413042040-28222-11-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/11/2014 05:40 PM, Vinod Koul wrote:
> The drivers should use dmaengine_terminate_all() API instead of
> accessing the device_control which will be deprecated soon

I already send a similar patch a while ago. It is on it's way into 3.18.

>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
