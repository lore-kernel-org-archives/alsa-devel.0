From: "Michel Benoit" <murpme@gmail.com>
Subject: Re: soft vol
Date: Mon, 14 May 2007 22:17:03 +0200
Message-ID: <c88e466f0705141317m1a1c2de6n663fa5d7fe36ee62@mail.gmail.com>
References: <c88e466f0705110336l5596cf8fwc434b0f071f5ee15@mail.gmail.com>
	<s5hejlnid9b.wl%tiwai@suse.de>
	<c88e466f0705140122q40509106uaa997b88a86e49c4@mail.gmail.com>
	<s5hps53hkkj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 02D1F247BC
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 22:17:04 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so1819645nzf
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2007 13:17:03 -0700 (PDT)
In-Reply-To: <s5hps53hkkj.wl%tiwai@suse.de>
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

> >
> > >From a printk in the soc driver:
> >
> > SNDRV_CTL_IOCTL_ELEM_READ is 0xc2c85512
> >
> > Is that correct?
>
> Right, it means that the struct is aligned differently on between
> user- and kernel-spaces.
>
> Could check the offset of each field, such as
>
>         printk("id = %d\n", offsetof(struct snd_ctl_elem_value, id));
>         printk("value = %d\n", offsetof(struct snd_ctl_elem_value, value));
>         printk("tstamp = %d\n", offsetof(struct snd_ctl_elem_value, tstamp));
>         printk("reserved = %d\n", offsetof(struct snd_ctl_elem_value, reserved));
>
> for both kernel and user-spaces?  I guess either it's a difference of
> pointer alignment or time_spec definition.
>
>

The output from
       printk("0x%x\n", SNDRV_CTL_IOCTL_ELEM_READ);
       printk("id = %d\n", offsetof(struct snd_ctl_elem_value, id));
       printk("value = %d\n", offsetof(struct snd_ctl_elem_value, value));
       printk("tstamp = %d\n", offsetof(struct snd_ctl_elem_value, tstamp));
       printk("reserved = %d\n", offsetof(struct snd_ctl_elem_value, reserved));

in the kernel driver is

0xc2c85512
id = 0
value = 72
tstamp = 584
reserved = 592

and in the pcm test program the ouput of
     printk("0x%x\n", SNDRV_CTL_IOCTL_ELEM_READ);
is

0xc2c45512


What is the difference?  Which version of alsa is used/expected in the kernel?
