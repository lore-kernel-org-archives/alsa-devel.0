From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: asoc driver for ad1888 available?
Date: Thu, 27 Mar 2008 22:23:39 +0000
Message-ID: <1206656620.3396.17.camel@a10073.wolfsonmicro.main>
References: <47EBBBB8.1010607@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DEFC24336
	for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2008 23:23:42 +0100 (CET)
In-Reply-To: <47EBBBB8.1010607@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tzachi Perelstein <tzachi@marvell.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-03-27 at 17:22 +0200, Tzachi Perelstein wrote:
> Hello,
> 
> I'm looking for an asoc ad1888 codec driver. Does anyone know if 
> such driver available somewhere? I couldn't find one with google
> nor on linux-2.6-asoc.git.
> 

Fwiw, I've not heard from anyone doing a AD1888 driver atm.

> Can anyone suggest an alternative AC97 2.3 codec device with AC97-
> Link which has an available asoc driver?
> 

Currently supported codecs :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=tree;f=sound/soc/codecs;hb=dev

Although, afaik I don't think any are 6 channel like the AD1888. 

Btw, if you only need 2 channel audio then you could use the generic
AC97 codec driver with the AD1888 (it can hook into ASoC platform and
DMA code).

Liam
