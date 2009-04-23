From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP
	DMA	parameters settings by run-time generation
Date: Thu, 23 Apr 2009 10:30:04 +0100
Message-ID: <20090423093004.GG30105@sirena.org.uk>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
	<74d0deb30904230153l5ec490eck211d6ef456869f36@mail.gmail.com>
	<f17812d70904230202t5dc459bbud36c13b11c6d5725@mail.gmail.com>
	<f17812d70904230205n2c3080cejaaf2a54678dac687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DC692103865
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 11:30:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904230205n2c3080cejaaf2a54678dac687@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 05:05:38PM +0800, Eric Miao wrote:
> Patch updated, rebased on broonie/sound-2.6/for-2.6.31:

Your MUA has eaten this again - I'd suggest using git send-email for
sending patches, the gmail web interface appears not to be able to cope
with them.  I was able to fix it up by hand so I've applied and tested
it - thanks!
