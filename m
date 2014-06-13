From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA 1.0.28 release - request for testing
Date: Fri, 13 Jun 2014 12:52:36 +0200
Message-ID: <539AD7F4.7070302@canonical.com>
References: <1402647348-25604-1-git-send-email-david.henningsson@canonical.com>	<539AB5C7.6020501@perex.cz>	<539ABEF0.7020508@canonical.com>
 <s5hfvj9go7w.wl%tiwai@suse.de> <539AC54C.60504@canonical.com>
 <539ACD9A.5040209@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B182261A3D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 12:52:34 +0200 (CEST)
In-Reply-To: <539ACD9A.5040209@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org



On 2014-06-13 12:08, Jaroslav Kysela wrote:
> Hello all,
>
>    ALSA 1.0.28 packages are available for testing at
>
> ftp://ftp.alsa-project.org/pub/testing/
>
>    Please, report any issues. I expect to announce the release on Monday.

Thanks!

I'm testing build of alsa-lib now and I have two questions:

1) the final so version seems to be libasound.so.2.0.0 for both 1.0.27 
and 1.0.28. I'm not sure how important it is, but shouldn't this be 
increased to 2.0.1 or 2.1.0 to reflect code changes?

2) This probably is not a new issue, but I was wondering about all the 
extra files created in configure.ac, e g ctl_symbols_list.c. Are they 
ever cleaned by some "clean", "maintainerclean" or similar rule?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
