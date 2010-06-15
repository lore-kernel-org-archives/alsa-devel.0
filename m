From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Update on TLV320AIC3204 Driver [File 3/3]
Date: Tue, 15 Jun 2010 10:34:51 +1000
Message-ID: <20100615003451.GE7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002913.GC7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25])
	by alsa0.perex.cz (Postfix) with ESMTP id E47F3103807
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 02:34:55 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOK7B-0002Fo-2Q
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:34:54 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOK7A-0002FU-C9
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:34:53 +1000
Content-Disposition: inline
In-Reply-To: <20100615002913.GC7759@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached :- include/sound/tlv320aic3204.h
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

--WfZ7S8PLGjBY9Voh
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: attachment; filename="tlv320aic3204.h"

/*
 * Platform data for Texas Instruments TLV320AIC3204 codec
 *
 * Copyright (C) 2010 Jacques Electronics Pty Ltd
 * Author: Stuart Longland <redhatter@gentoo.org>
 *
 * Based on tlv320aic3x.h:
 * Author: Jarkko Nikula <jhnikula@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#ifndef __TLV320AIC3204_H__
#define __TLV320AIC3204_H__

struct aic3204_pdata {
	int gpio_reset; /* < 0 if not used */
};

#endif

--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--WfZ7S8PLGjBY9Voh--
