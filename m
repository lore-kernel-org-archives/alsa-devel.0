From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [PATCH] sound,
 hda_eld: suspicious sizeof() in call to snd_print_pcm_bits()
Date: Sat, 29 Jan 2011 18:46:33 +0800
Message-ID: <20110129104633.GA12643@localhost>
References: <alpine.LNX.2.00.1101290132560.6465@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 89774103803
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2011 11:46:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101290132560.6465@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 29, 2011 at 01:40:04AM +0100, Jesper Juhl wrote:

>  	if (a->format == AUDIO_CODING_TYPE_LPCM)
> -		snd_print_pcm_bits(a->sample_bits, buf2 + 8, sizeof(buf2 - 8));
> +		snd_print_pcm_bits(a->sample_bits, buf2 + 8, sizeof(buf2) - 8);

Good catch!

Reviewed-by: Wu Fengguang <fengguang.wu@intel.com>
