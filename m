From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] SOC: fix tests in cs4270_hw_params()
Date: Thu, 17 Apr 2008 11:41:12 -0500
Message-ID: <48077DA8.10809@freescale.com>
References: <480770A3.3070805@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E0BAD103851
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 18:41:17 +0200 (CEST)
In-Reply-To: <480770A3.3070805@tiscali.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Roel Kluin wrote:
> cs4270_hw_params does several times:
> 
> ret = snd_soc_write()
> if (ret < 0)
> 	...
> 
> This only works when ret is signed.
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Thanks, but in the future, please remember to CC the author of the driver when
posting patches for it.

-- 
Timur Tabi
Linux kernel developer at Freescale
