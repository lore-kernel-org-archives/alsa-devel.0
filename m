From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: ASoC: OMAP/TI upstream route
Date: Mon, 26 Apr 2010 19:22:28 +0300
Message-ID: <20100426192228.228489c7.jhnikula@gmail.com>
References: <1272293803.3208.85.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 7385624605
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 18:21:46 +0200 (CEST)
Received: by ewy19 with SMTP id 19so3772335ewy.22
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 09:21:45 -0700 (PDT)
In-Reply-To: <1272293803.3208.85.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, 26 Apr 2010 15:56:43 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> Now that I'm back working full time on ASoC I'm going to manage the
> upstream branch for the OMAP platform and TI codecs. Mark will continue
> to manage the upstream for all other codecs, platforms and core.
> 
> As usual, please CC both Mark and I on new ASoC patches. The OMAP
> upstream branch tracks Takashi's topic/asoc branch and is here :-
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git #for-2.6.35
> 
To clarify: is this new tree for handling possible cross tree issues
with current and future ASoC OMAPs?

I don't see a need for own tree for plain sound/soc/omap/ patches but
this could makes sense for patches that touch also arch/arm/ (we have
had a few cases) or sounc/soc/codec/ (if we ever have such a need?).


-- 
Jarkko
