From: Timur Tabi <timur@freescale.com>
Subject: ASoC and a codec that can't be controlled
Date: Tue, 22 May 2007 10:47:35 -0500
Message-ID: <46531097.5040600@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id AE09B24561
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 17:47:39 +0200 (CEST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4MFla3o000605
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 08:47:37 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4MFlZd7016207
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 10:47:36 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm working on some ASoC drivers for a new board, and we're using a CS4270.  The CS4270 is 
interesting in that if it is connected in stand-alone mode, there is no way to configure 
it.  The board wirings determine all the parameters.

Therefore, my CS4270 codec driver will probably be very skimpy.

My question is: does this mean that my cs4270.c file will *never* call these functions:

snd_ctl_add
snd_soc_cnew
snd_soc_dapm_new_control
snd_soc_dapm_connect_input
snd_soc_dapm_new_widgets

These are the functions used to add new controls and widgets.

So how does ALSA know that it needs to call my I2S driver *instead* of my codec driver to 
do stuff like change volume?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
