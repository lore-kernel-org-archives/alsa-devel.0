From: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
Subject: Re: alsa 1.0.16 on kernel 2.6.23.9
Date: Thu, 17 Apr 2008 12:06:12 +0000
Message-ID: <6efe08af0804170506s171e3bb0v278a8c745ce934b0@mail.gmail.com>
References: <6efe08af0804170026v739201b7r2b2a9f21408f2f81@mail.gmail.com>
	<s5h63ugerfe.wl%tiwai@suse.de>
	<6efe08af0804170414v4fade71et7630e551324aacd0@mail.gmail.com>
	<s5hod88d7dd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 0255B249E2
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 14:06:20 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 5so25755ywr.2
	for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2008 05:06:12 -0700 (PDT)
In-Reply-To: <s5hod88d7dd.wl%tiwai@suse.de>
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

On Thu, Apr 17, 2008 at 11:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 17 Apr 2008 11:14:36 +0000,
>
> Vitaly V. Ch wrote:
>  >
>  > On Thu, Apr 17, 2008 at 9:55 AM, Takashi Iwai <tiwai@suse.de> wrote:
>  > > At Thu, 17 Apr 2008 07:26:25 +0000,
>  > >
>  > > Vitaly V. Ch wrote:
>  > >  >
>  > >  > Have anyone successfully run alsa 1.0.16 on kernel 2.6.23.9?
>  > >  >
>  > >  > after success configure and make with one warning:
>  > >  >
>  > >  > WARNING: /tmp/alsa-driver-1.0.16/misc/ac97_bus: 'ac97_bus_type'
>  > >  > exported twice. Previous export was in vmlinux
>  > >
>  > >  Do you have CONFIG_AC97_BUS=y?  This should be a module, too.
>  > Yes, I have it. I can't find in menuconfig item to switch it. Can I
>  > switch it manually by editing .config?
>
>  Yes.  But usually it's selected by other items.  So you likely made
>  dependent components all built-in (=y).  They should be also modules.
where I can see which components require to be modules also?

I don't compile OSS at all and all alsa is modules. which component
can be depend on it?

>
>
>  Takashi
>
