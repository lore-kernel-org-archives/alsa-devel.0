From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: patch 1/1: ASoC,
	DMA crash with application-	resolved
Date: Sun, 21 Dec 2008 21:09:07 +0000
Message-ID: <20081221210906.GA14903@sirena.org.uk>
References: <ef0d8a250812202322i3fe62ed2n2d1e09ab830e27dd@mail.gmail.com>
	<bd7b27490812210136m710dc896j43c060e14bc5fb4a@mail.gmail.com>
	<ef0d8a250812210138q3cad7dbay21611e2088a1525b@mail.gmail.com>
	<bd7b27490812210142q708842aai94a02f28d99cdf97@mail.gmail.com>
	<ef0d8a250812210807h5fe861a0s5f62c4b728578022@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8771B24480
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 22:09:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250812210807h5fe861a0s5f62c4b728578022@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "naveenkrishna.ch" <naveenkrishna.ch@gmail.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 21, 2008 at 09:37:21PM +0530, naveenkrishna.ch wrote:

>  To solve the DMA crashes i have sent a patch, it worked i dint found any
> patches related to this issue,
> I tried it on alsa kernel git...

Please check with Jarkko's patch applied below - it's not in ALSA git so
you'll need to cherry pick it over into Takashi's tree by hand:

> commit 55502f74b56f609a84d8919b9b29390b2e0147ff
> Author: Jarkko Nikula <jarkko.nikula@nokia.com>
> Date:   Mon Aug 18 12:28:22 2008 +0300
> 
>     ARM: OMAP: DMA: Fix uninitialized channel flags
