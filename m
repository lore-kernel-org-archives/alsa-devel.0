From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: developing audio with ALSA
Date: Mon, 18 Aug 2008 10:57:12 +0100
Message-ID: <200808181057.12078.gineera@aspect135.co.uk>
References: <000e01c90112$e89e7e30$ba3ea8c0@Richwave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-4.talktalk.net [62.24.128.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 180E92440A
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 11:55:36 +0200 (CEST)
In-Reply-To: <000e01c90112$e89e7e30$ba3ea8c0@Richwave.net>
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
To: Henry Ho <yjho@richwave.com.tw>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 18 August 2008 10:15, Henry Ho wrote:
> Hi
>
> After reading the cross-compilation instruction in INSTALL file,
> I already successfully configured the alsa-lib-2.0.17. I also
> successfully made the library. Adding --prefix=xxx during
> configuration can set the output directory to xxx.
>
> I also modify my Makefile for application, including the search
> path of libasound.so.2.***. Now I can successfully make it.
>
> However, when I run my application on the target, I got the following
> error message:
>
> ***************************************************************************
>*************** ./pcm: error while loading shared libraries: libasound.so.2:
> cannot open shared object file: No such file or directory
> ***************************************************************************
>***************
>
> I have put libasound.so.2.0.0 in /tmp of the target. I also modified
> /etc/ld.so.conf, adding /tmp in ld.so.conf file. However, I cannot
> find ldconfig on the target. Is anyone can tell me how to solve it?
> Should I rebuild a busybox with this command?

(I'm no expert); is there a link on the target from libasound.so.2 > 
libasound.so.2.0.0 ?  That should be needed to find the actual version you 
have.

Alan
