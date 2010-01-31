From: Jaroslav Kysela <perex@perex.cz>
Subject: Re:
	=?utf-8?q?Warning/error_from_ALSA=E2=80=99s_pcm=5Fmi?=
	=?utf-8?q?n=2Ec_example=2E_Possible_problem=3F?=
Date: Sun, 31 Jan 2010 09:46:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001310944330.25340@eeebox2.perex-int.cz>
References: <30c82f5f1001301151r6de4761fh9453829c1af85e15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E029024553
	for <alsa-devel@alsa-project.org>; Sun, 31 Jan 2010 09:46:11 +0100 (CET)
In-Reply-To: <30c82f5f1001301151r6de4761fh9453829c1af85e15@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Louise Hoffman <louise.hoffman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 30 Jan 2010, Louise Hoffman wrote:

> Dear ALSA developers,
>
> When I compile ALSA's pcm_min.c[0] example with
>
> gcc -Wall -lasound pcm_min.c -o pcm_min
>
> Everything is fine, but running it, I get the white noise as expected,
> but I also get this warning/error:
>
> Short write (expected 16384, wrote 7616)

It was a bug in alsa-lib. I fixed it in patch bellow. Thank you for your 
report.

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=2e48439ad93f6c8d99a2d72928ac71285b5211bb

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
