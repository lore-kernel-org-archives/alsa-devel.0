From: "Xuesong Yang" <xsyang@pixelworks.com>
Subject: Re: Is Asoc suitable for my device?
Date: Wed, 31 Dec 2008 16:35:05 +0800
Message-ID: <848F9F9C4983184C9D6E2429A016640C020847AB@pvgwin06.pixelworks.com>
References: <1230629122.21485.10.camel@star-sea>
	<20081230132530.GB13369@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.pixelworks.com (smtp2.pixelworks.com [207.179.28.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BF051037EB
	for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2008 09:35:29 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <20081230132530.GB13369@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark:
	Thanks for you suggestion. I'll have a look at the codec part of
code.

-----Original Message-----
From: Mark Brown [mailto:broonie@sirena.org.uk] 
Sent: Tuesday, December 30, 2008 9:26 PM
To: Xuesong Yang
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Is Asoc suitable for my device?

On Tue, Dec 30, 2008 at 05:25:22PM +0800, Xuesong Yang wrote:

> 	My problem is I don't know if it suitable for my device use
Asoc.
> 	In my platform, there is only a I2S bypass module, It has a
route,
> select one of the I2S source as input,(from HDMI or cpu data) delay
the
> data for some time and then output it to the backend.
> 	In theory, this device is very sample, but I find I can't get a
easy
> way to implement it in ALSA, I'm lost in ALSA.
> 	Any suggestion will be greatly appreciated.

ASoC sounds like a good fit here: it'd allow you to reuse the I2S and
DMA drivers for the CPU and what you're doing is very similar to what a
codec with analogue bypass can do so it's not really even unusual from
an ASoC point of view.  The only difference is that all your signals are
digital but nothing outside the bypass module will be able to tell.

I'd suggest writing a codec driver for your bypass module - it fits into
the system in the same place and from what you say it sounds like it
could be viewed as a codec that happens to deal in digital formats only.
