From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: ASoC: cs4271: init/timing problem
Date: Tue, 31 Mar 2015 16:01:01 -0500
Message-ID: <alpine.DEB.2.10.1503311600000.13828@heelrod-desktop>
References: <551A5FC9.4010109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DCEE265065
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 23:01:05 +0200 (CEST)
In-Reply-To: <551A5FC9.4010109@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: brian.austin@cirrus.com, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Tue, 31 Mar 2015, Pascal Huerst wrote:

> Hey all,
> 
> We have a custom built hw, based on am335x and from time to time we need
> to rmmod/modprobe the ASoC machine driver. Depending on the hw, the
> first call to regmap_update_bits(..) in cs4271_codec_probe(..) fails
> with -EREMOTEIO.
> 
> The error is originated in:
> 
> drivers/i2c/busses/i2c-omap.c
> 
> and happens if no i2c package acknowledge is received by the host.
> 
> I think this is a timing issue and on some devices, the codec is just
> not ready yet, for communication.
> 
> What is the right way to fix that? My attempt would be something like this:

The error you are referring to is a NACK from a device (CODEC). That is 
usually seen when you dont have it hooked up correctly. Could also be that 
the I2C bus is too fast. How fast are you running the bus?

-Brian 
