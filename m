From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/3] ASoC: Blackfin: add multi-channel
	supporting in Blackfin ASoC driver and AD1980 codec driver
Date: Tue, 21 Oct 2008 10:15:51 +0100
Message-ID: <20081021091550.GE10841@sirena.org.uk>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
	<1224560173-8728-3-git-send-email-cooloney@kernel.org>
	<20081021083715.GA10841@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA02E66236@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 180C91038FA
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 11:16:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA02E66236@chinexm1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Cai, Cliff" <Cliff.Cai@analog.com>
Cc: Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2008 at 05:08:31PM +0800, Cai, Cliff wrote:

> >To be honest, I'm surprised that the multi-channel support 
> >can't only incur the extra memory consumpton when playing back 
> >a multi-channel stream - I'd have expected the hardware to 
> >work in the same way for a normal stereo stream even if 
> >multi-channel support is built in.

> Yes,hardware almost works in the same way as playing a stereo
> stream,except
> That it need to fill more data to DMA memory manually,since we just
> simulate AC97
> Controller using serial port.

My point is that the configuration of the hardware for multi-channel
playback only needs to be done when actually playing back multi-channel
data.  When playing back stereo data it should be possible to configure
the hardware and do the simulation in the same way as when multi-channel
support is not compiled in and avoid the additional costs which that
incurs.

As well as saving memory I'd expect configuring this at runtime to also
save some power when playing back two or four channel data.
