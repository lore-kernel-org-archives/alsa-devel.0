From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: When to start the capture device?
Date: Thu, 20 Sep 2007 11:46:12 -0400
Message-ID: <20070920114612.27b70757.alsauser@pragmasoft.com>
References: <005101c7fb13$511e5040$aea4c380@dream.eng.uci.edu>
	<20070920101427.2499dd58.alsauser@pragmasoft.com>
	<s5h1wctquu5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7.server.rpi.edu (smtp7.server.rpi.edu [128.113.2.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C02E24475
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 17:40:50 +0200 (CEST)
Received: from RPI02.localdomain (voiceflight.inc.rpi.edu [128.113.36.139])
	by smtp7.server.rpi.edu (8.13.1/8.13.1) with SMTP id l8KFemWj002894
	for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2007 11:40:49 -0400
In-Reply-To: <s5h1wctquu5.wl%tiwai@suse.de>
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

On Thu, 20 Sep 2007 16:23:30 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> snd_pcm_prepare() is required to recover the stream from XRUN or any
> other errors.  But, for the recovery purpose, we have now
> snd_pcm_recover() as a generic solution, too.

It appears that (currently) the additional benefit of snd_pcm_recover
is simply that of resuming the stream.  However, I haven't seen any
details on when/why a stream would become suspened and require this
type of recovery.

Also, in SALSA, it appears that snd_pcm_recover can -block- even if
the stream has been configured for non-blocking behavior.
