From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/1] ALSA: add dummy function to support shared mmap in nommu Blackfin arch (v2)
Date: Tue, 2 Sep 2008 09:37:01 -0400
Message-ID: <8bd0f97a0809020637n2c7e29bexe87bd3dca50cee88@mail.gmail.com>
References: <1220349522-17995-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753090AbYIBNhS@vger.kernel.org>
In-Reply-To: <1220349522-17995-1-git-send-email-cooloney@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 2, 2008 at 5:58 AM, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>
>
> v1-v2:
>  - only adding this dummy function in nommu arch
>
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  sound/core/pcm_native.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index c49b9d9..1e88cde 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3391,6 +3391,14 @@ out:
>  }
>  #endif /* CONFIG_SND_SUPPORT_OLD_API */
>
> +#ifndef CONFIG_MMU
> +unsigned long dummy_get_unmapped_area(struct file *file, unsigned long addr,
> +                                     unsigned long len, unsigned long pgoff, unsigned long flags)
> +{
> +       return 0;
> +}
> +#endif

if you had:
#else
# define dummy_get_unmapped_area NULL
#endif
then you could avoid #ifdef in the rest of the file ...
-mike
