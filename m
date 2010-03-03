From: John Lindgren <john.lindgren@tds.net>
Subject: Re: snd_pcm_drop causing lockup with DMix
Date: Tue, 02 Mar 2010 19:24:26 -0500
Message-ID: <1267575866.1763.1.camel@satellite>
References: <1267371441.14748.22.camel@satellite>
	<alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
	<1267377313.14982.0.camel@satellite>
	<alpine.LNX.2.00.1003010752570.28127@eeebox2.perex-int.cz>
	<1267487552.11621.2.camel@satellite>
	<alpine.LNX.2.00.1003021423550.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 940002450A
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 01:24:31 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 9so160335qwj.56
	for <alsa-devel@alsa-project.org>; Tue, 02 Mar 2010 16:24:29 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1003021423550.28127@eeebox2.perex-int.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-03-02 at 14:25 +0100, Jaroslav Kysela wrote:
> Could you provide a simple C program to test this issue? You may modify 
> alsa-lib/src/test/pcm_min.c for example.

There is already one attached to the bug report page:

https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=4914

Thanks for investigating this.

John Lindgren
