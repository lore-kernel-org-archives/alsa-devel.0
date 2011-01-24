From: George Morgan <gm.swdev@gmail.com>
Subject: Re: Bug 0002542
Date: Mon, 24 Jan 2011 15:55:23 -0500
Message-ID: <AANLkTim+M2Dqc9q_qnOvZbpYNbVyk-aw5Jqs+j2c6cfb@mail.gmail.com>
References: <AANLkTina57s0fxMtGriV+5-BH9XsJcT4Z_cGvsF44UHF@mail.gmail.com>
	<alpine.LNX.2.00.1101242124160.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7296810384B
	for <Alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 21:55:24 +0100 (CET)
Received: by bwz10 with SMTP id 10so4041425bwz.38
	for <Alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 12:55:24 -0800 (PST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: Alsa-devel@alsa-project.org
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
>
Yes that is the bug that actually talks about what I was trying to fix.  The
bug I mentioned is affected by the bug you mentioned.

Incidentally https://bugtrack.alsa-project.org/ has an expired security
certificate...firefox says: "The certificate expired on 7/19/2009 6:18 AM"

George Morgan
