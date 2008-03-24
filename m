From: "Vinod Koul" <vinod.koul@gmail.com>
Subject: Re: ALSA Debugging
Date: Mon, 24 Mar 2008 08:52:15 +0530
Message-ID: <b29ed9aa0803232022j12422d05h3cab9d6fe9734e9f@mail.gmail.com>
References: <b29ed9aa0803210815g43bd5741i81ee7e5d0a04e612@mail.gmail.com>
	<1206116141.4863.127.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C4642474B
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2008 04:22:23 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so668723ana.80
	for <alsa-devel@alsa-project.org>; Sun, 23 Mar 2008 20:22:15 -0700 (PDT)
In-Reply-To: <1206116141.4863.127.camel@razman.gruemaster.com>
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
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Tobin,
Checked snd-intel8x0 is loaded.

Did rmmod and tried to insert with my compiled driver from my sources gives
an error: "error inserting 'snd-intel8x0.ko' : -1 Invalid module format"

Checked from Yast, my sound card is 82801G AC'97, driver snd-intel8x0

-Vinod

On Fri, Mar 21, 2008 at 9:45 PM, Tobin Davis <tdavis@dsl-only.net> wrote:

>  First, verify that you are working with the correct driver.  lsmod will
> tell you which sound drivers are loaded.  If this is a newer system, you're
> probably using the snd-hda-intel driver, which is a whole lot different.
>
> Tobin
>
> On Fri, 2008-03-21 at 20:45 +0530, Vinod Koul wrote:
>
> Hello,I am new to ALSA and Linux. I was trying to understand the ALSAarchitecture.
> I have Linux Box with Intel sound card. with Suse 10.1 on it.I launched the audio player (Real player) and audio plays fine.
> Then, I built the kernel and installed it. I put some printk's in intel8x0.candcontrol.c. (could see the my code was complied)Even though I changed volume muted etc couldn't see any of my printk indmesg. One default printk in intel8x0.c was there, so I have put my printbefore that line as well, but couldn't see anything.
> Apologies If my problem is very basic. I read on forums that best way tolearn is to put printk's.
> Can anyone help me with where I am doing incorrectly, Am I supposed to do itthis way or some other way?
> Thanks in advance-Vinod
> _______________________________________________Alsa-devel mailing listAlsa-devel@alsa-project.orghttp://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   -- Tobin Davis
>
> The man on tops walks a lonely street; the "chain" of command is often a noose.
>
>
