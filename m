From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: control: Fix breakage of user ctl
	element addition
Date: Fri, 13 Mar 2015 09:37:15 +0900
Message-ID: <5502313B.5030409@sakamocchi.jp>
References: <1426176130-1163-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BFFD2658D8
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 01:37:20 +0100 (CET)
In-Reply-To: <1426176130-1163-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mar 13 2015 01:02, Takashi Iwai wrote:
> In the commit [2225e79b9b03: 'ALSA: core: reduce stack usage related
> to snd_ctl_new()'], the id field of the newly added kctl is untouched,
> thus all attribute like name string remain empty.  The fix is just to
> add the forgotten memcpy of the id field.
> 
> Fixes: 2225e79b9b03 ('ALSA: core: reduce stack usage related to snd_ctl_new()')
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/control.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 54a412af3224..d677c27746e9 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1267,6 +1267,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>  	err = snd_ctl_new(&kctl, count, access, file);
>  	if (err < 0)
>  		return err;
> +	memcpy(&kctl->id, &info->id, sizeof(kctl->id));
>  	kctl->private_data = kzalloc(sizeof(struct user_element) + private_size,
>  				     GFP_KERNEL);
>  	if (kctl->private_data == NULL) {

Oops, exactly... Thanks.

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I think the line can be simpler, like:

kctl->id = info->id;

But in both cases, assembler code may be the same due to compiler
optimization.


Takashi Sakamoto
