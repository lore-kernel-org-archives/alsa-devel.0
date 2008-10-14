From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: define confusion
Date: Tue, 14 Oct 2008 14:44:25 +0100
Message-ID: <20081014134422.GG14538@sirena.org.uk>
References: <520f0cf10810140441n33664dedp1ea441f6458ea964@mail.gmail.com>
	<20081014114629.GD14538@sirena.org.uk>
	<520f0cf10810140452q5bb920f2u3c55c3375a2aa817@mail.gmail.com>
	<20081014121741.GE14538@sirena.org.uk>
	<520f0cf10810140529x1cac054hf1e2078c60f5b921@mail.gmail.com>
	<520f0cf10810140616y76949deeg96986bc8e19be4a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 68EDF24520
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 15:44:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810140616y76949deeg96986bc8e19be4a6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 14, 2008 at 03:16:58PM +0200, John Kacur wrote:

> My situation is that although the codec has an internal clock, I will
> not be using it, (because it is not activated in the presense of an
> external clock source on the pin) the bit clock and the master clock
> are coming from the i2s bus, and I suppose the details of where they
> stem from is irrelevant. If they are not irrelevant, then the master
> clock is provided to the i2s bus from a crystal. So that means from
> the codec's view point that makes everything SND_SOC_DAIFMT_CBS_CFS.

If the I2S bus is being clocked directly from the crystal rather than
via the CPU you want to tell the codec CBS_CFS and the CPU CBM_CFM so
that both devices are configured as slaves.
