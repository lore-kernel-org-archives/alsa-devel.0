From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [alsa-devel] [PATCH 6/9] ASoC: da7210: bugfix for head phone
 volume control
Date: Thu, 13 Oct 2011 14:42:33 +0530
Message-ID: <1318497153.12107.439.camel@matrix>
References: <1318431934.12107.421.camel@matrix>
	 <20111012150101.GS3647@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111012150101.GS3647@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, kuninori.morimoto.gx@renesas.com, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-10-12 at 16:01 +0100, Mark Brown wrote:
> On Wed, Oct 12, 2011 at 08:35:34PM +0530, Ashish Chavan wrote:
> > This patch takes care of reserved bits of headphone volume
> > register by using correct volume range.
> 
> This doesn't apply, which is pretty surprising given that there's no
> obvious overlap at all with the rest of the code.

I guess this is mostly due to indirect dependence on [PATCH 1/9].
It applies after applying first patch.

> 
> > Tested on Samsung SMDK6410 board with DA7210 evaluation board.
> 
> This really isn't useful information in a changelog, apart from anything
> else this isn't going to be a system that it's easy for other people to
> reproduce.
> 
OK, will remove redundant info.
