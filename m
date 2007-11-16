From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: alsa-lib module path question
Date: Thu, 15 Nov 2007 22:30:04 -0500
Message-ID: <75b66ecd0711151930w4992910bi617861a21eeb12c8@mail.gmail.com>
References: <674790.40730.qm@web36512.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id C1F9F103841
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 04:30:06 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1027254wag
	for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2007 19:30:04 -0800 (PST)
In-Reply-To: <674790.40730.qm@web36512.mail.mud.yahoo.com>
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
To: Ben C <bchang_2@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 15, 2007 3:14 PM, Ben C <bchang_2@yahoo.com> wrote:
> Hello,
>
> I've written an ALSA external PCM plugin for a client's embedded device. During the client's compilation of alsa-lib (which I have no control over), they did not specify where the module directory should be at. In fact, they're using 1.0.13 where there isn't a configure option to specify the module directory  (this was added 1.0.14?). Since this is an embedded project, due to cross compilation, alsa-lib is currently looking at some host directory that does not exist on the target to search for the libasound_module_pcm_xxx.so files. What's worse is that seems like it is dependent on where the client decides to build the RFS (say from /home/joe/project/xxx, but then later /home/bill/project/yyy) -- the alsa-lib module directory could change.

Please search the list archives for "cross compiling" - I had the
exact same problem last year.  Don't remember exactly how I solved it,
but it's in there somewhere.

Lee
