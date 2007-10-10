From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Creative Labs XFi drivers.
Date: Wed, 10 Oct 2007 16:59:23 +0100
Message-ID: <470CF6DB.1070602@superbug.co.uk>
References: <1190870997.30667.140.camel@razman.gruemaster.com>	<1190877072.11003.1212854455@webmail.messagingengine.com>
	<s5hprzns64b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net
	[194.217.242.92])
	by alsa0.perex.cz (Postfix) with ESMTP id EA8331037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Oct 2007 17:59:37 +0200 (CEST)
In-Reply-To: <s5hprzns64b.wl%tiwai@suse.de>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> We may change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL.  But, it's again the
> same game.  You can write a GPL driver that simply bridges the
> GPL-exported interface to others.
>
> BTW, I heard some of X-Fi being HD-audio.  Is it true?
>
>   

What do you mean? HD-audio.
Some of the X-Fi range are just rebadged SB-Live-24bit, so work with the 
snd-ca0106 driver, that outputs 24bit audio, so might be considered 
HD-audio, but not using the intel hd standard.

James
