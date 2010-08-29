From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: problem with bisecting a bug in the alsa driver
Date: Sun, 29 Aug 2010 18:09:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008291805250.10278@eeebox2.perex-int.cz>
References: <4C7A8375.3000009@adiumentum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 65635243DE
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 18:09:32 +0200 (CEST)
In-Reply-To: <4C7A8375.3000009@adiumentum.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Martin <mwolf@adiumentum.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 29 Aug 2010, Martin wrote:

> hello,
>
> im sorry to post in here but i really dont know how to proceed
> with finding the bug i have.
>
> i have an ALC889A codec and since alsa-driver 1.0.22 my
> microphone is crackling like hell with every recording.
>
> it works flawlessly on windows and till 1.0.21 of alsa driver.


> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5115

Try to create a diff (diff -u) between the outputs from alsa-info.sh 
for working 1.0.21 and current ALSA driver.

Bisecting works only for whole kernel 2.6 tree not for the out-of-kernel 
compilation framework.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
