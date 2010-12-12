From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Unknown symbol" with alsa snapshot (tiwai)
Date: Sun, 12 Dec 2010 22:24:51 +0800
Message-ID: <AANLkTim4MW+A-dqTRzb2b9-rWXca_pWQvzwWHadxbNSp@mail.gmail.com>
References: <AANLkTi=iV42FJTD6bC6cy3P=p6YgTNTnPLyrQ3NKFL-2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by alsa0.perex.cz (Postfix) with ESMTP id F346624493
	for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2010 15:24:51 +0100 (CET)
Received: by ewy1 with SMTP id 1so3451286ewy.29
	for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2010 06:24:51 -0800 (PST)
In-Reply-To: <AANLkTi=iV42FJTD6bC6cy3P=p6YgTNTnPLyrQ3NKFL-2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/12/11 Simos Xenitellis <simos.lists@googlemail.com>

> Hi,
>
> I am trying out the latest snapshot of Alsa with Ubuntu 10.10.
> It compiles without errors. However, when the modules are to be loaded,
> there are Unknown symbol errors:
>
> [ 332.243113] snd: Unknown symbol unregister_sound_special (err 0)
> [ 332.243379] snd: Unknown symbol register_sound_special_device (err 0)
> [ 332.245467] snd_timer: Unknown symbol snd_info_register (err 0)
> [ 332.245631] snd_timer: Unknown symbol snd_info_create_module_entry (err
> 0)
> [ 332.245839] snd_timer: Unknown symbol snd_info_free_entry (err 0)
> [ 332.246210] snd_timer: Unknown symbol __snd_printk (err 0)
> [ 332.246373] snd_timer: Unknown symbol snd_iprintf (err 0)
> [ 332.246607] snd_timer: Unknown symbol snd_ecards_limit (err 0)
> [ 332.246834] snd_timer: Unknown symbol snd_oss_info_register (err 0)
> [ 332.246997] snd_timer: Unknown symbol snd_unregister_device (err 0)
> [ 332.247224] snd_timer: Unknown symbol snd_device_new (err 0)
> [ 332.247625] snd_timer: Unknown symbol snd_register_device_for_dev (err 0)
>
> Is this a module loading order issue? Has there been a change in the
> latest kernel
> that causes the problem?
>

Because they have disabled OSS emulation

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/579300
