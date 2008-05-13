From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] [ASOC]: AD1980 audio codec ASOC driver
Date: Tue, 13 May 2008 16:24:23 +0100
Message-ID: <20080513152423.GA649@sirena.org.uk>
References: <1210589112-12208-1-git-send-email-cooloney@kernel.org>
	<20080512115416.GB23216@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA01F2EF2C@chinexm1.ad.analog.com>
	<20080513140132.GG21292@sirena.org.uk>
	<386072610805130807l3e3943e1w24c38b640ab331a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C38D24B32
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 17:24:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <386072610805130807l3e3943e1w24c38b640ab331a6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: liam.girdwood@wolfsonmicro.com, "Cai, Cliff" <Cliff.Cai@analog.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2008 at 11:07:16PM +0800, Bryan Wu wrote:
> On Tue, May 13, 2008 at 10:01 PM, Mark Brown

> > We've had patches in the ASoC git tree for some time (along with the AD1980
> >  driver) - it'd be good to get everything merged into ALSA.

> Do you mean there is another version AD1980 in ASoC git tree?

We're carrying both AD1980 and Blackfin platform code.  The AD1980
driver is currently identical to the one you just sent.

Everything is in the dev branch of:

	git://opensource.wolfsonmicro.com/linux-2.6-asoc
