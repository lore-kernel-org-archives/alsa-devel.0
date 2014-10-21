From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: bug in alsa-utils 1.0.28 - arecord
Date: Tue, 21 Oct 2014 08:39:41 +0200
Message-ID: <5445FFAD.1050107@perex.cz>
References: <CAC_TXnmZcBcXSgGH6JgsjwhN9jeruo3YbEzcrbGSxb-M5Mq5oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id A7F5D26049B
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 08:39:42 +0200 (CEST)
Received: from server.perex-int.cz (server.perex-srv.cz [172.16.0.20])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8029D149E87
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 08:39:42 +0200 (CEST)
Received: from t540.localdomain (localhost [127.0.0.1])
 by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
 47639844AB
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 08:39:42 +0200 (CEST)
In-Reply-To: <CAC_TXnmZcBcXSgGH6JgsjwhN9jeruo3YbEzcrbGSxb-M5Mq5oQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 20.10.2014 v 21:33 Jordan Kagan napsal(a):
> Hello,
> 
> I encountered an issue with using the arecord binary in this most recent
> version.  When using the '-d' duration flag, the program will continue to
> open files AFTER the duration has expired.  The issue occurs when the
> capture() while loop hits the break due to a value returned by pcm_read().
> When the while loop is exited, the program hits the do-while loop and
> continues to open files indefinitely.  If rcount is returned from
> pcm_read() instead of "result", the problem does not occur.

Yes, I fixed it here:

http://git.alsa-project.org/?p=alsa-utils.git;a=commit;h=8f361d83cfcb39887f5fc591633e68d9448e3425

I'm going to release 1.0.29 soon.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
