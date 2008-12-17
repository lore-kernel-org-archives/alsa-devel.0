From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SND_SOC_DAIFMT_NB_NF meaning
Date: Wed, 17 Dec 2008 11:01:44 +0000
Message-ID: <20081217110143.GA22204@sirena.org.uk>
References: <49486392.4080001@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 867561037E3
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 12:01:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49486392.4080001@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 16, 2008 at 07:27:30PM -0700, Troy Kisky wrote:

> A quick question here. Does SND_SOC_DAIFMT_NB_NF have a standard meaning
> or does it depend on what mode your in (I2S, DSP_A, right just). From
> looking at the sources, SND_SOC_DAIFMT_NB_NF usually means that data is
> valid on the rising BCLK and start of frame is rising edge if DSP mode.

It means whatever is normal for the mode the bus is in (I2S, DSP_A and
so on) - hence the name.

> The reason I ask, is that I'd like to pass the same flags to the codec and
> the cpu_dai and have them agree with the interpretation.

That is the intention.  Anything that's doing something else is buggy.
