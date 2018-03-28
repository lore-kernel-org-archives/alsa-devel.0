From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] pcm_native: Remove VLA usage
Date: Thu, 29 Mar 2018 08:42:57 +0900
Message-ID: <f9720994-b65b-bbf8-334c-a6643b98c131@sakamocchi.jp>
References: <1522275840-14092-1-git-send-email-kyle@spiers.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 32492267063
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 01:43:03 +0200 (CEST)
In-Reply-To: <1522275840-14092-1-git-send-email-kyle@spiers.me>
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
To: Kyle Spiers <kyle@spiers.me>, perex@perex.cz
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, keescook@chromium.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 29 2018 07:24, Kyle Spiers wrote:
> As part of the effort to remove VLAs from the kernel[1], this changes
> the allocation of the rstamps array from being on the stack to being
> kcalloc()ed. This also allows for the removal of the explicit zeroing
> loop.
> 
> Signed-off-by: Kyle Spiers <kyle@spiers.me>
> ---
>   sound/core/pcm_native.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

This bug was already fixed at a commit 5730f9f744cf ('
ALSA: pcm: Remove VLA usage')[1][2].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/core/pcm_native.c?h=for-next&id=5730f9f744cfe20b771adc33f3b476b95d3eebba
[2] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-March/133268.html


Thanks

Takashi Sakamoto
