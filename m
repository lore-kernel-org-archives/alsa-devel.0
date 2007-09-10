From: Rene Herman <rene.herman@gmail.com>
Subject: Re: tiwai long downtime in this week
Date: Tue, 11 Sep 2007 00:03:54 +0200
Message-ID: <46E5BF4A.7000509@gmail.com>
References: <s5h7imyqjqq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id C504B103885
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 00:10:56 +0200 (CEST)
In-Reply-To: <s5h7imyqjqq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/10/2007 11:43 PM, Takashi Iwai wrote:

> I'm attending a conference during this week, so I won't be able to
> read/post this ML so often.  If you need some patches for urgent
> review or merge, please add my address to Cc.

Does this mean it might be better to delay the impending 1.0.15 for 1 more 
week? You're sort of vital to this ALSA thingy...

Also, although I don't care deeply, I'd also sort of like to get the new 
Sound Galaxy driver in there and while all the AZT2316 cards are fully 
functional, AZT1605 is giving me a little grief. The configuration part of 
its EEPROM is mapped out and the driver is working well, but I haven't yet 
found a way to know which one of the two I'm looking at runtime and I need 
to know that to know what configuration register layout I need to use.

The simplest way might in fact be to introduce sound/isa/galaxy/ and provide 
seperate snd-azt1605 and snd-azt2316 drivers that just share a lot of code 
through a common galaxy.c (and then just move over snd-azt2320 to there as 
well ofcourse).

Mmmm.

Rene.
