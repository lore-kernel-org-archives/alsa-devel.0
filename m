From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Input/output error while playing a file using aplay
Date: Mon, 25 Jun 2007 08:56:37 +0200
Message-ID: <1182754597.9211.1196859135@webmail.messagingengine.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id CA52524363
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 08:56:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> ...
> It waits here for sometime and then I get
> snd_omap_alsa_trigger starte error: Input/output error

The ALSA framework will stop the stream and return the error code EIO
when there was no interrupt for ten seconds, i.e., when
snd_pcm_period_elapsed() was not called.

Either s->active got corrupted, or your interrupt handler never got
called.

BTW: snd_pcm_period_elapsed() can stop the stream in some situations,
so you should move this call to the end of the interrupt handler, or
check s->active again after calling it.


HTH
Clemens
