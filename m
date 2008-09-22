From: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC: Fix cs4270 error path
Date: Mon, 22 Sep 2008 15:35:17 -0500
Message-ID: <ed82fe3e0809221335w4da49a21jcce3f676d2f75a54@mail.gmail.com>
References: <20080831144214.62a17be6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id 74BA624349
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Sep 2008 22:35:18 +0200 (CEST)
Received: by gxk10 with SMTP id 10so4046073gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2008 13:35:17 -0700 (PDT)
In-Reply-To: <20080831144214.62a17be6@hyperion.delvare>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry I didn't get to this earlier.  I just fell off my radar.

On Sun, Aug 31, 2008 at 7:42 AM, Jean Delvare <khali@linux-fr.org> wrote:
> The error path in cs4270_probe/cs4270_remove is pretty broken:
> * If cs4270_probe fails, codec is leaked.
> * If snd_soc_register_card fails, cs4270_i2c_driver stays registered.

So far, so good.

> * If I2C support is enabled but no I2C device is found, i2c_del_driver
>  is never called (neither in cs4270_probe nor in cs4270_remove.)

Hmm... The only time that can happen is if the device tree is wrong or
the hardware is broken.  This means that cs4270_i2c_probe() will
return an error.  What does i2c_add_driver() return in that case?  If
it still returns 0, then control_data will be NULL, but with your
patch, i2c_del_driver() will still be called.

Also, I think there's a bug in cs4270_i2c_probe(), where it will call
i2c_detach_driver() if it fails.  It shouldn't do that.  This is also
gated on codec->control_data, so it's a related bug.

Lastly, you may need to rebase the patch, since the code's changed.

-- 
Timur Tabi
Linux kernel developer at Freescale
