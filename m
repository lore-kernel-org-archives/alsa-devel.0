From: "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
Subject: Re:
 =?utf-8?q?=5BPATCH=5D=5Bnext=5D_ALSA=3A_firewire-lib?=
 =?utf-8?q?=3A_remove_redundant=09assignment_to_cip=5Fheader?=
Date: Sat, 25 May 2019 14:45:57 +0900
Message-ID: <9fe864d1-db6c-4b72-bfa3-3a1c638f1fae@www.fastmail.com>
References: <20190524213351.24594-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AC46F80C0F
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2019 07:46:00 +0200 (CEST)
In-Reply-To: <20190524213351.24594-1-colin.king@canonical.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Colin King <colin.king@canonical.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Colin,

On Sat, May 25, 2019, at 06:35, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The assignement to cip_header is redundant as the value never
> read and it is being re-assigned in the if and else paths of
> the following if statement. Clean up the code by removing it.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/firewire/amdtp-stream.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/firewire/amdtp-stream.c 
> b/sound/firewire/amdtp-stream.c
> index 2d9c764061d1..4236955bbf57 100644
> --- a/sound/firewire/amdtp-stream.c
> +++ b/sound/firewire/amdtp-stream.c
> @@ -675,7 +675,6 @@ static int handle_in_packet(struct amdtp_stream *s, 
> unsigned int cycle,
>  		return -EIO;
>  	}
>  
> -	cip_header = ctx_header + 2;
>  	if (!(s->flags & CIP_NO_HEADER)) {
>  		cip_header = &ctx_header[2];
>  		err = check_cip_header(s, cip_header, payload_length,

Thanks for the fix. I've already posted further patch for refactoring
and this was also fixed by a commit 98e3e43b599d ("
ALSA: firewire-lib: refactoring to obsolete IR packet handler").

https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=98e3e43b599d742c104864c6772a251025ffb52b

Thanks


Takashi Sakamoto
