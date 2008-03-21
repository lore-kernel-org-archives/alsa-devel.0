From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: ALSA Debugging
Date: Fri, 21 Mar 2008 09:15:41 -0700
Message-ID: <1206116141.4863.127.camel@razman.gruemaster.com>
References: <b29ed9aa0803210815g43bd5741i81ee7e5d0a04e612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EB99103807
	for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2008 17:15:45 +0100 (CET)
In-Reply-To: <b29ed9aa0803210815g43bd5741i81ee7e5d0a04e612@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

First, verify that you are working with the correct driver.  lsmod will
tell you which sound drivers are loaded.  If this is a newer system,
you're probably using the snd-hda-intel driver, which is a whole lot
different.

Tobin
On Fri, 2008-03-21 at 20:45 +0530, Vinod Koul wrote:

> Hello,
> I am new to ALSA and Linux. I was trying to understand the ALSA
> architecture.
> 
> I have Linux Box with Intel sound card. with Suse 10.1 on it.
> I launched the audio player (Real player) and audio plays fine.
> 
> Then, I built the kernel and installed it. I put some printk's in intel8x0.cand
> control.c. (could see the my code was complied)
> Even though I changed volume muted etc couldn't see any of my printk in
> dmesg. One default printk in intel8x0.c was there, so I have put my print
> before that line as well, but couldn't see anything.
> 
> Apologies If my problem is very basic. I read on forums that best way to
> learn is to put printk's.
> 
> Can anyone help me with where I am doing incorrectly, Am I supposed to do it
> this way or some other way?
> 
> Thanks in advance
> -Vinod
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


The man on tops walks a lonely street; the "chain" of command is often a noose.
