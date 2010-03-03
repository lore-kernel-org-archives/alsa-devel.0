From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_drop causing lockup with DMix
Date: Wed, 3 Mar 2010 11:01:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003031101170.28127@eeebox2.perex-int.cz>
References: <1267371441.14748.22.camel@satellite>
	<alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
	<1267377313.14982.0.camel@satellite>
	<alpine.LNX.2.00.1003010752570.28127@eeebox2.perex-int.cz>
	<1267487552.11621.2.camel@satellite>
	<alpine.LNX.2.00.1003021423550.28127@eeebox2.perex-int.cz>
	<1267575866.1763.1.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EDB024422
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 11:01:52 +0100 (CET)
In-Reply-To: <1267575866.1763.1.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2 Mar 2010, John Lindgren wrote:

> On Tue, 2010-03-02 at 14:25 +0100, Jaroslav Kysela wrote:
>> Could you provide a simple C program to test this issue? You may modify
>> alsa-lib/src/test/pcm_min.c for example.
>
> There is already one attached to the bug report page:
>
> https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=4914
>
> Thanks for investigating this.

This commit should solve this issue:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=b9dbee694a94a724670b36f4df1aeceb0dd4a261

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
