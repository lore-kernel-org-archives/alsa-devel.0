From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: davinci-pcm: latch EDMA errors
Date: Sun, 2 Oct 2011 19:48:42 +0100
Message-ID: <20111002184842.GF2857@opensource.wolfsonmicro.com>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
	<647c53d57c6dc6b9780f7f1ad21f39106e702566.1317417232.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6AD31103821
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 20:48:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <647c53d57c6dc6b9780f7f1ad21f39106e702566.1317417232.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 05:23:01PM -0400, Ben Gardiner wrote:
> The davinci-pcm driver currently ignores all EDMA completion callbacks that
> could be indicating an error.

> Latch any edma error-status callbacks and report them as SNDDRV_PCM_POS_XRUN
> like is done in fsl_dma.c.

Nothing in this patch ever seems to clear the flag which seems rather
extreme.  I'd expect that if you're going to do this then the flag would
be cleared after one error has been reported.

> In testing when an error occured early-on in playback the stream did not halt,
> but several underruns were reported until eventually the stream halted.

> Is there a better way to report HW errors up the stack?

Not really, and it's not clear that it's constructive to try -  if
there's a problem that doesn't otherwise cause a failure then generally
the user will intervene.
