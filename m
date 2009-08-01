From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] hda: add IbexPeak/Clarkdale HDMI model
 with static cvt/pin number
Date: Sat, 1 Aug 2009 15:17:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0908011515340.21927@eeebox2.perex-int.cz>
References: <20090801122700.GA17330@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E750C24394
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 15:17:10 +0200 (CEST)
In-Reply-To: <20090801122700.GA17330@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 1 Aug 2009, Wu Fengguang wrote:

> -#define CVT_NID		0x02	/* audio converter */
> -#define PIN_NID		0x03	/* HDMI output pin */
> +static hda_nid_t cvt_nid;	/* audio converter */
> +static hda_nid_t pin_nid;	/* HDMI output pin */

I don't like to use static variables here. I would recommend to use a 
runtime structure to store these values.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
