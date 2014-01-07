From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Tue, 07 Jan 2014 13:50:20 +0100
Message-ID: <52CBF80C.3000907@metafoo.de>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
 <52CBEDFA.10603@metafoo.de>
 <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-154.synserver.de
 [212.40.185.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C5472617AD
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 13:50:05 +0100 (CET)
In-Reply-To: <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Nicolin Chen <b42378@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 01/07/2014 01:29 PM, Fabio Estevam wrote:
> Hi Lars-Peter,
> 
> On Tue, Jan 7, 2014 at 10:07 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> We've had similar problems like this before. Typically this is caused by the
>> dmaengine driver calling the complete callback when it shouldn't. E.g. after
>> dmaegine_terminate_all() has already been called for the channel. There is
>> also unfortunately a small chance condition (which needs some extensions to
>> the dmaengine API before we can fix it). But the chance for this race
>> condition to occur is really small and has only been observed on a 4 (or 8,
>> not sure) core system so far. Is the problem reproducible in your case? Also
> 
> Thanks for your comments. Yes, I get this issue on a mx6 quad all the
> time running linux-next, but not on a mx6solo.

Looking at the imx-sdma dmaengine driver there is a whole bunch of issues in
regard to concurrency. The problem might have existed before and only
surfaced now due to some random other changes.

For starters there is absolutely no protection against concurrent access to
the drivers state struct. Access to buf_tail, bd, num_bd and possible other
fields should be protected by a lock. The second problem is that the active
descriptor is not invalidated when dmaengine_terminate_all() is called, so
if the tasklet runs after dmaengine_terminate_all() has been called the DMA
descriptor callback will be called even though it shouldn't.

And another problem is that the imx-sdma driver doesn't really conform to
the semantics of the dmaengine API with regrads to the prepare, submit and
issue_pending. But I don't think this is the source of the problem in this case.

- Lars
