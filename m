From: Alexander Stein <alexanders83@web.de>
Subject: Re: [PATCH] ALSA: sound/atmel/ac97c.c: remove unused
	variable
Date: Tue, 19 May 2015 17:38:27 +0200
Message-ID: <1744036.GvGagi42vq@ws-stein>
References: <14010746.Ukv1maRMaG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A60E3260567
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 17:39:31 +0200 (CEST)
In-Reply-To: <14010746.Ukv1maRMaG@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Takashi Iwai <tiwai@suse.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 19 May 2015 17:20:36, Arnd Bergmann wrote:
> The recently added DT support for the ac97 driver is causing
> a gcc warning:
> 
> sound/atmel/ac97c.c: In function 'atmel_ac97c_probe_dt':
> sound/atmel/ac97c.c:919:29: warning: unused variable 'match' [-Wunused-variable]
>   const struct of_device_id *match;
> 
> The variable is clearly unused, so we can remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexander Stein <alexanders83@web.de>
