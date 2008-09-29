From: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC: Fix cs4270 error path
Date: Mon, 29 Sep 2008 08:42:15 -0500
Message-ID: <ed82fe3e0809290642l358dab29r274ba97d5bd4b473@mail.gmail.com>
References: <20080831144214.62a17be6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id 2687524397
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 15:42:17 +0200 (CEST)
Received: by gxk10 with SMTP id 10so12639016gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2008 06:42:15 -0700 (PDT)
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
To: Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 31, 2008 at 7:42 AM, Jean Delvare <khali@linux-fr.org> wrote:
> The error path in cs4270_probe/cs4270_remove is pretty broken:
> * If cs4270_probe fails, codec is leaked.
> * If snd_soc_register_card fails, cs4270_i2c_driver stays registered.
> * If I2C support is enabled but no I2C device is found, i2c_del_driver
>  is never called (neither in cs4270_probe nor in cs4270_remove.)
>
> Fix the first 2 problems by implementing a clean error path in
> cs4270_probe and jumping to its labels as needed. Fix the 3rd problem
> by removing the condition to call i2c_del_driver in cs4270_remove.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-By: Timur Tabi <timur@freescale.com>

Takashi, this patch needs to go into 2.6.27 as well.  Sorry about
that.  I don't know how I missed so many problems with my code.

-- 
Timur Tabi
Linux kernel developer at Freescale
