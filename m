From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [GIT PULL] ASoC updates for v3.18
Date: Tue, 7 Oct 2014 14:53:12 -0300
Message-ID: <CAOMZO5D5uj8FrKUNxE4+VZSBcR4VCaYnZvR64XwdfxjEzXF6nQ@mail.gmail.com>
References: <20141006115105.GL4609@sirena.org.uk>
 <s5htx3hxtjy.wl-tiwai@suse.de>
 <20141007171436.GA23707@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A3E1260446
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 19:53:15 +0200 (CEST)
Received: by mail-lb0-f173.google.com with SMTP id 10so6634221lbg.32
 for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2014 10:53:12 -0700 (PDT)
In-Reply-To: <20141007171436.GA23707@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Sachin Kamat <sachin.kamat@samsung.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark/Takashi,

On Tue, Oct 7, 2014 at 2:14 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 06, 2014 at 02:37:53PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
>
>> However, this resulted in a few new build warnings, and some of them
>> look correctly reported.
>
>> *  sound/soc/codecs/mc13783.c:787:13: warning: 'np' may be used uninitialized in this function [-Wuninitialized]
>
>> The call of_node_put(np) is done unconditionally even for non-NULL
>> pdata where np isn't initialized.  This may lead to a real crash.

Calling of_node_put() with NULL as an argument does not cause crashes.
Please check:
http://patchwork.ozlabs.org/patch/377930/

Regards,

Fabio Estevam
