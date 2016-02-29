From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/2] ASoC: omap: rx51: Fix enum ctl
 accesses in a wrong type
Date: Mon, 29 Feb 2016 21:56:44 +0200
Message-ID: <56D4A27C.308@bitmer.com>
References: <1456763182-2986-1-git-send-email-tiwai@suse.de>
 <1456763182-2986-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D85D2606E6
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 20:57:51 +0100 (CET)
In-Reply-To: <1456763182-2986-3-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/29/2016 06:26 PM, Takashi Iwai wrote:
> "Speaker Function", "Input Select" and "Jack Function" ctls in rx51
> driver are enum, while the current driver accesses wrongly via
> value.integer.value[].  They have to be via value.enumerated.item[]
> instead.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/omap/rx51.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
