From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs42l52: HP gain enum and PCM
 Mixer dB scale fixes.
Date: Wed, 29 May 2013 13:07:07 -0500
Message-ID: <alpine.DEB.2.02.1305291306170.5194@heelrod.ad.cirrus.com>
References: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DD05264FE7
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 20:07:44 +0200 (CEST)
In-Reply-To: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org


On Wed, 29 May 2013, Nicolas Schichan wrote:

> Hi,
>
> The two patches in the serie contains the following fixes:
>
> - Use the correct shift value in hp_gain_enum, effectively allowing
>  the higher gain values to be effective and the correct gain value to
>  be reported to userland wrt what is written to the register.
>
> - Fix the PCM Mixer dB scale so that userland can report the correct
>  dB gain values. Note that in its current form, the PCM Mixer control
>  will only allow the range [-0.5 dB (0x7f), +12 dB (0x18)] to be
>  programmed to the hardware. I don't know if it is intentional or
>  not.
>
> Regards,
>
> Nicolas Schichan (2):
>  ASoC: cs42l52: use correct PCM mixer TLV dB scale to match datasheet.
>  ASoC: cs42l52: fix hp_gain_enum shift value.
>
> sound/soc/codecs/cs42l52.c |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> -- 
> 1.7.10.4
>
>
>
Acked-by: Brian Austin <brian.austin@cirrus.com>
