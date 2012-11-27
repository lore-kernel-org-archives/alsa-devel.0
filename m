From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Patch v6 4/4] ASoC: at91sam9g20ek-wm8731: convert to dt support
Date: Tue, 27 Nov 2012 08:44:29 +0000
Message-ID: <201211270844.29311.arnd@arndb.de>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com> <201211262123.42812.arnd@arndb.de> <50B42B4B.90407@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <50B42B4B.90407@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 27 November 2012, Bo Shen wrote:
> >
> > ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"
> 
> Yes, this is because there is a cross merge patch at: 
> https://patchwork.kernel.org/patch/1776941/ acked by Mark Brown, however 
> it does not merged.

I think I'm missing context here. What's holding this up? It looks like it should
have been merged before 531f67e41d, possibly into both arm-soc and asoc.

	Arnd
