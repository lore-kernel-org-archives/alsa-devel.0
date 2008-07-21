From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: soc - fsl_ssi.c fix audio capture
Date: Mon, 21 Jul 2008 09:56:17 -0500
Message-ID: <4884A391.7010500@freescale.com>
References: <20080704154313.GA11635@polina.dev.rtsoft.ru>
	<20080704154346.GA27136@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FBB624369
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 16:56:21 +0200 (CEST)
In-Reply-To: <20080704154346.GA27136@polina.dev.rtsoft.ru>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Anton Vorontsov wrote:
> Since we're using SSI in synchronous mode, the STCCR register controls
> both the receive and transmit sections. So, when we're trying to record
> anything, stccr register does not get initialized, thus the output file
> filled with the white noise.
> 
> Fix this by initializing the STCCR for both playback and capture.
> 
> Also use hw_params and hw_free callbacks, so that we won't fail at the
> last moment, thus applications could negotiate.

I already have a patch that fixes this problem, I'm just not ready to post it.

I really do appreciate your efforts, Anton, but you have to give me a chance to
do my job!

-- 
Timur Tabi
Linux kernel developer at Freescale
