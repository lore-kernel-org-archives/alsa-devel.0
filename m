From: Fabio Estevam <festevam@gmail.com>
Subject: Re: proc_dir_entry 'asound/pcm' already registered
Date: Thu, 24 Aug 2017 17:43:38 -0300
Message-ID: <CAOMZO5CNFdLRO7azsyL=nY0uabJG6P_4q-=3h6N4+6uvPkuPuw@mail.gmail.com>
References: <CAOMZO5CMogVduV2K4QMKOiEjJ2u+zQaDymt9aYhHQ+ZMih7TKQ@mail.gmail.com>
 <s5hmv6ou303.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 305C9267825
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 22:43:40 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id y193so545503oie.5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 13:43:40 -0700 (PDT)
In-Reply-To: <s5hmv6ou303.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Markus Elfring <elfring@users.sourceforge.net>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Thu, Aug 24, 2017 at 5:25 PM, Takashi Iwai <tiwai@suse.de> wrote:

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: pcm: Correct broken procfs set up
>
> The commit c8da9be4a75f ("ALSA: pcm: Adjust nine function calls
> together with a variable assignment") contained a badly incorrect
> conversion, a "status" PCM procfs creation was replaced with the next
> one.  Luckily, this could be spotted easily by the kernel runtime
> warning.
>
> Fixes: c8da9be4a75f ("ALSA: pcm: Adjust nine function calls together...")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks for the fix:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
