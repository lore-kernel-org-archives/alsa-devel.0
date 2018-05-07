From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 5/9] ALSA: hda/ca0132: add/change helper functions for
 R3Di and SBZ
Date: Mon, 7 May 2018 11:29:38 +0900
Message-ID: <9918d3d1-d843-6142-ca95-91ee0bde3d6b@sakamocchi.jp>
References: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
 <1525547001-17588-6-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525547001-17588-6-git-send-email-conmanx360@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@lse.epita.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 6 2018 04:03, Connor McAdams wrote:
> Edit core functions to support the Sound Blaster Z and Recon3Di for
> startup and loading of the DSP, as well as setting effects.
> 
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>   sound/pci/hda/patch_ca0132.c | 1064 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 1018 insertions(+), 46 deletions(-)

In my opinion, this patch is too large. This patch can be split into
several parts:

  * Changes for signature of 'dspio_scp()' to get 'src_id'
   * dspio_scp()
   * dspio_set_param()
   * dspio_set_uint_param()
   * dspio_alloc_dma_chan()
   * dspio_free_dma_chan()
  * Changes for SBZ only
  * Changes for R3Di only

Could you please prepare for these three patches from this large patch 
in your next chance? Especially, you can describe enough information to 
the latter two patches as patch comment.


Thanks

Takashi Sakamoto
