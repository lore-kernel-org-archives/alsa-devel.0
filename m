From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: core: Add 384kHz Support
Date: Wed, 27 Jan 2016 14:59:04 +0100
Message-ID: <56A8CD28.9040209@ladisch.de>
References: <1453902825-27002-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B2A5326044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 14:59:07 +0100 (CET)
In-Reply-To: <1453902825-27002-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brian.austin@cirrus.com, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, charles.keepax@cirrus.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

brian.austin@cirrus.com wrote:
> Adding support for 384kHz audio sample rates

384 kHz already is supported (see the KNOT bit).

>  #define SNDRV_PCM_RATE_96000		(1<<10)		/* 96000Hz */
>  #define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
>  #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
> +#define SNDRV_PCM_RATE_384000		(1<<13)		/* 384000Hz */

These bits are shortcuts for often-used rates.
384 kHz is not often used.


Regards,
Clemens
