From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Tue, 9 Sep 2008 10:35:23 +0100
Message-ID: <20080909093522.GA31314@sirena.org.uk>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200809082127.13653.gineera@aspect135.co.uk>
	<20080908205105.GA32649@sirena.org.uk>
	<200809090945.35359.gineera@aspect135.co.uk>
	<1220951038.17091.177.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D1F9924549
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 11:35:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220951038.17091.177.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 09, 2008 at 10:03:58AM +0100, Liam Girdwood wrote:

> Might be worth rolling this out to other SPI capable codecs too.....

Yeah, unfortunately it'll need to be done codec by codec checking the
exact wire format required.
