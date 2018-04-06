From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Procedure for alsa modules compilation from git
Date: Fri, 6 Apr 2018 20:33:49 +0200
Message-ID: <fe243517-c3ed-dd66-c339-8843be7ee038@perex.cz>
References: <c5de487e-3d99-e7d9-7640-cf1781748075@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id EEF89266BBC
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 20:33:51 +0200 (CEST)
In-Reply-To: <c5de487e-3d99-e7d9-7640-cf1781748075@ivitera.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 6.4.2018 v 20:07 Pavel Hofman napsal(a):
> Hi,
> 
> May I ask for description/link describing current working compilation of 
> alsa modules from git? I would like to compile only alsa modules, 
> against my stock ubuntu kernel. Headers/sources in /usr/src, configured 
> to current configuration from /boot/config...
> 
> What is the oldest kernel to compile against (isch)? Would 4.4 work?
> 
> I would like to make a small patch for ice1724, test, and send here for 
> review/inclusion.
> 
> I very much appreciate any help. I think it would be useful to many 
> other occasional devels.

The info is unfortunately obsolete, because the demand for this type of
the compilation is really low. For simple changes, you may use the code
from your kernel and write own Makefile for the external module build
(copy obj parts from the ALSA makefiles) like:

--
obj-m += test.o

all:
    make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
--

For complex changes, use the whole git tree.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
