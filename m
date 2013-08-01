From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: remove unused mux
Date: Thu, 01 Aug 2013 14:04:47 +0200
Message-ID: <51FA4EDF.4020809@metafoo.de>
References: <1375356562-28151-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-136.synserver.de (smtp-out-136.synserver.de
 [212.40.185.136])
 by alsa0.perex.cz (Postfix) with ESMTP id B1ED7260308
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 14:03:47 +0200 (CEST)
In-Reply-To: <1375356562-28151-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 08/01/2013 01:29 PM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> Remove unused "INL Mux" and "INR Mux".
> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
> I meet a kernel panic issue if I don't remove the unused widget and modify something in rt5640_dapm_widgets[] and/or rt5640_dapm_routes[].
> The message is "Unable to handle kernel paging request at virtual address 6b6b6bd3".
> PC is at dapm_clear_walk_output+0x18/0x7c
> LR is at dapm_clear_walk_output+0x18/0x7c
> If I remove those unused widget, ie. not appear in rt5640_dapm_routes[], everything is fine.
> So I think they should be removed.

The kernel panic is my fault. I introduced a memory corruption bug in the
ASoC DAPM core. It's not specific to this drivers, I'll send the fix in a
minute.

- Lars
