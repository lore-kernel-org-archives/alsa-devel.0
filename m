From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 0/2] Kirkwood audio fixes
Date: Mon, 12 Jul 2010 12:03:05 +0100
Message-ID: <1278932585.3072.33.camel@odin>
References: <20100711212830.815827907@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 18F51243BD
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 13:03:14 +0200 (CEST)
Received: by wwc33 with SMTP id 33so651003wwc.20
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2010 04:03:07 -0700 (PDT)
In-Reply-To: <20100711212830.815827907@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: arnaud.patard@rtp-net.org
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-07-11 at 23:28 +0200, arnaud.patard@rtp-net.org wrote:
> 
> Hi,
> 
> While working on the t5325 audio support, I found two small buglets in the
> kirkwood ASoC support. 
> 
> The first one is aiming at fixing mono audio playback and should fix mono
> playback for all platforms.
> The second is adding support for muting/unmuting kirkwood audio. It's 
> mainly usefull for the t5325 which has a bootloader playing with this
> (hardware default is not muted).
> 
> 

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
