From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Mon, 24 May 2010 11:49:16 +0100
Message-ID: <1274698156.3064.93.camel@odin>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id CAD6D245DE
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 12:49:21 +0200 (CEST)
Received: by wyj26 with SMTP id 26so1481386wyj.38
	for <alsa-devel@alsa-project.org>; Mon, 24 May 2010 03:49:20 -0700 (PDT)
In-Reply-To: <20100524074946.GC16346@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-05-24 at 17:49 +1000, Stuart Longland wrote:
> Now this compiles... but when I go to load it; one of two things
> happens... either practically nothing (at this stage; no modules are
> loaded prior to calling modprobe):
> 

It does sound like you have some memory corruption somewhere. Can you
rule out your new CODEC driver by replacing it with another CODEC driver
(ads117x.c is a very simple example).

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
