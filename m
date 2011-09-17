From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC/DAPM: How to make the DAPM routing complete?
Date: Sat, 17 Sep 2011 14:32:07 +0100
Message-ID: <20110917133206.GB3798@sirena.org.uk>
References: <4E735811.2060002@novero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 63BF4244A6
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 15:32:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E735811.2060002@novero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bas Vermeulen <Bas.Vermeulen@novero.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 04:07:13PM +0200, Bas Vermeulen wrote:

> I want/need to go from HS1/HS2 to DIN for playback, and from MIC1 to 
> DOUT for capture. In order to do that, I have to set the following switches:

> amixer -q sset 'DAC HS1 Mux' 'Right'
> amixer -q sset 'DAC HS2 Mux' 'Left'
> amixer -q sset 'I2S Mic Mux' 'ADC'
> amixer -q sset 'ADC Left Mux' 'ADCL'

> I would like to make this automatic, but I am unsure how to express this 
> in my dapm routing table.

You shouldn't do this in kernel, decisions like this should be deferred
to userspace.  Most distributions have init scripts which can apply
settings or you can use the use case management code in alsa-lib from your
app.  Not putting this in kernel gives more runtime flexibility which is
especially useful when you get things like reference boards which can
run multiple distributions that may not always agree about the best setup.

> Note that in order to be able to use playback and capture independently 
> on the I2S interface (within reason, it is not possible to use a 
> different rate for instance), I had to add a SUPPLY control to the dapm 
> widgets that turns on the I2S clock when needed.

Can you send a patch for this please?
