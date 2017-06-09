From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 7/7] ASoC: samsung: Constify hw_constraints
Date: Fri, 9 Jun 2017 09:09:45 +0200
Message-ID: <20170609070945.GA4018@kozik-book>
References: <20170608213725.5378-1-tiwai@suse.de>
 <20170608213725.5378-8-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 45A9B266CB8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 09:09:48 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id 7so150644450wmo.1
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 00:09:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170608213725.5378-8-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 08, 2017 at 11:37:25PM +0200, Takashi Iwai wrote:
> snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
> const pointers.  Constify the corresponding static objects for better
> hardening.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/samsung/s3c24xx_uda134x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
