From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 17:12:10 +0200
Message-ID: <7c5010d60909030812k5f865622i5cddcd978788c338@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<4A9E9CB7.8040809@ladisch.de>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
	<4A9FAD82.3050207@ladisch.de> <s5heiqoqfh4.wl%tiwai@suse.de>
	<7c5010d60909030723l44055b5au84a487d78ef6252f@mail.gmail.com>
	<s5hbplsqeye.wl%tiwai@suse.de>
	<7c5010d60909030747n55b6f48r2322aabf47f17171@mail.gmail.com>
	<7c5010d60909030803h1c354c79ob774683d764ea062@mail.gmail.com>
	<s5h4orkqd22.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 542102415D
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 17:12:11 +0200 (CEST)
Received: by fxm3 with SMTP id 3so1711246fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 08:12:11 -0700 (PDT)
In-Reply-To: <s5h4orkqd22.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 3, 2009 at 5:10 PM, Takashi Iwai<tiwai@suse.de> wrote:
>
> Then it falls back to the system timer, so it must work still.
> To be sure, set hrtimer =3D 0 instead 1 in dummy.c.
>
> If this still doesn't work, I'd recommend you to add a debug printk
> at each call of dummy_systimer_pointer(). =A0Print the returned result
> together with jiffies value.
>

I'll do it and report

-gm
