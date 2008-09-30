From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Fix cs4270 error path
Date: Tue, 30 Sep 2008 10:31:37 +0200
Message-ID: <20080930103137.52b428a6@hyperion.delvare>
References: <20080831144214.62a17be6@hyperion.delvare>
	<ed82fe3e0809290642l358dab29r274ba97d5bd4b473@mail.gmail.com>
	<s5hhc7zjc6k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A422243D0
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 10:31:48 +0200 (CEST)
In-Reply-To: <s5hhc7zjc6k.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Mon, 29 Sep 2008 15:48:03 +0200, Takashi Iwai wrote:
> At Mon, 29 Sep 2008 08:42:15 -0500,
> Timur Tabi wrote:
> > 
> > On Sun, Aug 31, 2008 at 7:42 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > > The error path in cs4270_probe/cs4270_remove is pretty broken:
> > > * If cs4270_probe fails, codec is leaked.
> > > * If snd_soc_register_card fails, cs4270_i2c_driver stays registered.
> > > * If I2C support is enabled but no I2C device is found, i2c_del_driver
> > >  is never called (neither in cs4270_probe nor in cs4270_remove.)
> > >
> > > Fix the first 2 problems by implementing a clean error path in
> > > cs4270_probe and jumping to its labels as needed. Fix the 3rd problem
> > > by removing the condition to call i2c_del_driver in cs4270_remove.
> > >
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > 
> > Acked-By: Timur Tabi <timur@freescale.com>
> > 
> > Takashi, this patch needs to go into 2.6.27 as well.  Sorry about
> > that.  I don't know how I missed so many problems with my code.
> 
> Don't worry, I already put it to the queue, too.

I fear there's some confusion there. There are two different patches
fixing error paths in cs4270. One fixing a fallout from the new-style
i2c driver conversion (in cs4270_i2c_probe), under name "ASoC: Fix
another cs4270 error path". This one you pushed to Linus last night.

But there's another one, named "ASoC: Fix cs4270 error path",
originally posted by myself on August 31st, fixing the error path of
cs4270_probe. This is the one Timur was just acking, but I do _not_ see
it in your queue, so I suspect you missed it. I can resend it if it
helps.

Thanks,
-- 
Jean Delvare
