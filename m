From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] ALSA: echoaudio: Fix memory allocation
Date: Tue, 28 Jun 2016 09:13:25 +0200
Message-ID: <57722395.8080706@bfs.de>
References: <1467054411-19752-1-git-send-email-christophe.jaillet@wanadoo.fr>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1467054411-19752-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 27.06.2016 21:06, schrieb Christophe JAILLET:
> 'commpage_bak' is allocated with 'sizeof(struct echoaudio)' bytes.
> We then copy 'sizeof(struct comm_page)' bytes in it.
> On my system, smatch complains because one is 2960 and the other is 3072.
> 
> This would result in memory corruption or a oops.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  sound/pci/echoaudio/echoaudio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
> index 1cb85ae..286f5e3 100644
> --- a/sound/pci/echoaudio/echoaudio.c
> +++ b/sound/pci/echoaudio/echoaudio.c
> @@ -2200,11 +2200,11 @@ static int snd_echo_resume(struct device *dev)
>  	u32 pipe_alloc_mask;
>  	int err;
>  
> -	commpage_bak = kmalloc(sizeof(struct echoaudio), GFP_KERNEL);
> +	commpage_bak = kmalloc(sizeof(*commpage), GFP_KERNEL);
>  	if (commpage_bak == NULL)
>  		return -ENOMEM;
>  	commpage = chip->comm_page;
> -	memcpy(commpage_bak, commpage, sizeof(struct comm_page));
> +	memcpy(commpage_bak, commpage, sizeof(*commpage));
>  
>  	err = init_hw(chip, chip->pci->device, chip->pci->subsystem_device);
>  	if (err < 0) {

perhaps you can use here kmemdup() ?

re,
 wh
