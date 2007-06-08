From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re:
	=?utf-8?q?=5BRFC=5D_=5BPATCH_1/2=5D_ASoC_sound_suppo?=
	=?utf-8?q?rt_for_SMDK2440=09boards=3A_UDA1341_driver?=
Date: Fri, 8 Jun 2007 08:32:52 +0000 (UTC)
Message-ID: <loom.20070608T103116-916@post.gmane.org>
References: <5b7270f40705240736h7f47e0a0p16ac2b36ae07a5d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C05924699
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 11:17:52 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HwaTs-0002qZ-7r
	for alsa-devel@alsa-project.org; Fri, 08 Jun 2007 11:10:04 +0200
Received: from 40.107.210.62.te-dns.org ([62.210.107.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 11:10:04 +0200
Received: from matthieu.castet by 40.107.210.62.te-dns.org with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 11:10:04 +0200
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

Hi,

Zoltan Devai <zdevai <at> gmail.com> writes:

> 
> ASoC Support for the UDA1341 codec.
> Please note that until there is a final L3-bus driver, this patch won't work.
> 
> ---

> +#include <linux/module.h>
> +#include <linux/l3.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +
> +#include "../s3c24xx/s3c24xx-i2s.h"

Shouldn't be the codec not depend on i2s chip ?
Couldn't we avoid this include ?


Matthieu
