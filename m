From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: firewire-digi00x: Drop bogus const
 type qualifier on dot_scrt()
Date: Mon, 8 Feb 2016 20:22:00 +0900
Message-ID: <56B87A58.6090304@sakamocchi.jp>
References: <1454854455-20894-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EFE32605C1
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 12:22:05 +0100 (CET)
In-Reply-To: <1454854455-20894-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Takashi Iwai <tiwai@suse.com>
Cc: Damien Zammit <damien@zamaudio.com>, alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Feb 7 2016 23:14, Geert Uytterhoeven wrote:
> sound/firewire/digi00x/amdtp-dot.c:67: warning: type qualifiers ignored on function return type
> 
> Drop the bogus "const" type qualifier on the return type of dot_scrt()
> to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Yep. It came from original code[1] and I overlooked.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> ---
>  sound/firewire/digi00x/amdtp-dot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
> index b02a5e8cad448c40..0ac92aba5bc1c9a4 100644
> --- a/sound/firewire/digi00x/amdtp-dot.c
> +++ b/sound/firewire/digi00x/amdtp-dot.c
> @@ -63,7 +63,7 @@ struct amdtp_dot {
>  #define BYTE_PER_SAMPLE (4)
>  #define MAGIC_DOT_BYTE (2)
>  #define MAGIC_BYTE_OFF(x) (((x) * BYTE_PER_SAMPLE) + MAGIC_DOT_BYTE)
> -static const u8 dot_scrt(const u8 idx, const unsigned int off)
> +static u8 dot_scrt(const u8 idx, const unsigned int off)
>  {
>  	/*
>  	 * the length of the added pattern only depends on the lower nibble

Thanks

[1] https://github.com/x42/003amdtp


Takashi Sakamoto
