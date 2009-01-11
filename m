From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] wss-lib: move AD1845 frequency setting
 into wss-lib
Date: Sun, 11 Jan 2009 17:10:09 +0100
Message-ID: <20090111171009.ff1a352f.krzysztof.h1@poczta.fm>
References: <20090109231052.606a5497.krzysztof.h1@poczta.fm>
	<20090111044812.64596072.krzysztof.h1@poczta.fm>
	<s5hk5922gcf.wl%tiwai@suse.de>
	<36A813B2-427C-449D-8CD5-889024DEE271@hws.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 530E61037F8
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2009 17:07:46 +0100 (CET)
In-Reply-To: <36A813B2-427C-449D-8CD5-889024DEE271@hws.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Theodore J. Allen" <tjallen@hws.edu>
Cc: Takashi Iwai <tiwai@suse.de>, Theodore Allen <allen@hws.edu>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 11 Jan 2009 08:28:13 -0500
"Theodore J. Allen" <tjallen@hws.edu> wrote:

> The Soundscape Elite does work, but after a reboot
> I noticed that there is an oddness in that there's
> a little "pop" before playing sounds with aplay and
> a series of short spike pops before the sound plays
> with xmms, which uses the old oss interface.
> 

This is imperfection of early codecs. Sequences
for changing sound format and rate are not yet
perfect enough to avoid these "pops". Newer codecs
mutes sound during such changes to avoid pops 
e.g. Soundscape VIVO with AD1845 does not
produce "pops" before playing sounds.

This is something of low priority and hard to master 
(guess) so do not expect solution soon.

Regards,
Krzysztof

----------------------------------------------------------------------
Szef przynudza? Zagraj sobie! 
Kliknij >>  http://link.interia.pl/f200e 
