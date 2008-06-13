From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to support multiple codecs
Date: Thu, 12 Jun 2008 23:36:54 -0400
Message-ID: <9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
	<9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 239FF243AE
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 05:37:21 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3465396rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2008 20:37:21 -0700 (PDT)
In-Reply-To: <9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 6/12/08, Jon Smirl <jonsmirl@gmail.com> wrote:
>  * Even more frustrating is the fact that the CS4270 driver is an I2C
>   * driver, so it's probed via the I2C bus.  We need to update the powerpc
>   * platform to initialize client->dev->archdata.of_node to point to the
>   * device node.  Then the CS4270 driver can get its own clock rate.
>
>  That is easy to fix in drivers/of/of_i2c.c, add...
>  info.platform_data = node;
>
>  The node will be in
>  client->dev.platform_data

Thinking about this for a minute, it is not what you want. Adding code
like this will make the codec driver platform specific. Codecs are
platform drivers, not of_platform drivers specific since they are
supposed to be arch independent.

Instead the codec should make a module parameter for the clock rate.
On platforms without a device tree you would set the clock rate on the
load module command line or some other way. With device trees the ssi
driver can stuff the clock rate into the module parameter after the
module is loaded.

Now I just have to remember how to access a module parameter from code
inside the kernel. I think there is a way to access the names of the
modules parameters. Code in the ssi driver (or a library) could match
up entries in the devices tree to parameter names. That will let one
piece of code in ssi load different modules with varying parameters.

Is there a better way to get parameters to cross platform codec drivers?

>  --
>  Jon Smirl
>  jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
