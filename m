From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: defaults.pcm.minperiodtime 5000
Date: Thu, 12 Aug 2010 08:27:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008120822420.10278@eeebox2.perex-int.cz>
References: <AANLkTinW0tbBLOczuTY=2p2+EZQrqBAFdEHdLeOFX8y5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 61FF0243AF
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 08:27:24 +0200 (CEST)
In-Reply-To: <AANLkTinW0tbBLOczuTY=2p2+EZQrqBAFdEHdLeOFX8y5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Aug 2010, Raymond Yau wrote:

> It seem that there is a bug in the patch which remove "if ( err < 0 )"
>
>
> -       if (err < 0)
>                return err;
> +       if (pcm->minperiodtime > 0) {

Thanks. It's usuall typo. Fixed now.

> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=09879a4bb58199f64abcb8df506f917c8efc2383;hp=e6d5dcf1f625984605d362338d71162de45a6c60
>
> BTW , it seem this patch change the behaviour of alsa-lib too.
>
> all sound cards will now have a minperiodtime 5000

Nope. If application settles the period time/size, the behaviour is 
unchanged (see the min/max condition). We just want to limit the period 
sizes for applications which do not know what they are doing and allow 
any period time/sizes. It's better to limit the minimal period size to 
avoid generation of many interrupts per second in this case.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
