From: Maarten Baert <maarten-baert@hotmail.com>
Subject: Re: [PATCH] Bugfix: Fix resampling when client and
 slave both use format float
Date: Mon, 24 Feb 2014 13:13:44 +0100
Message-ID: <BLU0-SMTP25F099B950B03725BED93DE2860@phx.gbl>
References: <BLU0-SMTP134831A0E1EA4F209F321CAE2850@phx.gbl>
 <s5hwqgkyimw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s30.blu0.hotmail.com (blu0-omc3-s30.blu0.hotmail.com
 [65.55.116.105])
 by alsa0.perex.cz (Postfix) with ESMTP id F0C6426530E
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 13:13:49 +0100 (CET)
In-Reply-To: <s5hwqgkyimw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 24/02/14 10:17, Takashi Iwai wrote:
> Can S32 work instead of S16?  Then we won't lose the accuracy so much.
> Of course, handling float directly would be the best option.
The samplerate and speexrate plugins currently take S16 (see
pcm_src_convert_s16 in alsa-plugins/rate/rate_samplerate.c and
alsa-plugins/rate/rate_speexrate.c), so just using S32 will not improve
the accuracy. It would be easy to replace those functions with
pcm_src_convert_float (both resampler libraries have functions that take
float directly), but that will break the plugin ABI. Is that acceptable?
The same would have to be done for the channel remapping (route
conversion) plugin.

> In anyway, could you give your acked-by tag?
Sorry, I don't know what you mean - this is the first time I've
submitted a patch here.

Maarten Baert
