From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: prevent compilers from
	optimising	pll calculation into __aeabi__uldivmod
Date: Thu, 28 Apr 2011 12:40:38 +0100
Message-ID: <20110428114037.GA26116@sirena.org.uk>
References: <1303889252-6722-1-git-send-email-bs14@csr.com>
	<s5h8vuwgl7f.wl%tiwai@suse.de>
	<BANLkTi=RuNgN_+26GBrwoHJuz1xSM=YcfQ@mail.gmail.com>
	<s5h1v0ogk6k.wl%tiwai@suse.de>
	<BANLkTimm3wB+EcBZMZzW2SoeJkibisdBWQ@mail.gmail.com>
	<20110427143002.GC31952@opensource.wolfsonmicro.com>
	<BANLkTimOdPO=LJNAM8EqXnMcx3xHPcoOXA@mail.gmail.com>
	<20110427151249.GE31952@opensource.wolfsonmicro.com>
	<BANLkTin+VhH9bZXub495t1RL+6+SyNndzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 979571037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 13:40:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTin+VhH9bZXub495t1RL+6+SyNndzA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Hope <michael.hope@linaro.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Barry Song <21cnbao@gmail.com>, linaro-toolchain@lists.linaro.org, Zhiwu Song <zhiwu.song@csr.com>, Binghua Duan <binghua.duan@csr.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 10:30:24AM +1200, Michael Hope wrote:

Don't top post!

> Hi Mark.  The fault exists in FSF GCC 4.5.2 and Linaro GCC
> 4.5-2011.04.  The fault does not exist in FSF GCC 4.6.0 or Linaro GCC
> 4.6-2011.04.

Given that nobody's reported it previously and there's already a new GCC
release I'm not sure it's worth worry about - it's a fairly clear
compiler bug.
