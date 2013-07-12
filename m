From: Nicolin Chen <b42378@freescale.com>
Subject: Re: ASoC: codec: SPDIF only works with Tx/Rx seperate
	codec drivers?
Date: Fri, 12 Jul 2013 19:57:13 +0800
Message-ID: <20130712115712.GG28915@MrMyself>
References: <20130712083030.GA28555@MrMyself>
 <20130712113353.GC24508@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 38A3F2659BB
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 14:00:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130712113353.GC24508@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you for the reply.

On Fri, Jul 12, 2013 at 12:33:53PM +0100, Mark Brown wrote:
> We could just merge them into a single driver easily enough.

Merge spdif_receiver.c and spdif_transmitter.c?
But each of them is being individually used by several drivers:
davinci/davinci-evm.c
samsung/smdk_spdif.c
spear/spdif_in.c
spear/spdif_out.c

If we merge these two files, it would break their functions.
Especially for spear's platform, seems they are using SPDIF
IN and OUT separately.
