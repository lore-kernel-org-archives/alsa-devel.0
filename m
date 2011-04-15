From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: aplay patch to add a --seek parameter
Date: Sat, 16 Apr 2011 06:46:46 +0800
Message-ID: <BANLkTin-Qkno8JMKranOoY9Uaz+U9JW7Cw@mail.gmail.com>
References: <m38vvc9ypf.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 471551037EC
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Apr 2011 00:46:47 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2529363fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 15:46:46 -0700 (PDT)
In-Reply-To: <m38vvc9ypf.fsf@quimbies.gnus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/4/15 Lars Magne Ingebrigtsen <larsi@gnus.org>

> I'm using aplay in a sound editor to play PCM files.  But I need to be
> able to say "start playing at point X" to be able to skip around in the
> file.
>
> I've used the following patch for years, but I think I forgot to submit
> it for inclusion into alsa-utils.
>
> it depend on X is byte or frame

when X is an odd number and the format is S16_LE , aplay just produce noise
