From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: soc - fsl_ssi.c fix audio capture
Date: Thu, 3 Jul 2008 15:42:56 +0100
Message-ID: <20080703144254.GB652@sirena.org.uk>
References: <20080703143714.GA7003@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AD06E24919
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 16:43:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080703143714.GA7003@polina.dev.rtsoft.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 03, 2008 at 06:37:14PM +0400, Anton Vorontsov wrote:
> Since we're using SSI in synchronous mode, the STCCR register controls
> both the receive and transmit sections. So, when we're trying to record
> anything, stccr register does not get initialized, thus the output file
> filled with the white noise.

> Fix this by initializing the STCCR for both playback and capture. If
> TX/RX widths don't match, return that we're busy at the moment.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but Timur needs to ack it since I don't have any particular knowledge of
the hardware.
