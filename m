From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Tue, 07 Jan 2014 13:07:22 +0100
Message-ID: <52CBEDFA.10603@metafoo.de>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-149.synserver.de
 [212.40.185.149])
 by alsa0.perex.cz (Postfix) with ESMTP id B48392616CB
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 13:06:57 +0100 (CET)
In-Reply-To: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Nicolin Chen <b42378@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 01/07/2014 12:56 PM, Fabio Estevam wrote:
[...]
> Backtrace:
> [<804aee5c>] (dmaengine_pcm_dma_complete) from [<802e6428>] (sdma_tasklet+0x128)
> [<802e6300>] (sdma_tasklet) from [<8002c4b8>] (tasklet_action+0x90/0x148)
>  r10:808f64c0 r8:00000000 r7:8089cd24 r6:80894000 r5:00000000 r4:bfaa41b0
[...]
> 
> I haven't started debugging it, but if this looks familiar to someone,
> please let me know.
> 

We've had similar problems like this before. Typically this is caused by the
dmaengine driver calling the complete callback when it shouldn't. E.g. after
dmaegine_terminate_all() has already been called for the channel. There is
also unfortunately a small chance condition (which needs some extensions to
the dmaengine API before we can fix it). But the chance for this race
condition to occur is really small and has only been observed on a 4 (or 8,
not sure) core system so far. Is the problem reproducible in your case? Also
do you have a know good kernel version?

> Regards,
> 
> Fabio Estevam
> 
