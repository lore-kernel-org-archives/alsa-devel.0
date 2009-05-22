From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Disabling HFL/R outputs in twl4030
Date: Fri, 22 May 2009 11:36:04 +0100
Message-ID: <20090522103603.GA8542@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705F6AC2661@dlee07.ent.ti.com>
	<200905221248.28656.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DFF61038FC
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 12:36:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905221248.28656.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 22, 2009 at 12:48:28PM +0300, Peter Ujfalusi wrote:

> I guess ASoC does not have support for per codec_dai DAPM routing, or let's 
> put it differently: binding DAPM controls to specific codec_dai.

It should do - the active stream names are matched against the stream
name (second argument) for the DAC to decide if DACs are active.  This
then feeds through to the rest of the output path.  The code for this is
in snd_soc_dapm_stream_event().

Looking at the twl4030 driver the names for the streams need some
adjustment.  I'm vaugely surprised that the HiFi streams match as is but
I think I'm just missing something there.
