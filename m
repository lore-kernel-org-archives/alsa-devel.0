From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: How do I get this patch?
Date: Thu, 1 Aug 2013 11:57:09 +0200
Message-ID: <CACQ1gAiuND+Mg34MOt4ajUWmFpbFm4v+OOXqxwQWpprnveVHFQ@mail.gmail.com>
References: <loom.20130801T032024-741@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AA4D32616CB
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 11:57:30 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id h1so942121oag.10
 for <alsa-devel@alsa-project.org>; Thu, 01 Aug 2013 02:57:29 -0700 (PDT)
In-Reply-To: <loom.20130801T032024-741@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Winger Nyman <christianwn@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2013/8/1 Christian Winger Nyman <christianwn@gmail.com>:
> I have the VB-99, so this patch would be fantastic. But I don't understand,
> will it be implemented in the Linux 3.10 kernel or what would be the easiest
> way for me to get it? I run Ubuntu Studio 13.04. Thanks for any guidance.
>
> http://comments.gmane.org/gmane.linux.alsa.devel/109660

The 3.10 is already out since some weeks now.
The patch you're interested in has been included in 3.11-rc1:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=aafe77cc45a595ca1d4536f2412ddf671ea9108c

you can check it via:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git tag --contains aafe77cc45a595ca1d4536f2412ddf671ea9108c

So, 3 solutions for you :
- either you or the ubuntu kernel team will backport this patch to the
kernel used in ubuntu 13.04
- you wait for ubuntu 13.10
- you compile the 3.11-rc3 to use on your distro. (it maybe unstable
for now. The 3.11 will be out in september)
the last one may not be easy since ubuntu studio has the prempt-rt patch.
But maybe there's some 3rd party packages that contains the very last
kernel for ubuntu studio. You may have an answer to that on an ubuntu
ML.

Richard.
