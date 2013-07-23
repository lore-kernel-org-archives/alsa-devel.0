From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-lib 1.0.27 incorrect definition of
	__kernel_off_t?
Date: Tue, 23 Jul 2013 14:55:43 +0200
Message-ID: <51EE7D4F.6040204@perex.cz>
References: <CABF+-6UXCFt5Oq0yiOkrfiN3kxWtae8zbOkqrdTFmDMm3h07Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id F2519264E9F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 14:55:46 +0200 (CEST)
In-Reply-To: <CABF+-6UXCFt5Oq0yiOkrfiN3kxWtae8zbOkqrdTFmDMm3h07Pw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kevin Groeneveld <kgroeneveld@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 22.7.2013 23:22, Kevin Groeneveld wrote:
> I tried doing a cross compile of alsa-lib 1.0.27.2 today and ended up with
> the following error:
> 
> error: conflicting types for 'off_t'
> 
> Commit 9b5beef1 adds the following line to local.h:
> 
> #define __kernel_off_t        off_t
> 
> Not only is __kernel_off_t already defined elsewhere in my header files,
> the above line tries to define __kernel_off_t (which I think should be 32
> bit on my platform) to off_t which is 64 bit.
> 
> I just deleted the line and everything seems to be working so far.

I tried to fix this issue using <linux/types.h>. Please, check:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=b3b53a1bec47aaa2baef724cc9e79adadd603caf

					Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
