From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/7] ALSA: pcm: Add snd_interval_ranges()
 and snd_pcm_hw_constraint_ranges()
Date: Mon, 26 Jan 2015 23:10:43 +0100
Message-ID: <54C6BB63.60809@metafoo.de>
References: <1421236370-19826-1-git-send-email-peda@lysator.liu.se>
 <1421236370-19826-2-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-161.synserver.de
 [212.40.185.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FBE02604A1
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 23:10:45 +0100 (CET)
In-Reply-To: <1421236370-19826-2-git-send-email-peda@lysator.liu.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@lysator.liu.se>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 01/14/2015 12:52 PM, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
>
> Add helper functions to allow drivers to specify several disjoint
> ranges for a variable. In particular, there is a codec (PCM512x) that
> has a hole in its supported range of rates, due to PLL and divider
> restrictions.

Might be worth mentioning that this is the extension of 
snd_pcm_hw_constraint_list() from points to ranges. Otherwise looks good.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
