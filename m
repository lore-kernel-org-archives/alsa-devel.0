From: Paulo Cavalcanti <promac@gmail.com>
Subject: Re: Cannot record from front pluggable mic on 82801H
	(ICH8 Family) sound card
Date: Mon, 26 Jan 2009 00:05:30 -0200
Message-ID: <68720af30901251805h5c74262emb6a35ef70a94d208@mail.gmail.com>
References: <ef2423ab0901090857l1b592e34yd340f69c5c65fb92@mail.gmail.com>
	<200901181756.52285.cave.dnb2m97pp@aliceadsl.fr>
	<ef2423ab0901250609m62020357u57a2636f102ae1f0@mail.gmail.com>
	<200901251737.10497.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 59A3A1037EE
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2009 03:05:31 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so5414934rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2009 18:05:30 -0800 (PST)
In-Reply-To: <200901251737.10497.cave.dnb2m97pp@aliceadsl.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Vincent <zakora@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 25, 2009 at 2:37 PM, Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>wrote:

> On Sunday 25 January 2009 15:09, Vincent wrote:
> > I tried everything you said, but the problem remains. I tried to put a
> > reference board in modprobe.conf but I get no output sound, sounds weird
> > because on the archwiki page of the Dell
> > 1525<http://wiki.archlinux.org/index.php/Dell_Inspiron_1525>there is
> > the 3stack option...
> > I attached the alsa-info.txt (with the 3stack option enabled). The
> > alsa-info.sh generated an alsainfo folder, should I attached it?
> >
> > Thanks,
> > Vincent
>
> Hi Vincent.
>
> It looks like your updates have updated the kernel to 2.6.28 since you
> installed the snapshot of the alsa driver, as your alsa-info.sh output
> shows
> alsa driver 1.0.18rc3. You will have to upgrade the alsa driver again for
> the
> new kernel. Alsa driver 1.0.19 is now available from the link below, so try
> that.
> http://alsa-project.org/main/index.php/Main_Page
>
> You'll also need to run the alsa-info.sh script again, so that it shows the
> info retrieved when using alsa driver 1.0.19. You only need attach the
> alsa-info.txt file, not the alsainfo folder.
>
> I must admit to being out of my depth with your problem with the front mic.
> It's no doubt worth trying the various model options again, once you've
> installed the 1.0.19 alsa driver against the 2.6.28 kernel.
>
> Perhaps Takashi may have a suggestion to resolve your problem.
>
> All the best.
>
>

He is using the same driver as me:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-December/013570.html

Mic will not work, even with 1.0.19.

Sorry ...

-- 
Paulo Roma Cavalcanti
LCG - UFRJ
