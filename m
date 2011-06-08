From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: p1022ds: fix incorrect
 referencing of device tree properties
Date: Wed, 08 Jun 2011 15:06:40 -0700
Message-ID: <4DEFF270.7050105@gmail.com>
References: <1307563376-13055-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 56DEF1037F3
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 00:06:46 +0200 (CEST)
Received: by pwi9 with SMTP id 9so477238pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Jun 2011 15:06:43 -0700 (PDT)
In-Reply-To: <1307563376-13055-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 06/08/11 13:02, Timur Tabi wrote:
> Device tree integer properties are encoded in big-endian format, but some of
> the Freescale ASoC drivers were assuming that the host is in big-endian format
> as well.  Although this is true, it's better to use endian-safe accessors.

Hi Timur,

Can this be true?

I would assume a software constructed data structure would be in
host-endian mode. The only reason to be concerned with endianness is if
you are transmitting binary over some communications medium, or sending
something to hardware (which in rare circumstances may not be host-endian).

Throwing in macros that will always be discarded (if this host is
bigendian) seems unnecessary.

Regards, Steve

> 
> Also add a check for a failed ioremap() call in the SSI driver.
An urelated change should probably be in a new patch.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
