From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Fix cs4270 error path
Date: Sat, 27 Sep 2008 18:09:10 +0200
Message-ID: <20080927180910.1ab7eb63@hyperion.delvare>
References: <20080831144214.62a17be6@hyperion.delvare>
	<ed82fe3e0809221335w4da49a21jcce3f676d2f75a54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 13DD024337
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 18:09:18 +0200 (CEST)
In-Reply-To: <ed82fe3e0809221335w4da49a21jcce3f676d2f75a54@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Timur,

On Mon, 22 Sep 2008 15:35:17 -0500, Timur Tabi wrote:
> Sorry I didn't get to this earlier.  I just fell off my radar.
> 
> On Sun, Aug 31, 2008 at 7:42 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > The error path in cs4270_probe/cs4270_remove is pretty broken:
> > * If cs4270_probe fails, codec is leaked.
> > * If snd_soc_register_card fails, cs4270_i2c_driver stays registered.
> 
> So far, so good.
> 
> > * If I2C support is enabled but no I2C device is found, i2c_del_driver
> >  is never called (neither in cs4270_probe nor in cs4270_remove.)
> 
> Hmm... The only time that can happen is if the device tree is wrong or
> the hardware is broken.

The whole point of error paths is to handle cases that were not
supposed to happen.

> (...)  This means that cs4270_i2c_probe() will
> return an error.  What does i2c_add_driver() return in that case?

As per the device driver model, the success or failure of device probes
has zero influence on drivers. So, yes, i2c_add_driver() still succeeds
and returns 0.

> (...)  If
> it still returns 0, then control_data will be NULL, but with your
> patch, i2c_del_driver() will still be called.

Of course, it will be. It has to. This is exactly the bug I am fixing!
If i2c_add_driver() succeeds then i2c_del_driver() must be called in the
cleanup path. It's really that easy. Whether an I2C device was found or
not, must not influence that.

> 
> Also, I think there's a bug in cs4270_i2c_probe(), where it will call
> i2c_detach_driver() if it fails.  It shouldn't do that.  This is also
> gated on codec->control_data, so it's a related bug.

You are right, this is a bug. Apparently you forgot the error path when
converting the driver to a new-style i2c driver. A few lines below,
there's also:
	kfree(i2c_client);
which should be removed.

I disagree that this is related with my initial patch though. It's a
different error path, and it's also broken, but that's hardly enough to
make both bugs "related". So I'll send a separate patch.

> 
> Lastly, you may need to rebase the patch, since the code's changed.

My patch still applies fine (with offset, but that's OK), so I fail to
see why I would need to rebase it.

-- 
Jean Delvare
