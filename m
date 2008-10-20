From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Tue, 21 Oct 2008 01:51:57 +0400
Message-ID: <48FCFD7D.6000001@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>	<s5hve1ac05g.wl%tiwai@suse.de>	<4831B260.1060802@aknet.ru>	<s5hhccrx2ey.wl%tiwai@suse.de>	<4835D774.3070306@aknet.ru>	<s5hprrduwdk.wl%tiwai@suse.de>	<483C10E7.7070203@aknet.ru>	<s5h4p8jbvaj.wl%tiwai@suse.de>	<48AD21EF.8010906@aknet.ru>	<s5hej4ibuus.wl%tiwai@suse.de>	<48AD42A0.9030509@aknet.ru>
	<s5hzlkz4dsl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id AE63D24645
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 23:49:19 +0200 (CEST)
In-Reply-To: <s5hzlkz4dsl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.

Takashi Iwai wrote:
> Indeed, the async trigger is nice to have in the common place.
> However, the change wouldn't be as trivial as it sounds, as you
> mentioned.  By async nature, there can be a transition phase between
> the XRUN and STOP, which can cause races.
Could you please elaborate on how my
proposed patch could possibly affect
that? It basically doesn't do anything
at all except providing one more callback
for what would otherwise had to be done
in a trigger() callback anyway.
If there is a race with that patch, then
I pretty much suspect it was with an old
code too. I can't imagine any possible
change. What have changed?
