From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-utils: fix wrong alias for signal.h
Date: Tue, 23 Jul 2013 14:59:48 +0200
Message-ID: <51EE7E44.2060009@perex.cz>
References: <51EDE322.8040407@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 23C93264F3F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 14:59:49 +0200 (CEST)
In-Reply-To: <51EDE322.8040407@barfooze.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Spencer <maillist-alsa@barfooze.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 23.7.2013 03:57, John Spencer wrote:
> in POSIX, there is no <sys/signal.h>.
> 
> it's merely a legacy alias used by glibc, and the header does nothing 
> else than including <signal.h>.
> 
> so let's do the right thing and use the right name, which works everywhere.
> 
> Signed-Off-By: John Spencer <maillist-alsa@barfooze.de>

I applied this patch to our git repo. Thanks.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
