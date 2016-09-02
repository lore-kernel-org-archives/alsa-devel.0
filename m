From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] test: fix comment about first two fields
 of TLV data payload
Date: Fri, 2 Sep 2016 23:11:30 +0900
Message-ID: <3e25f3bb-b951-a964-897f-11b2c9cb5d28@sakamocchi.jp>
References: <1472516505-8350-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h7fay4ya7.wl-tiwai@suse.de>
 <7934a94f-a725-1d4b-43f0-3ea24a435aee@sakamocchi.jp>
 <dc879ef0-f95f-fd11-06bf-a31ac1a29e5d@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id BF9C7267621
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 16:11:36 +0200 (CEST)
In-Reply-To: <dc879ef0-f95f-fd11-06bf-a31ac1a29e5d@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Aug 30 2016 16:24, Clemens Ladisch wrote:
> In the kernel, you could use the macros from include/sound/tlv.h.
> 
> Either copy them into your test program, and use them directly:
> 
> 	/* 4 words: */
> 	DECLARE_TLV_DB_MINMAX(orig, -60, +60);
> 	/* container with only one subitem; 8 words: */
> 	DECLARE_TLV_CONTAINER(orig_container,
> 		TLV_ITEM(SNDRV_CTL_TLVT_CHMAP_FIXED,
> 			 SNDRV_CHMAP_FL, SNDRV_CHMAP_FR, SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE)
> 	);
> 
> or create the values by hand:
> 
> 	orig[0] = SNDRV_CTL_TLVT_DB_MINMAX;
> 	orig[1] = 2 * sizeof(*orig);
> 	orig[2] = -60;
> 	orig[3] = +60;
> 
> 	orig_container[0] = SNDRV_CTL_TLVT_CONTAINER;
> 	orig_container[1] = 6 * sizeof(*orig_container);
> 		orig_container[2] = SNDRV_CTL_TLVT_CHMAP_FIXED;
> 		orig_container[3] = 4 * sizeof(*orig_container);
> 		orig_container[4] = SNDRV_CHMAP_FL
> 		orig_container[5] = SNDRV_CHMAP_FR;
> 		orig_container[6] = SNDRV_CHMAP_FC;
> 		orig_container[7] = SNDRV_CHMAP_LFE;

Mmm. For user-defined control element sets, these macros should be in UAPI.

SNDRV_CTL_IOCTL_ELEM_ADD was really long abandoned...


Thanks

Takashi Sakamoto
