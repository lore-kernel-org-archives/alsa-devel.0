From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [alsa-devel] [PATCH 3/4] ASOC: WM8731 codec: add SPI support
	as well as I2C
Date: Mon, 01 Sep 2008 15:00:16 +0100
Message-ID: <1220277616.6499.119.camel@odin>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	 <1219829968-6431-4-git-send-email-cooloney@kernel.org>
	 <200809011452.08070.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753315AbYIAOAm@vger.kernel.org>
In-Reply-To: <200809011452.08070.gineera@aspect135.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Bryan Wu <cooloney@kernel.org>, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-09-01 at 14:52 +0100, Alan Horstmann wrote:
> We have just started trying this out as an alternative to i2c, and picked out 
> the following:
> 
> On Wednesday 27 August 2008 10:39, Bryan Wu wrote:
> > -#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> > +#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE) && !defined
> > (CONFIG_SND_SOC_WM8731_SPI)
> 
> I think this needs extra brackets round the ||'s before the && thus:
> 
> > +#if (defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)) && !defined
> > (CONFIG_SND_SOC_WM8731_SPI)
> 
> in order to force use of SPI when (CONFIG_SND_SOC_WM8731_SPI) and (CONFIG_I2C) 
> are both defined.  Or have we misunderstood the intention?  This is in 2 
> other places also in the patch.
> 

It may be simpler to only have CONFIG_SND_SOC_WM8731_SPI and
CONFIG_SND_SOC_WM8731_I2C definitions for all the codec drivers. These
would be set by machine Kconfig. 

Liam
