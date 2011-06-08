From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: p1022ds: fix incorrect
 referencing of device tree properties
Date: Wed, 8 Jun 2011 17:27:01 -0500
Message-ID: <4DEFF735.1050301@freescale.com>
References: <1307563376-13055-1-git-send-email-timur@freescale.com>
	<4DEFF270.7050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id F13381037F3
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 00:27:09 +0200 (CEST)
In-Reply-To: <4DEFF270.7050105@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Steve Calfee wrote:
>> Device tree integer properties are encoded in big-endian format, but some of
>> > the Freescale ASoC drivers were assuming that the host is in big-endian format
>> > as well.  Although this is true, it's better to use endian-safe accessors.
> Hi Timur,
> 
> Can this be true?

Yes, it's true.  When the device tree compiler compiles a property that looks
like this:

	fsl,ssi-fifo-depth = <15>;

It writes the following bytes into the dtb:

	00 00 00 0f

> I would assume a software constructed data structure would be in
> host-endian mode.

I wouldn't assume that at all.  The device tree format is a defined binary
format.  It makes sense that the endianness of multi-byte integers is defined.

-- 
Timur Tabi
Linux kernel developer at Freescale
