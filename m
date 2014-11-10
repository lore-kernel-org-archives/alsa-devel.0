From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/4] ALSA: mixart: Fix kerneldoc comments
Date: Mon, 10 Nov 2014 18:00:28 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1411101758540.18642@pmeerw.net>
References: <1415637155-20918-1-git-send-email-tiwai@suse.de>
 <1415637155-20918-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E8A426646F
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 18:00:28 +0100 (CET)
In-Reply-To: <1415637155-20918-4-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/mixart/mixart_hwdep.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/pci/mixart/mixart_hwdep.c b/sound/pci/mixart/mixart_hwdep.c
> index 581e1e74863c..9996a4dead0f 100644
> --- a/sound/pci/mixart/mixart_hwdep.c
> +++ b/sound/pci/mixart/mixart_hwdep.c
> @@ -37,10 +37,11 @@
>  /**
>   * wait for a value on a peudo register, exit with a timeout
>   *
> - * @param mgr pointer to miXart manager structure
> - * @param offset unsigned pseudo_register base + offset of value
> - * @param value value
> - * @param timeout timeout in centisenconds
> + * @mgr: pointer to miXart manager structure
> + * @offset: unsigned pseudo_register base + offset of value
> + * @is_egal: wait for the equal value
> + * @value: value
> + * @timeout: timeout in centisenconds
>   */
>  static int mixart_wait_nice_for_register_value(struct mixart_mgr *mgr,
>  					       u32 offset, int is_egal,

centiseconds

looks like is_egal should be named is_equal?

-- 

Peter Meerwald
+43-664-2444418 (mobile)
