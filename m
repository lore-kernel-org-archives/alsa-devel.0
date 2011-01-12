From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Adding a "capture" device naming scheme
Date: Wed, 12 Jan 2011 09:08:37 +0800
Message-ID: <AANLkTikGo8FMVf_9UMBa+iOhgXXdtWFdePk_7=6zwDhA@mail.gmail.com>
References: <igi861$q8o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DF9831038C0
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 02:08:37 +0100 (CET)
Received: by ewy19 with SMTP id 19so25381ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:08:37 -0800 (PST)
In-Reply-To: <igi861$q8o$1@dough.gmane.org>
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

2011/1/12 Colin Guthrie <gmane@colin.guthr.ie>

> Hi,
>
> As has been pointed out a few times, it's incorrect to use "front:" for
> capture, but can we have an official name/wrapper (I'm unsure of the
> terminology here) for this so we don't use hw: for recording?
>
> I'd be in favour of "capture:" or "input:" as these both seem quite
> logical and easy to understand.
>
> It would be used thusly:
>
>  arecord -f S16_LE -c 2 -D capture:CARD=Intel
>
> as opposed to the incorrect:
>  arecord -f S16_LE -c 2 -D front:CARD=Intel
> or the low level:
>  arecord -f S16_LE -c 2 -D hw:CARD=Intel
>

why do you think that it is incorrect to use hw:CARD=xxx for analog capture
?

since you need the low level to handle the phase inversion of the stereo mic

if you don't like the "plug" plugin , you will also don't like the "route"
plugin too

alsa-lib still use the sound card's default device if the linux distribution
does not override  pcm.!default by pulse ,
