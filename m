From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Wed, 23 May 2007 16:37:57 +0100
Message-ID: <1179934677.12071.30.camel@a10072.wolfsonmicro.main>
References: <46531097.5040600@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 748C524649
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 17:37:59 +0200 (CEST)
In-Reply-To: <46531097.5040600@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-05-22 at 10:47 -0500, Timur Tabi wrote:
> I'm working on some ASoC drivers for a new board, and we're using a CS4270.  The CS4270 is 
> interesting in that if it is connected in stand-alone mode, there is no way to configure 
> it.  The board wirings determine all the parameters.
> 
> Therefore, my CS4270 codec driver will probably be very skimpy.
> 
> My question is: does this mean that my cs4270.c file will *never* call these functions:
> 
> snd_ctl_add
> snd_soc_cnew

These functions are only required in the codec driver to change volume,
mixer settings etc. If your codec has no volume or mixers then you don't
need them.


> snd_soc_dapm_new_control
> snd_soc_dapm_connect_input
> snd_soc_dapm_new_widgets

These are used for setting up the dynamic audio power management and
won't be needed in stand alone mode.

> 
> These are the functions used to add new controls and widgets.
> 
> So how does ALSA know that it needs to call my I2S driver *instead* of my codec driver to 
> do stuff like change volume?

You probably want to create a volume kcontrol in your I2S driver. I
assume your I2S controller can digitally adjust the volume by altering
the PCM stream ? The kcontrols can be added in your I2S driver probe
function.


Liam
