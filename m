From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: Re: Loop sequencer
Date: Sun, 6 Apr 2008 08:52:50 -0400
Message-ID: <17eedd8a0804060552jd434f28ha2bdd01519f6cbb2@mail.gmail.com>
References: <c60df1300803280026p18a09024v6164d616bea1b5c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 3011024518
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Apr 2008 14:52:52 +0200 (CEST)
Received: by el-out-1112.google.com with SMTP id m34so536172ele.21
	for <alsa-devel@alsa-project.org>; Sun, 06 Apr 2008 05:52:50 -0700 (PDT)
In-Reply-To: <c60df1300803280026p18a09024v6164d616bea1b5c1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Guillaume_Dupr=E9?= <gui.dupre@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 28, 2008 at 3:26 AM, Guillaume Dupr=E9 <gui.dupre@gmail.com> wr=
ote:
> Hello
>  I try to program a loop midi sequencer with libasound .
>  For the moment, I have this :

Hi!

[...]
>  sleep(4) ;

use snd_seq_sync_output_queue() instead.

>  It works, no problem .
>  But now, I want to do a loop with my two notes .
>  I searched on the Internet but I didn't find .

I guess there is no loop helpers in alsa-lib. You must make your own.

Check how other looping software is doing. I think you could do
something like a function that receives a loop sequence (array of
events sorted by time), a time (or tick) and a max time or max events.

int dump_loop(events[], base_time, max_time);

This function should put the appropiate event from the events[] based
on the time frame and up to the max_time or max_events.

HTH,
-- =

Aldrin Martoq
Episodio 002 (Lunes 24 Marzo)!
http://aldrinvideopodcast.podshow.com/
