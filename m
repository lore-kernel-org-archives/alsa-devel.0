From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: RFC: snd_card_create() function
Date: Mon, 12 Jan 2009 14:42:06 +0000
Message-ID: <ad2655cb0901120642h542f2a5s9f3e9bb05e6e176c@mail.gmail.com>
References: <s5h63kkd23c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id DFAC71037EF
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 15:42:06 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so4091933fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 06:42:06 -0800 (PST)
In-Reply-To: <s5h63kkd23c.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sounds good to me.
One can keep the wrapper outside of the kernel, and only available in
alsa-driver for those out of tree people.

Kind Regards

James




2009/1/12 Takashi Iwai <tiwai@suse.de>:
> Hi,
>
> so far, we use snd_card_new() function to create a card instance.
> A known problem regarding this API is that it doesn't return a proper
> error code, thus the probe callback always returns -ENOMEM (or
> whatever the driver defines) no matter which error occurred actually.
> A typical case is the card slot conflict.  Even in such a case, it
> returns -ENOMEM, which may mislead the user.
>
> For fixing this situation, I'd like to convert from snd_card_new() to
> a new function, snd_card_create():
>
> int snd_card_create(int idx, const char *id,
>                    struct module *module, int extra_size,
>                    struct snd_card **card_ret);
>
> and provides snd_card_new() as a wrapper with deprecated flag:
>
> static inline __deprecated
> struct snd_card *snd_card_new(int idx, const char *id,
>                              struct module *module, int extra_size)
> {
>        struct snd_card *card;
>        if (snd_card_create(idx, id, module, extra_size, &card) < 0)
>                return NULL;
>        return card;
> }
>
> The merit of creating a new function is that the older and out-of-tree
> codes (like xfi) work without modification.  There is alternative
> option, namely to use PTR_ERR() and keep the function as is.
> But this has no advantage in practice -- it can't detect the old API
> at build time, and it may Oops.
>
> The preliminary patches are found in test/snd_card_new-err branch
> of sound git tree:
>  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git test/snd_card_new-err
>
> If anyone finds problems with this, please let me know.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
