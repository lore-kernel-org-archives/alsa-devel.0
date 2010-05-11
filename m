From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [patch 4/6] cs42l51: add asoc driver
Date: Tue, 11 May 2010 14:36:16 -0500
Message-ID: <AANLkTimo72JDwZx7bjEQpk8iVAwTPnnuSmPBCioFsmHR@mail.gmail.com>
References: <20100511162342.640158675@mandriva.com>
	<20100511162602.226980713@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8790E1037EA
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 21:36:49 +0200 (CEST)
Received: by pvg6 with SMTP id 6so1040pvg.38
	for <alsa-devel@alsa-project.org>; Tue, 11 May 2010 12:36:47 -0700 (PDT)
In-Reply-To: <20100511162602.226980713@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: tbm@cyrius.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, nico@fluxnic.net
List-Id: alsa-devel@alsa-project.org

On Tue, May 11, 2010 at 11:23 AM,  <apatard@mandriva.com> wrote:

> + * Copyright (c) 2010 Arnaud Patard <apatard@mandriva.com>
> + *
> + * Based on cs4270.c - Copyright (c) Timur Tabi <timur@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

The cs4270.c driver is licensed under the GPL v2 only.  Since you
based your driver on mine, you cannot change the license to "v2 or
later".

-- 
Timur Tabi
Linux kernel developer at Freescale
