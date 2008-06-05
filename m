From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: timer + snd_pcm_period_elapsed
Date: Thu, 5 Jun 2008 15:14:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806051513300.1798@tm8103-a.perex-int.cz>
References: <827ad74d0806050313t471ab0b2n5856db7bf8db55e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 77C9124612
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 15:14:47 +0200 (CEST)
In-Reply-To: <827ad74d0806050313t471ab0b2n5856db7bf8db55e6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha priya gupta <harshapriya@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Jun 2008, Harsha priya gupta wrote:

> Hi,
> 
> In my driver, i see that first my copy function is called some 4 times. Then
> my timer starts (when trigger->start is reached). In my timer function,
> snd_pcm_period_elapsed is called after the period is considered to be
> processed by hardware. Everytime the period_elapsed function is called,
> inturn my pointer function is called but i get the following error. can
> anyone help as to what i am missing to do?
> 
> aplay: pcm_write:1266: write error: Input/output error
> 
> Can anyone hint me what i am doing wrong?

The pointer function probably returns invalid value.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
