From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: SSM2518 Device Tree support ?
Date: Thu, 13 Aug 2015 14:21:52 +0200
Message-ID: <55CC8BE0.4000406@metafoo.de>
References: <alpine.DEB.2.02.1508131400010.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-198.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D8EF62619F5
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:21:53 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508131400010.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/13/2015 02:12 PM, Ricard Wanderlof wrote:
> 
> We needed DT support in the SSM2518 codec driver, and I noticed that there 
> is already a set of bindings specified in Documentation/devicetree, 
> however, there doesn't seem to be any DT support in the driver itself. I 
> don't know if this is the result of a missing commit ? 

There is DT support in the driver. E.g. see the of_get_gpio() call.

What's not in the driver is a explicit of match table. It will work without
since the I2C subsystem supports matching based on the I2C ID table. But,
yes, it is better to add a explicit OF table to indicate that this works.

> 
> Documentation/devicetree/bindings/sound/ssm2518.c seems to have been added 
> in May 2013.
> 
> I've added rudimentary support for at least the compatible property so 
> that the driver can be used in a system with DT configuration (sent as a 
> separate email).
