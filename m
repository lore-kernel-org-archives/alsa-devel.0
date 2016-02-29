From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/2] ASoC: omap: Fix enum ctl accesses
Date: Mon, 29 Feb 2016 22:16:32 +0200
Message-ID: <56D4A720.3070504@bitmer.com>
References: <1456763182-2986-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 390382606E6
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 21:16:42 +0100 (CET)
In-Reply-To: <1456763182-2986-1-git-send-email-tiwai@suse.de>
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
> Hi,
> 
> here is a patchset to correct the wrong type accesses in omap drivers
> for enum ctls.  I didn't put Cc to stable for them, supposing these
> are only for 32bit systems.  If not, feel free to put Cc to stable. 
> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (2):
>   ASoC: omap: n810: Fix enum ctl accesses in a wrong type
>   ASoC: omap: rx51: Fix enum ctl accesses in a wrong type
> 
>  sound/soc/omap/n810.c | 18 +++++++++---------
>  sound/soc/omap/rx51.c | 18 +++++++++---------
>  2 files changed, 18 insertions(+), 18 deletions(-)
> 
No need to Cc stable with these. Both are 32-bit LE ARMs and thus
incorrect use of long instead of unsigned int haven't caused problems
due only positive integers value used here.

-- 
Jarkko
