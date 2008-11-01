From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: Bug in sound-unstable-2.6 ice1724
Date: Sat, 1 Nov 2008 19:08:59 +0200
Message-ID: <200811011808.59462.fzu@wemgehoertderstaat.de>
References: <fd3eb9bf0810190236r68dc5f0bvc948acd5c6904810@mail.gmail.com>
	<fd3eb9bf0810260931g716855b6tf00181f39baf584e@mail.gmail.com>
	<s5hfxmjxbd6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AC621037F2
	for <alsa-devel@alsa-project.org>; Sat,  1 Nov 2008 18:08:54 +0100 (CET)
In-Reply-To: <s5hfxmjxbd6.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Vedran =?utf-8?q?Mileti=C4=87?= <rivanvx@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Am Sonntag, 26. Oktober 2008 schrieb Takashi Iwai:
> At Sun, 26 Oct 2008 17:31:02 +0100,
> =?UTF-8?Q?Vedran_Mileti=C4=87?= wrote:
> > 
> > Yeap, that one does it. No need to revert it fully, though. I just
> > uncommented the unsigned char mask line and removed that #if 0 and
> > #endif. Now it works perfectly. Thanks! Can you fix it in your tree?
> 
> Well, before doing that, I'd like to understand the problem more.
> 
> If the problem is about the initial IRQ mask value, setting 0 should
> work as well.
> Could you change the code just to do like below, and check whether it
> works?
> 	outb(0, ICEREG1724(ice, IRQMASK));

Makes a pc hang sometimes here, while reverting the entire patch is stable.
no midi tested though, only audio.

Thanks,
Karsten
