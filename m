From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: intel 8x0 ALSA driver in virtualbox - choppy sound
Date: Fri, 13 Aug 2010 17:19:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008131718300.10278@eeebox2.perex-int.cz>
References: <AANLkTimduCOUeqdd=M6q7Qf6m55Q_8yn9EXQfROQJ4Gh@mail.gmail.com>
	<AANLkTi=DVX6iSTXzT3WMqYC_RViqbOWe7gFn+h6Kow8u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 037AA103850
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 17:19:11 +0200 (CEST)
In-Reply-To: <AANLkTi=DVX6iSTXzT3WMqYC_RViqbOWe7gFn+h6Kow8u@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lex F <archguest@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Aug 2010, Lex F wrote:

> Dear all
>
> I am having problems with getting sound running well in Arch Linux
> guest (VirtualBox 3.2.8), the host is OS X Snow Leopard. The problem
> is that the sound is very choppy. I've checked around VirtualBox and
> Arch forums and it seems that some others experience these problems as
> well yet I could not see anyone sufficiently skilled to debug this
> paying attention. I think there is a problem with either VirtualBox
> implementation of the sound card or a bug in ALSA driver for that card
> because I have sound running just fine in VMWare Fusion (using es1371
> (?) driver), so the host system definitely is fast enough for decent
> sound quality.
>
> I would like to offer my help with identifying the cause of the
> problem and testing solutions if the need be.
>
> I've attached my alsa-info output for your reference. Please let me
> know if there is anything else I could try to help.
>
> I am very keen to help but I don't know how.

http://www.alsa-project.org/main/index.php/XRUN_Debug is a good start to 
see if the virtual machine does receive interrupts in the right time.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
