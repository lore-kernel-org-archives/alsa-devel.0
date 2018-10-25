From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 - AAF PCM plugin 0/7] Introduce AVTP
 Audio Format (AAF) plugin
Date: Thu, 25 Oct 2018 08:41:15 +0200
Message-ID: <8c7008ad-3489-55eb-2d66-db03f8b8c29f@perex.cz>
References: <20181025011116.12360-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id E9A0B267971
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2018 08:41:20 +0200 (CEST)
In-Reply-To: <20181025011116.12360-1-andre.guedes@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andre Guedes <andre.guedes@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Dne 25.10.2018 v 03:11 Andre Guedes napsal(a):
> Hi all,
> 
> This new version addresses the feedback from v1 and fixes a bug on capture
> mode. Code-wise, the changes are very trivial, no major diffs. Below follows
> the highlights:
> 
>   * Standard headers like linux/if_ether.h are now checked by configure script.
>   * The 'static' modifier was added to array variables in aaf_hw_constraint().
>   * aaf_close() callback was simplified.
>   * aaf_rx_pdu() was modified so it doesn't return an error in case the number
>     of bytes read by recv() is different from aaf->pdu_size. This is an
>     expected situation and it means the received AVTPDU doesn't belong to the
>     AAF stream the plugin is interested in so it should simply drop that
>     AVTPDU. This fixes a bug when running multiple streams (with different
>     AVPTU sizes) concurrently.
> 
> Additionally, this new version improves the instructions in doc/aaf.txt in
> order to make it easier to test the plugin. Anyone should be able to test it
> just by copying and pasting the instructions.

Thanks for your code. I did a quick review and a compilation test and it
seems fine to include this improved code to alsa-plugins. I committed
your changes.

Our repos are on github now, too : https://github.com/alsa-project

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
