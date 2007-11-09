From: Timur Tabi <timur@freescale.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 09 Nov 2007 14:16:54 -0600
Message-ID: <4734C036.3060301@freescale.com>
References: <472E5A64.6010705@aknet.ru> <4732097E.3040401@aknet.ru>	
	<s5htznx9znk.wl%tiwai@suse.de> <4732C455.7040503@aknet.ru>	
	<s5hd4ulthy3.wl%tiwai@suse.de>
	<473488CA.7050308@freescale.com>	 <4734A448.7000909@aknet.ru>
	<4734BA93.6040900@freescale.com>	 <4734BC5F.8040800@aknet.ru>
	<4734BDD1.9080103@freescale.com>
	<75b66ecd0711091211o9e1297em391d7091c5d51931@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id D9F5C243FD
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 21:17:29 +0100 (CET)
In-Reply-To: <75b66ecd0711091211o9e1297em391d7091c5d51931@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

> Did you install all of libasound properly including the config files
> in /usr/share/alsa?

Beats me.  I have a /usr/share/alsa that has this:

-rw-r--r--  1 root root 8611 Sep 28  2007 alsa.conf
drwxr-xr-x  3 root root 4096 Sep 28  2007 cards
drwxr-xr-x  2 root root 4096 Sep 28  2007 pcm
-rw-r--r--  1 root root  132 Sep 28  2007 smixer.conf
-rw-r--r--  1 root root 3205 Sep 28  2007 sndo-mixer.alisp

But I've never mucked with anything in here.  I didn't create the file system 
I'm using, so I don't know how it was made.  How would I know if I'm missing 
something?

> How are you testing?

mplayer -v -ao oss Cars480_1\[1\].5M.divx

This movie has audio encoded at 44100KHz, and that's what causes the underrun 
problem.  I've been following this thread, but I'm still not sure what the 
solution is, if any.

-- 
Timur Tabi
Linux kernel developer at Freescale
