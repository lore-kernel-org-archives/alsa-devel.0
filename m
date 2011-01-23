From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] pcm: fix typo in snd_pcm_recover() error
	message
Date: Sun, 23 Jan 2011 14:30:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101231430001.6272@eeebox2.perex-int.cz>
References: <4d3a329e.122ae30a.47a3.45d7@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CE9B243FA
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 14:30:26 +0100 (CET)
In-Reply-To: <4d3a329e.122ae30a.47a3.45d7@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 22 Jan 2011, cosoleto@gmail.com wrote:

>                 if (!silent)
> -                        SNDERR("%s occured", s);
> +                        SNDERR("%s occurred", s);

Applied, thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
