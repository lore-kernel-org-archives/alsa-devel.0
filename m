From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Tue, 6 Apr 2010 08:07:08 +0800
Message-ID: <h2m4f3252891004051707jc457b7fan4b04978623e4076e@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DFFAA103849
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 02:07:09 +0200 (CEST)
Received: by pwj7 with SMTP id 7so3137923pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Apr 2010 17:07:08 -0700 (PDT)
In-Reply-To: <hp744t$5b5$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/3 Colin Guthrie <gmane@colin.guthr.ie>

>
>
> FWIW, I've got the same/similar h/w with a cutoff at 14% in PA as you
> have. I've been meaning to get this fixed for a while, but I'm
> incredibly lazy with certain things that don't bother me practically, so
> haven't followed it up yet.
>
> Thanks for getting the ball rolling :)
>
> If any specific debug is needed here, feel free to ask.
>
> Col
>
> for debugging  , please post the output of alsa-info.sh of your hardware
and output of "amixer -D pulse" when you change the volume control  to 0% by
"alsamixer -c 0"
