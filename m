From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Help needed
Date: Wed, 14 Apr 2010 08:18:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004140814260.16336@eeebox2.perex-int.cz>
References: <u2oea05c7011004130706jc7b4a043zd1969eedb92f5069@mail.gmail.com>
	<x2yea05c7011004130717z5fbce05dqfa7852fb10f115d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4272F243A9
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 08:18:08 +0200 (CEST)
In-Reply-To: <x2yea05c7011004130717z5fbce05dqfa7852fb10f115d8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Akhilesh Soni <akhilrekha@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 13 Apr 2010, Akhilesh Soni wrote:

> Hi,
>
> I'm using Osprey-440 4 channel Capture card in Centos 5.4 distribution with
> kernel 2.6.18-164.15.1.el5 #1 SMP Wed Mar 17 11:30:06 EDT 2010 x86_64 x86_64
> x86_64 GNU/Linux
>
> I'm able to load the bttv driver for video capture and it created
> /dev/video0 /dev/video1 /dev/video2 /dev/video3 devices which I'm able to
> capture as well.
>
> But when I do modprobe snd-bt87x i'm unable to get the audio capture devices
> either /dev/audio or /dev/dsp
>
> Is there any parameters to be given in inserting this module for the card.
> Please guide me to resolve this issue.

Is something related in /var/log/messages ?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
