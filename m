From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Cards that support ADPCM in hardware
Date: Thu, 16 Oct 2014 19:46:36 +0200
Message-ID: <5440047C.5030501@ladisch.de>
References: <543FD8E3.3020802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 282B12605E9
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 19:46:06 +0200 (CEST)
In-Reply-To: <543FD8E3.3020802@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, davem@davemloft.net, adrian@mcmen.demon.co.uk, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> Due to the "remove support for old hardware" topic that is going to be
> discussed at the Linux Plumbers Conference, let me see if there is
> actually any supported hardware that supports ADPCM.
>
> A quick grep for ADPCM in the sound directory yields this:
>
> ./isa/wss/wss_lib.c: ISA, Windows sound system
> ./isa/sb/sb16_{main,csp}.c: ISA, classic SB16 card
> ./oss/ad1848.c: Another ISA card, OSS-only
> ./sh/aica.c: for SEGA Dreamcast console
> ./sparc/cs4231.c: I don't know about this

Essentially _all_ ISA sound cards are SB or WSS compatible.

> Is any of the hardware listed above still used (or usable) with the
> current kernels?

This is the same question as whether anybody is still using hardware
with actual ISA slots.  For which I do not have an answer, but I suspect
it is "yes".


Regards,
Clemens
