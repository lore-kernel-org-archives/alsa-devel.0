From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to support multiple codecs
Date: Thu, 12 Jun 2008 23:16:48 -0400
Message-ID: <9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CFB6243A8
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 05:16:49 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3461466rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2008 20:16:48 -0700 (PDT)
In-Reply-To: <9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
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

 * Even more frustrating is the fact that the CS4270 driver is an I2C
 * driver, so it's probed via the I2C bus.  We need to update the powerpc
 * platform to initialize client->dev->archdata.of_node to point to the
 * device node.  Then the CS4270 driver can get its own clock rate.

That is easy to fix in drivers/of/of_i2c.c, add...
info.platform_data = node;

The node will be in
client->dev.platform_data

-- 
Jon Smirl
jonsmirl@gmail.com
