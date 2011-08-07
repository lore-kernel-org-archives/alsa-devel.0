From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Sun, 7 Aug 2011 10:51:02 +0100
Message-ID: <20110807095102.GA18612@sirena.org.uk>
References: <s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<4E3D8F73.40902@gmail.com> <20110807030223.GA9579@sirena.org.uk>
	<4E3E1095.3090809@gmail.com> <4E3E1200.1010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 856EA24355
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Aug 2011 11:51:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E3E1200.1010808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: preetam <preetamsashankreddy@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 07, 2011 at 09:48:08AM +0530, preetam wrote:
> On Sunday 07 August 2011 09:42 AM, preetam wrote:
> > On Sunday 07 August 2011 08:32 AM, Mark Brown wrote:

Always CC people on kernel related mails.

> >> You can't.  You should be using DAPM for this, not set_bias_level().

> > Then what is the ideal use case of set_bias_level ?

Managing global CODEC power state such as master biases.

> I am asking this because, I was using set_bias to enable the clocks to 
> the DAC and ADC blocks. This device has two independednt clock sources 
> for DAC and ADC blocks. I would like  to power up only one of them 
> depending on which steam the calls are being made for. So do I do this?

_SUPPLY()
