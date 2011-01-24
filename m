From: George Morgan <gm.swdev@gmail.com>
Subject: Re: Bug 0002542
Date: Mon, 24 Jan 2011 16:04:51 -0500
Message-ID: <AANLkTikcu6gfnztGgeASQ=nS4ts4jfyRLfyBzqxn2WRC@mail.gmail.com>
References: <AANLkTina57s0fxMtGriV+5-BH9XsJcT4Z_cGvsF44UHF@mail.gmail.com>
	<alpine.LNX.2.00.1101242124160.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 17410103848
	for <Alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 22:04:54 +0100 (CET)
Received: by bwz10 with SMTP id 10so4050345bwz.38
	for <Alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 13:04:53 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101242124160.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 24, 2011 at 3:25 PM, Jaroslav Kysela <perex@perex.cz> wrote:

> On Mon, 24 Jan 2011, George Morgan wrote:
>
>  Looking at the notes for Bug 0002542 (as a guest) it looks like there is
>> an
>> issue in the file:
>>
>> alsa-oss-1.0.17/alsa/aoss.in
>>
>> I think line 10 should be:
>>
>>  LD_PRELOAD=@libdir@/libaoss.so${LD_PRELOAD:+:LD_PRELOAD} exec "$@"
>>
>> instead of:
>>
>>  LD_PRELOAD=${exec_prefix}/\$LIB/libaoss.so${LD_PRELOAD:+:LD_PRELOAD} exec
>> "$@"
>>
>> Let me know if I need to create an account in bugtrack and submit a patch.
>>
>
> See this:
>
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1390
>
> and this..
>
>
> http://git.alsa-project.org/?p=alsa-oss.git;a=commitdiff;h=9916731b29f07a52451d9d663a7d365ead8e9dfe
>
>                                        Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
> Ok, the "fix" in git.alsa-project.org link above for "alsa/aoss.in"
actually breaks aoss.in...  The old line [-] works correctly.  The new line
[+] appears to be wrong.  I had to look at it twice to notice.  The other
changes in that diff look ok as far as I can tell.  The line that I quoted
is from the latest stable source tarball on the alsa-project.org website
(1.0.17).

George Morgan
