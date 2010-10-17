From: James Huk <huk256@gmail.com>
Subject: Re: [PATCH] Per Application Volume Control plugin for
	ALSA
Date: Sun, 17 Oct 2010 23:54:22 +0200
Message-ID: <AANLkTimZgTBaGyK=g5UTkHQ--e=Q5ZpONrrB-7wk8pOp@mail.gmail.com>
References: <AANLkTikq=9HHQgsdK6CJfNfdOnX5xkBgcLTLrS_Y7Fv8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id C65B6243FF
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 23:54:23 +0200 (CEST)
Received: by vws17 with SMTP id 17so157116vws.38
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2010 14:54:23 -0700 (PDT)
In-Reply-To: <AANLkTikq=9HHQgsdK6CJfNfdOnX5xkBgcLTLrS_Y7Fv8@mail.gmail.com>
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

Thanks for the answers, everyone.

@Takashi Iwai:

> Though, this implementation is a bit too hackish, especially the part
> using pipe & co.  If we have a more simpler and cleaner way for this,
> it's worth including to the standard plugin, I think.

Yes, I agree. I know I should probably used fork() and exec() instead.
I must honestly say, I'm not that experienced with C and pipe simply
worked (actually, first implementation used "system()" instead, but it
didn't work well with some applications). I'm already thinking of
rewriting this a little (this may take a while though, because I have
no time right now) - any suggestions are welcome of course.

@Raymond Yau:

> does dmix allow an application open at least 16 voices ?

I think dmix allows much more than that, if your PC can handle it.

@Colin Guthrie:

> Is there a specific use case targeted with this patch or is it really
> just a "proof of concept" demonstration that alsa can do this sans PA?

Before I written this plugin I tried to use PulseAudio -
unfortunately, applications I use didn't worked to well with it so I
had to get rid of it, however I liked the idea of PAVC. Then I tried
OSS4 but again - unfortunately it doesn't support my ALC1200 too well
(interesting info for those out there who says "Get rid of ALSA, get
rid of PA, install OSS4 because it just works" well, not always guys -
this time ALSA is the winner - this is not intended as a flame-war
starter, just as information). Finally I found "copy" plugin for ALSA,
started to tamper with it a bit, and found out that writing PAVC
plugin wouldn't be, all that hard. I created this because I liked this
feature on PA and OSS4 and ALSA lacked it - nothing more to this, than
that.

P.S

Sorry for my English.
